function nix-has --description 'Check whether a store contains a specific store path' --argument-names store path
    if nix path-info --store $store $path &>/dev/null
        set_color green; echo 'Path exists in store'; set_color normal
    else
        set_color red; echo 'Path does not exist in store'; set_color normal
    end
end
