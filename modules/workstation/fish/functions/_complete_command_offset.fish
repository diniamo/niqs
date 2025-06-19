function _complete_command_offset --description 'completes commands as if the first token weren\'t there'
    set -f process (commandline --cut-at-cursor --current-process --tokens-expanded)
    set -f token (commandline --cut-at-cursor --current-token)

    if [ (count $process) = 1 ]
        complete --do-complete $token
    else
        complete --do-complete "$process[2..] $token"
    end
end
