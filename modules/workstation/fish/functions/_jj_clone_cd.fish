function _jj_clone_cd
    echo -n "jj git clone $argv && cd $(string match -gr '/(.+)\.git$' $argv[1])"
end
