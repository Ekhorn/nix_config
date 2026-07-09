{ config, ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    enableCompletion = true;
    history.ignoreSpace = false;
    syntaxHighlighting.enable = true;

    shellAliases = {
      build = "nixos-rebuild build";
      update = "sudo nixos-rebuild switch --recreate-lock-file";
      switch = "sudo nixos-rebuild switch";
      test = "sudo nixos-rebuild test";
      ta = "tmux attach";
      zed = "zeditor";
      dbd = "dev-box-diff";
    };

    initContent =
      let
        guestDiffCmd = colorize: ''git --no-pager -C "$(cat .last_dir)" diff --color=${colorize}'';
      in
      ''
        build-vm() {
          (cd "''${$(readlink -f /etc/nixos/flake.nix)%/*}" && nix build .#$1 && ./result/bin/run-$1-vm)
        }
        dev() {
          SHELL=$(which zsh) nix develop $(readlink -f /etc/nixos/flake.nix)#$1 --command zsh
        }
        clean() {
          # https://github.com/NixOS/nix/issues/8508#issuecomment-2808614321
          user_profiles_garbage="/run/current-system/sw/bin/nix-collect-garbage"
          if [ -z "$1" ]; then
            sudo nix-collect-garbage -d
            "$user_profiles_garbage" -d
          else
            sudo nix-collect-garbage --delete-older-than "$1"
            "$user_profiles_garbage" --delete-older-than "$1"
          fi
        }
        dev-box-diff() {
          if [ -t 1 ]; then
            ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR \
                -p 2222 root@localhost '${guestDiffCmd "always"}' "$@" | less -R
          else
            ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR \
                -p 2222 root@localhost '${guestDiffCmd "never"}' "$@"
          fi
        }
        gradle() {
          local git_root
          if git_root=$(git rev-parse --show-toplevel 2>/dev/null); then
            if [[ -x "$git_root/gradlew" ]]; then
              echo "Using repo gradlew ($git_root/gradlew)"
              "$git_root/gradlew" "$@"
              return
            fi
          fi
          # Fallback: Use the system-wide gradle command if not in a repo
          # or if gradlew doesn't exist.
          # 'command' prevents an infinite loop of calling this function.
          command gradle "$@"
        }
      '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "colored-man-pages"
        "deno"
        "direnv"
        "docker"
        # "doctl"
        "gh"
        "kubectl"
        "podman"
        "rust"
        "ssh"
      ];
    };
  };
}
