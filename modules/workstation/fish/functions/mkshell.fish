function mkshell --description 'nix shell with inputsFrom'
    set -f builder mkShellNoCC
    set -f command $SHELL

    set -f list direct
    function flush_with --no-scope-shadowing
        if [ $list = with ]
            set -f direct[-1] "($direct[-1].withPackages (ps: with ps; [$with]))"
            set -fe with
        end
    end

    for arg in $argv
        switch $arg
            case -s --stdenv
                set -f builder mkShell
            case -c --command
                flush_with
                set -fe command
                set -f list command
            case -p --packages
                flush_with
                set -f list direct
            case -i --inputs-from
                flush_with
                set -f list inputs
            case -w --with
                set -f list with
            case '*'
                set -fa $list "($arg)"
        end
    end
    flush_with

    nix develop --impure --expr "
      with import <nixpkgs> {}; $builder {
        packages = [$direct];
        inputsFrom = [$inputs];
      }
    " --command $command
end
