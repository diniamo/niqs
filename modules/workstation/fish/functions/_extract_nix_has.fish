function _extract_nix_hash --description 'resolve missing hash in Nix derivation' --argument-names output
    if set -f hash (string match --regex --groups-only -- 'got:\\s*(?:\\[35;1m)?(sha256-[^\\s]+)' $output)
        echo -n $hash
    else
        echo "No hash in output:" 1>&2
        echo $output 1>&2
        return 1
    end
end
