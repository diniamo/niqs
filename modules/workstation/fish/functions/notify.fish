function notify --description 'show notification after executing a command'
    $argv
    notify-send -i dialog-information -t 0 Shell "$argv[1] exited with code $status"
end
