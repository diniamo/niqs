function copyfile --description 'copy the contents of a file' --argument-names file
    if [ -f $file -a -r $file ]
        cat $file | wl-copy
    else
        echo "$file doesn't exist or cannot be read"
        return 1
    end
end
