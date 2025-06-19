function yazi --description 'go to yazi directory' --wraps yazi
    set -f tmp (mktemp)
    command yazi $argv --cwd-file=$tmp
    set -f dir (cat $tmp)
    [ -n $dir -a $dir != $PWD ] && cd $dir
    rm $tmp
end
