function copypath --description 'copy the path of a file' --argument-names path
    if set -q path
        set path (realpath -s $path)
        echo "Copying $path"
        echo -n $path | wl-copy
    else
        echo "Copying $PWD"
        pwd | wl-copy
    end
end
