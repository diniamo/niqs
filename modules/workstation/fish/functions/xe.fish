function xe --description 'make file executable and edit it'
    for file in $argv
        if [ -f $file ]
            chmod +x $file
        else
            install /dev/null $file
        end
    end

    $EDITOR -- $argv
end
