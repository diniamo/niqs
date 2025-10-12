function yazi --wraps yazi --description 'run yazi and cd to the final directory'
    set -l cwd_file (mktemp)
    command yazi $argv --cwd-file $cwd_file
    set -l cwd (cat $cwd_file)
    [ -n "$cwd" -a "$cwd" != $PWD ] && cd $cwd
    rm $cwd_file
end
