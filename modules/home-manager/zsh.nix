{ config, ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      build = "nixos-rebuild build";
      update = "sudo nixos-rebuild switch --recreate-lock-file";
      switch = "sudo nixos-rebuild switch";
      test = "sudo nixos-rebuild test";
      # tmux
      ta = "tmux attach";
    };

    initContent = ''
      build-vm() {
        (cd "$\{$(readlink -f /etc/nixos/flake.nix)%/*\}" && nix build .#vm && ./result/bin/run-$(hostname)-vm)
      }
      dev() {
        # --impure to enable version selection
        NIXPKGS_COMMIT="$2" SHELL=$(which zsh) nix develop --impure $(readlink -f /etc/nixos/flake.nix)#$1 --command zsh
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
