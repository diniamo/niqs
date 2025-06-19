function con --description 'temporarily subtitute a file with a writable copy of it'
    for file in $argv
        if [ -e $file.pure ]
            echo "$file is already contaminated"
        else if [ ! -f $file ]
            echo "$file is not a file or does not exist"
        else
            echo "Contaminating $file"
            mv $file $file.pure
            install -m 644 $file.pure $file
        end
    end
end
