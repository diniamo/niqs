function _complete_nix_has
    set -f process (commandline --cut-at-cursor --current-process --tokens-expanded)
    [ (count $process) = 2 ] && string collect -- /nix/store/*
end

complete --command nix-has --no-files --arguments '(_complete_nix_has)'
