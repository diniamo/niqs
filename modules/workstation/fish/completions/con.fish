function _complete_con
    set -f files */
    for file in *
        test ! -d $file -a ! -e $file.pure
        and string match --quiet --entire -- '*.pure' $file
        or set -fa files $file
    end

    string collect -- $files
end

complete --command con --no-files --arguments '(_complete_con)'
