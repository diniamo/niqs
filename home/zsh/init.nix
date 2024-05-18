{
  programs.zsh = {
    # TODO: proper login manager
    initExtraFirst = ''
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)

      # This is needed because otherwise, keybinds (from other plugins too) are overwritten, and it's hard to get around that
      ZVM_INIT_MODE="sourcing"
    '';

    initExtra = ''
      setopt autocd correct histreduceblanks longlistjobs interactivecomments nohistbeep nobeep

      zstyle ':completion:*' menu no
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':fzf-tab:*' fzf-min-height 15

      autoload -Uz up-line-or-beginning-search && zle -N up-line-or-beginning-search
      autoload -Uz down-line-or-beginning-search && zle -N down-line-or-beginning-search

      bindkey "^@" autosuggest-execute
      bindkey "^K" up-line-or-beginning-search
      bindkey "^J" down-line-or-beginning-search
      bindkey -M vicmd "^@" autosuggest-execute
      bindkey -M vicmd "k" up-line-or-beginning-search
      bindkey -M vicmd "j" down-line-or-beginning-search

      bindkey "^U" kill-whole-line
      bindkey "^H" backward-kill-word
      bindkey "^[[3;5~" kill-word
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word

      __fancy_ctrl_z() {
        if [[ $#BUFFER -eq 0 ]]; then
          BUFFER="fg"
          zle accept-line -w
        else
          zle push-input -w
          zle clear-screen -w
        fi
      }
      zle -N __fancy_ctrl_z && bindkey '^Z' __fancy_ctrl_z

      ${builtins.readFile ./functions.zsh}
    '';
  };
}
