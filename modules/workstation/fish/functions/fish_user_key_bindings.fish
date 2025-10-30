function fish_user_key_bindings
    bind ctrl-z fg
    bind --erase ctrl-shift-z
    bind ctrl-y undo
    bind ctrl-shift-y redo

    bind alt-n history-prefix-search-forward
    bind alt-p history-prefix-search-backward

    bind ctrl-g expand-abbr
    bind ctrl-space accept-autosuggestion and execute
    bind ctrl-enter 'commandline $history[1] && commandline -f execute'
    bind tab 'if commandline -P; commandline -f complete; else; commandline -f complete-and-search; end'
end
