{ ... }:

{
  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      build = "sudo nixos-rebuild test";
      switch = "sudo nixos-rebuild switch";
      update = "sudo nixos-rebuild switch --recreate-lock-file";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "colored-man-pages"
        "deno"
        "direnv"
        "docker"
        "doctl"
        "gh"
        "git"
        "kubectl"
        "podman"
        "rust"
        "ssh"
        "sudo"
        "tmux"
      ];
    };
  };
}
