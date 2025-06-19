function mcd --description 'create a directory and cd into it' --argument-names directory
    mkdir -p $directory && cd $directory
end
