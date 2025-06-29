function fix-hash --description 'extract required hash from a failing Nix command, and replace the empty hash with it'
    set -f output (script --quiet --command "$argv" /dev/null &| tee /dev/stderr | string split0)
    echo
    if set -f hash (_extract_nix_hash $output)
        rg --type nix '[hH]ash\s*=\s*""' --json | jq --raw-output 'select(.type == "match") | "\(.data.path.text)	\(.data.line_number)"' | while read --delimiter '	' -l path line
            set -fa paths $path
            set -fa lines $line
        end

        set -f count (count $paths)
        if [ $count -gt 0 ]
            if [ $count -gt 1 ]
                for i in (seq $count)
                    echo -n [
                    set_color --bold; echo -n $i; set_color normal
                    echo "] $paths[$i]"
                end
                read -l answer --prompt-str 'Multiple empty hashes found. Which one would you like to replace? '
                commandline --function repaint # Read messes up my actual prompt for some reason

                if not set -q paths[$answer] 2>/dev/null
                    set_color --bold red; echo "Invalid choice: $answer"; set_color normal
                    return 1
                end
                set -f paths $paths[$answer]
                set -f lines $lines[$answer]
            end

            echo -n 'Replacing empty hash in '
            set_color --bold; echo $paths; set_color normal
            sed -i $lines"s|\([hH]ash[[:space:]]*=[[:space:]]*\"\)|\1$hash|" $paths
        else
            set_color yellow; echo 'Failed to find location, falling back to copy'; set_color normal
            echo "Copying $hash"
            echo -n $hash | wl-copy
        end
    else
        set_color --bold red; echo 'No hash in output'; set_color normal
        return 1
    end
end
