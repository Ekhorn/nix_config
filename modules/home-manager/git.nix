{ ... }:

{
  programs.git = {
    enable = true;

    aliases = {
      amend = "commit --amend --no-edit";
    };

    userEmail = "koen@kschellingerhout.nl";
    userName = "Ekhorn";

    signing.key = "koen@kschellingerhout.nl";
    signing.signByDefault = true;

    extraConfig = {
      core.editor = "nvim";
      credential.helper = "store";
      format.commitMessageColumns = 72;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
