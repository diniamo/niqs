function se --description 'edit non-writable files'
    for file in $argv
        [ -f $file -a ! -w $file ] && set -fa cond $file
    end

    con $cond
    $EDITOR -- $argv
    dec $cond
end
