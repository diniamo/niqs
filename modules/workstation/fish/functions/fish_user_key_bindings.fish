m.
function fish_user_key_bindings
    bind ctrl-shift-backspace kill-whole-line
    bind ctrl-alt-_ redo

    # ctrl-r is bound to that by default, but this is a massive Nix moment.
    # The fzf integration is vendored in the fzf package, so Fish loads the
    bind ctrl-r history-pager
    bind alt-n history-prefix-search-forward
    bind alt-p history-prefix-search-backward

    bind ctrl-space accept-autosuggestion and execute
    bind tab 'if commandline -P; commandline -f complete; else; commandline -f complete-and-search; end'
end
