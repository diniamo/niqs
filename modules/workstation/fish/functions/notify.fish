function notify --description 'show notification after executing a command'
    $argv
    notify-send --icon dialog-information --expire-time 0 Shell "$argv[1] exited with code $status"
end
