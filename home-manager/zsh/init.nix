{
  programs.zsh = {
    # TODO: proper login manager
    initExtraFirst = ''
      [[ "$(tty)" == "/dev/tty1" ]] && exec Hyprland

      ZSH_AUTOSUGGEST_STRATEGY=(history completion)

      # This is needed because otherwise, keybinds (from other plugins too) are overwritten, and it's hard to get around that
      ZVM_INIT_MODE="sourcing"
    '';

    initExtra = ''
      setopt AUTO_CD CORRECT HIST_REDUCE_BLANKS NOTIFY LONG_LIST_JOBS INTERACTIVE_COMMENTS
      unsetopt BEEP HIST_BEEP

      zstyle ':completion:*' menu no
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':fzf-tab:*' fzf-min-height 15

      autoload -Uz up-line-or-beginning-search
      autoload -Uz down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search

      bindkey "^U" kill-whole-line
      bindkey "^H" backward-kill-word
      bindkey "^[[3;5~" kill-word

      bindkey "^@" autosuggest-execute
      bindkey "^K" up-line-or-beginning-search
      bindkey "^J" down-line-or-beginning-search
      bindkey -M vicmd "^@" autosuggest-execute
      bindkey -M vicmd "k" up-line-or-beginning-search
      bindkey -M vicmd "j" down-line-or-beginning-search

      # Can't have these in shellAliases due to escaping
      alias -s git="git clone"

      ${builtins.readFile ./funcs.zsh}
    '';
  };
}
