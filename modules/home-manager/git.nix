{ ... }:

{
  programs.git = {
    enable = true;

    aliases = {
      amend = "commit --amend --no-edit";
      continue = "!f() { \
        repo=$(git rev-parse --git-dir)
        for file in rebase-merge rebase-apply MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD AM_HEAD; do
          [ -e \"$repo/$file\" ] && { cmd=\"\${file%[-_]*}\"; cmd=\"\${cmd,,}\"; git \${cmd//_/-} --continue; break; }
        done;
      }; f";
      l = "log --stat --pretty=format:'%C(yellow)%h%Creset %Cgreen%cr%Creset %Cblue%an%Creset%C(auto)%d%Creset %s'";
      ls = "!git log --stat --pretty=format:'%C(yellow)%h%Creset %Cgreen%cr%Creset %Cblue%an%Creset%C(auto)%d%Creset %s' $(git merge-base origin HEAD)..HEAD";
      sum = "!git diff --oneline --stat $(git merge-base origin HEAD)..HEAD";
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
