function _complete_pkgpath
    set -f token (commandline --current-token)
    [ -n $token ] && complete --do-complete "nix shell $token"
end

complete --command pkgpath --no-files --arguments '(_complete_pkgpath)'
