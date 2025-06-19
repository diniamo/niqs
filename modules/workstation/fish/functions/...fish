function .. --description 'go up n directories'
    if set -q argv[1]
        cd (string repeat -Nn $argv[1] ../)
    else
        cd ..
    end
end
