function dec --description 'restore the original file moved by con'
    for file in $argv
        if [ -f $file.pure ]
            echo "Decontaminating $file"
            mv $file.pure $file
        else
            echo "$file is not contaminated"
        end
    end
end
