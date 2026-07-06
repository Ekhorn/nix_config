{
  pkgs,
  system,
  microvm,
  nixosSystem,
}:

let
  zed-deps = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
    libgcc
  ];

  dev-vm = nixosSystem {
    inherit system;
    modules = [
      microvm.nixosModules.microvm
      {
        networking.hostName = "dev-vm";

        microvm = {
          hypervisor = "qemu";
          volumes = [
            {
              mountPoint = "/root";
              image = "dev-vm-root.img";
              size = 10240; # 10GB
            }
          ];
          shares = [
            {
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "9p";
            }
          ];
          interfaces = [
            {
              type = "user";
              id = "qemu";
              mac = "02:00:00:00:00:01";
            }
          ];
          forwardPorts = [
            {
              from = "host";
              host.port = 2222;
              guest.port = 22;
            }
          ];
        };

        environment.systemPackages = with pkgs; [
          busybox
          fd
          gitMinimal
          nix
          nix-ld
          ripgrep
          zsh
          oh-my-zsh
          direnv
        ];

        programs.nix-ld.enable = true;
        programs.nix-ld.libraries = zed-deps;

        services.openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "yes";
            PermitEmptyPasswords = "yes";
            PasswordAuthentication = true;
            UsePAM = false;
          };
          extraConfig = ''
            AuthenticationMethods none
            ChrootDirectory none
            SetEnv NIXPKGS_ALLOW_UNFREE=1
          '';
        };

        programs.zsh = {
          enable = true;
          ohMyZsh = {
            enable = true;
            plugins = [
              "git"
              "direnv"
            ];
            theme = "robbyrussell";
          };
          interactiveShellInit = ''
            export ZSH_CACHE_DIR="/tmp/oh-my-zsh-cache"
            mkdir -p "$ZSH_CACHE_DIR"
            source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
            source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          '';
        };
        users.users.root = {
          shell = pkgs.zsh;
          hashedPassword = ""; # empty password to unlock the account
        };

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
        nix.settings.sandbox = false;

        system.stateVersion = "26.05";
      }
    ];
  };

  runner = dev-vm.config.microvm.declaredRunner;

  dev-vm-script = pkgs.writeShellScriptBin "dev-vm" ''
    VOL_IMAGE="dev-vm-root.img"
    REPO_URL=""
    CLEAN_FIRST=false

    for arg in "$@"; do
      case $arg in
        --clean) CLEAN_FIRST=true ;;
        http*) REPO_URL="$arg" ;;
        *) ;;
      esac
    done

    if [ "$CLEAN_FIRST" = true ]; then
      rm -f "$VOL_IMAGE"
      ssh-keygen -R "[localhost]:2222" 2>/dev/null || true
    fi

    # Start VM in background
    ${runner}/bin/microvm-run &
    VM_PID=$!

    # Wait for SSH to be ready
    while ! ssh -o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 root@localhost true 2>/dev/null; do
      sleep 0.5
    done

    # Clone repo if provided
    if [ -n "$REPO_URL" ]; then
      REPO_NAME=$(basename "$REPO_URL" .git)
      TARGET_DIR="/root/$REPO_NAME"
      ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 root@localhost "
        if [ ! -d \"$TARGET_DIR\" ]; then
          git clone \"$REPO_URL\" \"$TARGET_DIR\"
        fi
        echo \"$TARGET_DIR\" > /root/.last_dir
      "
    fi

    TARGET_DIR=$(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2222 root@localhost cat /root/.last_dir 2>/dev/null || echo /root)
    ZED_CMD=$(command -v zeditor)
    if [ -n "$ZED_CMD" ]; then
      "$ZED_CMD" "ssh://root@localhost:2222$TARGET_DIR"
    fi

    wait $VM_PID
  '';
in
pkgs.symlinkJoin {
  name = "dev-vm-package";
  paths = [ dev-vm-script ];
}
