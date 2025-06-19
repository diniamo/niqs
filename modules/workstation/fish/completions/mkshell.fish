function _complete_mkshell
    set -f process (commandline --cut-at-cursor --current-process --tokens-expanded)
    set -f token (commandline --cut-at-cursor --current-token)

    set -f list direct
    for i in (seq 2 (count $process))
        switch $process[$i]
            case -c --command
                set -f list command
                set -f switch_index $i
            case -p --packages
                set -f list direct
            case -i --inputs-from
                set -f list inputs
            case -w --with
                set -f list with
        end
    end

    switch $list
        case command
            complete --do-complete "$process[$(math $switch_index + 1)..] $token"
        case direct inputs
            string match --quiet --entire -- '-*' $token || complete --do-complete "nix shell $token"
    end
end

complete -c mkshell -s s -l stdenv -d 'Use mkShell instead of mkShellNoCC'
complete -c mkshell -s c -l command -d 'The command to execute in the environment'
complete -c mkshell -s p -l packages -d 'Add the following derivations packages'
complete -c mkshell -s i -l inputs-from -d 'Add the follow derivations to inputsFrom'
complete -c mkshell -s w -l with -d 'Add the following derivations to the previous derivation in packages using the withPackages convention'
complete -c mkshell --arguments '(_complete_mkshell)'
