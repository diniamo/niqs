function se --description 'edit files that aren't writable'
    for file in $argv
        [ -f $file -a ! -w $file ] && set -fa cond $file
    end

    con $cond
    $EDITOR -- $argv
    dec $cond
end
