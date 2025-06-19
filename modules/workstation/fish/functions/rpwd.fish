function rpwd --description='rename current directory' --argument-names to
    set -f dir (basename $PWD)
    cd ..
    mv $dir $to
    cd $to
end
