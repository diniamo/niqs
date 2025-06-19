function fish_user_key_bindings
    bind ctrl-shift-backspace kill-whole-line
    bind ctrl-alt-_ redo

    bind alt-n history-prefix-search-forward
    bind alt-p history-prefix-search-backward

    bind ctrl-space accept-autosuggestion and execute
    bind ctrl-enter 'if [ -z (string trim (commandline)) ]; commandline $history[1] && commandline -f execute; end'
    bind tab 'if commandline -P; commandline -f complete; else; commandline -f complete-and-search; end'
end
