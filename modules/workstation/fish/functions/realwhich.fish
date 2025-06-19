function realwhich --description 'which + realpath' --wraps which
    realpath (which $argv)
end
