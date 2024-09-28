{
  programs.fish.functions.fish_user_key_bindings = ''
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase
    set -g fish_key_bindings fish_vi_key_bindings

    bind -M insert \cu kill-whole-line

    bind -M insert \b backward-kill-word
    bind -M insert \e\[3\;5~ kill-word

    bind -M insert -k nul accept-autosuggestion execute

    bind -M insert \e\[B history-search-forward
    bind -M insert \e\[A history-search-backward
    bind -M insert \n history-prefix-search-forward
    bind -M insert \ck history-prefix-search-backward
    bind -M insert \ej history-token-search-forward
    bind -M insert \ek history-token-search-backward

    bind -M insert \t 'if commandline -P; commandline -f complete; else; commandline -f complete-and-search; end'
    bind -M insert \e\[Z complete-and-search
  '';
}
