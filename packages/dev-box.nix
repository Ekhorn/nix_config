{ pkgs }:

let
  zed-deps = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    curl
    # icu
    libgcc
  ];

  dev-box-image = pkgs.dockerTools.buildLayeredImage {
    name = "dev-box";
    tag = "latest";
    contents = with pkgs; [
      bashInteractive
      coreutils
      gitMinimal
      openssh
      gnugrep
      nix
      cacert
      nix-ld
      gzip
      ripgrep
      fd
    ];
    config = {
      Cmd = [
        "${pkgs.bashInteractive}/bin/bash"
        "-c"
        ''
          mkdir -p /usr/bin /bin /etc/ssh /run/sshd /var/empty /root/.ssh

          # Symlink everything including rg and fd
          for p in ${pkgs.coreutils} ${pkgs.gzip} ${pkgs.openssh} ${pkgs.gitMinimal} ${pkgs.bashInteractive} ${pkgs.ripgrep} ${pkgs.fd}; do
            for bin in $p/bin/*; do
              ln -sf "$bin" /usr/bin/
              ln -sf "$bin" /bin/
            done
          done

          if [ ! -f /etc/passwd ]; then
            # Set the home directory to /root
            echo "root:x:0:0:root:/root:/bin/bash" > /etc/passwd
            echo "root::19000:0:99999:7:::" > /etc/shadow
            echo "sshd:x:100:100:SSH Daemon:/var/empty:/bin/nologin" >> /etc/passwd
            echo "root:x:0:" > /etc/group
            echo "sshd:x:100:" >> /etc/group
          fi

          chmod 700 /var/empty

          mkdir -p /root/.ssh
          if [ ! -f /root/.ssh/ssh_host_ed25519_key ]; then
            ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f /root/.ssh/ssh_host_ed25519_key -N "" -q
          fi

          cat <<EOF > /etc/ssh/sshd_config
            Port 2222
            HostKey /root/.ssh/ssh_host_ed25519_key
            PermitRootLogin yes
            PermitEmptyPasswords yes
            PasswordAuthentication yes
            AuthenticationMethods none
            Subsystem sftp ${pkgs.openssh}/libexec/sftp-server
            # Ensure we start in /root
            ChrootDirectory none
          EOF

          exec ${pkgs.openssh}/bin/sshd -D -e
        ''
      ];
      Env = [
        "NIX_LD=${pkgs.nix-ld}/bin/nix-ld"
        "NIX_LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath zed-deps}"
        "PATH=/usr/bin:/bin"
        "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
        "HOME=/root"
      ];
    };
  };

  dev-box-script = pkgs.writeShellScriptBin "dev-box" ''
    IMAGE_PATH="${dev-box-image}"
    VOL_NAME="dev-box-data"
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
      docker rm -f dev-box 2>/dev/null || true
      docker volume rm $VOL_NAME 2>/dev/null || true
      ssh-keygen -R "[localhost]:2222" 2>/dev/null || true
    fi

    docker rm -f dev-box > /dev/null || true
    docker rmi dev-box:latest > /dev/null || true

    docker load < "$IMAGE_PATH" > /dev/null
    docker volume create $VOL_NAME > /dev/null

    docker run -d --name dev-box -p 2222:2222 -v $VOL_NAME:/root dev-box:latest > /dev/null

    if [ -n "$REPO_URL" ]; then
      # Wait for container to be ready
      while ! docker exec dev-box true 2>/dev/null; do sleep 0.1; done
      REPO_NAME=$(basename "$REPO_URL" .git)
      TARGET_DIR="/root/$REPO_NAME"
      docker exec dev-box sh -c "
        if [ ! -d \"$TARGET_DIR\" ]; then
          git clone \"$REPO_URL\" \"$TARGET_DIR\"
        fi
        echo \"$TARGET_DIR\" > /root/.last_dir
      "
    fi

    sleep 1 # Wait for SSH to be ready

    TARGET_DIR=$(docker exec dev-box cat /root/.last_dir || echo /root)
    ZED_CMD=$(command -v zeditor)
    if [ -n "$ZED_CMD" ]; then
      "$ZED_CMD" "ssh://root@localhost:2222$TARGET_DIR"
    fi
  '';
in
pkgs.symlinkJoin {
  name = "dev-box-package";
  paths = [ dev-box-script ];
}
