function eman --description 'open a man page in Emacs'
    emacs --no-window-system \
        --eval "(setq Man-notify-method 'bully)" \
        --eval "(man \"$argv\")"
end
