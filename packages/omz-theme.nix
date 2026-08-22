pkgs:
pkgs.runCommand "oh-my-zsh-custom" { } ''
  mkdir -p $out/themes

  cat > $out/themes/robbyrussell+.zsh-theme <<'EOF'
  setopt prompt_subst

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

  prompt_ssh_info() {
    if [[ -n "$SSH_CONNECTION" || -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
      echo "%{$fg_bold[yellow]%}[%m]%{$reset_color%} "
    fi
  }

  prompt_arrow() {
    echo "%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
  }

  prompt_dir() {
    echo "%{$fg[cyan]%}%c%{$reset_color%}"
  }

  PROMPT='$(prompt_ssh_info)$(prompt_arrow) $(prompt_dir) $(git_prompt_info)'
  EOF
''
