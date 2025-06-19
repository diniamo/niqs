function sudo --description 'sudo wrapper that works with aliases' --wraps sudo
    for i in (seq 1 (count $argv))
        if command -q -- $argv[$i]
            command sudo $argv
            return
        else if functions -q -- $argv[$i]
            [ $i != 1 ] && set -f sudo_args $argv[..(math $i - 1)]
            command sudo $sudo_args -E fish -C "source $(functions --no-details (functions | string split ', ') | psub)" -c '$argv' $argv[$i..]
            return
        end
    end

    command sudo $argv
end
