{
  programs.fish.functions.fish_user_key_bindings = ''
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase
    set -g fish_key_bindings fish_vi_key_bindings

    bind -M insert ctrl-u kill-whole-line

    bind -M insert ctrl-backspace backward-kill-word
    bind -M insert ctrl-delete kill-word

    bind -M default ctrl-space accept-autosuggestion execute
    bind -M insert ctrl-space accept-autosuggestion execute

    bind -M insert down history-search-forward
    bind -M insert up history-search-backward
    bind -M insert ctrl-j history-prefix-search-forward
    bind -M insert ctrl-k history-prefix-search-backward
    bind -M insert alt-j history-token-search-forward
    bind -M insert alt-k history-token-search-backward

    bind -M insert tab 'if commandline -P; commandline -f complete; else; commandline -f complete-and-search; end'
    bind -M insert shift-tab complete-and-search
  '';
}
