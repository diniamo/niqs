function clone --description 'Clone git repository' --wraps 'git clone'
    git clone $argv || return $status

    for arg in $argv
        if string match --quiet --invert -- '-*' $arg
            set -f url $arg
            break
        end
    end
    cd (basename $url .git)
end
