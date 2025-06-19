function pkgtree --description 'prints the tree of a package, extra arguments are appended to eza' --wraps pkgpath
    set -f path (pkgpath $argv[1] $argv[2..]) && eza --tree --icons --group-directories-first $path
end
