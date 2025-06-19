function _complete_dec
    set -f files */
    for file in *
        if [ ! -d $file -a -f $file.pure ]
            set -fa files $file
        end
    end

    string collect -- $files
end

complete --command dec --no-files --arguments '(_complete_dec)'
