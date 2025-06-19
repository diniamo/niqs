function pkgpath --description 'ensures the package is in the store and prints its path'
    set -f package $argv[1]
    nix shell $argv[2..] $package --command nix eval $argv[2..] --raw $package
    return $status
end
