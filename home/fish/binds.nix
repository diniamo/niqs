{
  # ctrl-r is bound to that by default, but this is a massive Nix moment.
  # I disabled the fish integration in the home-manager module, but the installed package
  # comes with a share/fish directory with the integration files also present there.
  # This ends up being loaded by the shell. The other 2 binds (ctrl-t, alt-c)
  # might be useful though, so I'll keep those.
  programs.fish.functions.fish_user_key_bindings = ''
    bind ctrl-shift-backspace kill-whole-line
    bind ctrl-alt-_ redo

    bind ctrl-r history-pager
    bind alt-n history-prefix-search-forward
    bind alt-p history-prefix-search-backward

    bind ctrl-space accept-autosuggestion and execute
    bind tab 'if commandline -P; commandline -f complete; else; commandline -f complete-and-search; end'
  '';
}
