{
  programs.fish.functions = {
    sudo = {
      description = "sudo wrapper that works with aliases";
      wraps = "sudo";
      body = ''
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
      '';
    };

    con = {
      description = "temporarily subtitute a file with a writable copy of it";
      body = ''
        for file in $argv
          if [ -e $file.pure ]
            echo "$file is already contaminated"
          else if [ ! -f $file ]
            echo "$file is not a file or does not exist"
          else
            echo "Contaminating $file"
            mv $file $file.pure
            install -m 644 $file.pure $file
          end
        end
      '';
      completion = ''
        function _con
          set -f files */
          for file in *
            test ! -d $file -a ! -e $file.pure
            and string match --quiet --entire -- '*.pure' $file
            or set -fa files $file
          end

          string collect -- $files
        end
        
        complete --command con --no-files --arguments '(_con)'
      '';
    };

    dec = {
      description = "restore the original file moved by con";
      body = ''
        for file in $argv
          if [ -f $file.pure ]
            echo "Decontaminating $file"
            mv $file.pure $file
          else
            echo "$file is not contaminated"
          end
        end
      '';
      completion = ''
        function _dec
          set -f files */
          for file in *
            if [ ! -d $file -a -f $file.pure ]
              set -fa files $file
            end
          end

          string collect -- $files
        end

        complete --command dec --no-files --arguments '(_dec)'
      '';
    };

    # Relies on `con` and `dec`
    se = {
      description = "edit files that aren't writable";
      body = ''
        for file in $argv
          [ -f $file -a ! -w $file ] && set -fa cond $file
        end

        con $cond
        $EDITOR -- $argv
        dec $cond
      '';
    };

    xe = {
      description = "make file executable and edit it";
      body = ''
        for file in $argv
          if [ -f $file ]
            chmod +x $file
          else
            install /dev/null $file
          end
        end

        $EDITOR -- $argv
      '';
    };

    yazi = {
      description = "go to yazi directory";
      wraps = "yazi";
      body = ''
        set -f tmp (mktemp)
        command yazi $argv --cwd-file=$tmp
        set -f dir (cat $tmp)
        [ -n $dir -a $dir != $PWD ] && cd $dir
        rm $tmp
      '';
    };

    ".." = {
      description = "go up n directories";
      body = ''
        if set -q argv[1]
          cd (string repeat -Nn $argv[1] ../)
        else
          cd ..
        end
      '';
      completion = "complete --command .. --no-files";
    };

    mcd = {
      description = "create a directory and cd into it";
      argumentNames = "directory";
      body = "mkdir -p $directory && cd $directory";
      completion = "complete --command mcd --no-files";
    };

    copypath = {
      description = "copy the path of a file";
      argumentNames = "path";
      body = ''
        if set -q path
          set path (realpath -s $path)
          echo "Copying $path"
          echo -n $path | wl-copy
        else
          echo "Copying $PWD"
          pwd | wl-copy
        end
      '';
    };

    copyfile = {
      description = "copy the contents of a file";
      argumentNames = "file";
      body = ''
        if [ -f $file -a -r $file ]
          cat $file | wl-copy
        else
          echo "$file doesn't exist or cannot be read"
          return 1
        end
      '';
    };

    pkgpath = {
      description = "ensures the package is installed and prints its store path";
      body = ''
        set -f package $argv[1]
        nix shell $argv[2..] $package --command nix eval $argv[2..] --raw $package
        return $status
      '';
      completion = ''
        function _pkgpath
          set -f token (commandline --current-token)
          [ -n $token ] && complete --do-complete "nix shell $token"
        end

        complete --command pkgpath --no-files --arguments '(_pkgpath)'
      '';
    };

    pkgtree = {
      description = "prints the tree of a package, extra arguments are appended to eza";
      wraps = "pkgpath";
      body = ''
        set -f path (pkgpath $argv[1] $argv[2..]) && eza --tree --icons --group-directories-first $path
      '';
    };

    rpwd = {
      description = "rename current directory";
      argumentNames = "new";
      body = ''
        set -f dir (basename $PWD)
        cd ..
        mv $dir $new
        cd $new
      '';
      completion = "complete --command rpwd --no-files";
    };

    mkshell = {
      description = "nix shell with inputsFrom";
      body = ''
        set -f builder mkShellNoCC
        set -f command $SHELL

        set -f list direct
        function flush_with --no-scope-shadowing
          if [ $list = "with" ]
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
      '';
      completion = ''
        function _mkshell
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
        complete -c mkshell --arguments '(_mkshell)'
      '';
    };

    realwhich = {
      description = "which + realpath";
      wraps = "which";
      body = "realpath (which $argv)";
    };

    nix-has = {
      description = "Check whether a store contains a specific store path";
      argumentNames = "store path";
      body = ''
        if nix path-info --store $store $path &>/dev/null
          set_color green; echo 'Path exists in store'; set_color normal
        else
          set_color red; echo 'Path does not exist in store'; set_color normal
        end
      '';
      completion = ''
        function _nix_has
          set -f process (commandline --cut-at-cursor --current-process --tokens-expanded)
          [ (count $process) = 2 ] && string collect -- /nix/store/*
        end

        complete --command nix-has --no-files --arguments '(_nix_has)'
      '';
    };

    _extract_nix_hash = {
      description = "resolve missing hash in Nix derivation";
      argumentNames = "output";
      body = ''
        if set -f hash (string match --regex --groups-only -- 'got:\\s*(?:\\[35;1m)?(sha256-[^\\s]+)' $output)
          echo -n $hash
        else
          echo "No hash in output:" 1>&2
          echo $output 1>&2
          return 1
        end
      '';
    };

    _complete_command_offset = {
      description = "completion function for completing commands normally with the first token ignored";
      body = ''
        set -f process (commandline --cut-at-cursor --current-process --tokens-expanded)
        set -f token (commandline --cut-at-cursor --current-token)

        if [ (count $process) = 1 ]
          complete --do-complete $token
        else
          complete --do-complete "$process[2..] $token"
        end        
      '';
    };

    fix-hash = {
      description = "extract required hash from a failing Nix command, and replace the empty hash with it";
      body = ''
        set -f output (script --quiet --command "$argv" /dev/null &| tee /dev/stderr | string split0)
        echo
        if set -f hash (_extract_nix_hash $output)
          rg --type nix '[hH]ash\s*=\s*""' --json | jaq --raw-output 'select(.type == "match") | "\(.data.path.text)	\(.data.line_number)"' | while read --delimiter '	' -l path line
            set -fa paths $path
            set -fa lines $line
          end
          
          set -f count (count $paths)
          if [ $count -gt 0 ]
            if [ $count -gt 1 ]
              for i in (seq $count)
                echo -n [
                set_color --bold; echo -n $i; set_color normal
                echo "] $paths[$i]"
              end
              read -l answer --prompt-str 'Multiple empty hashes found. Which one would you like to replace? '
              commandline --function repaint # Read messes up my actual prompt for some reason
              
              if not set -q paths[$answer] 2>/dev/null
                set_color --bold red; echo "Invalid choice: $answer"
                return 1
              end
              set -f paths $paths[$answer]
              set -f lines $lines[$answer]
            end

            echo -n 'Replacing empty hash in '; set_color --bold; echo $paths; set_color normal
            sed -i $lines"s|\([hH]ash[[:space:]]*=[[:space:]]*\"\)|\1$hash|" $paths
          else
            set_color yellow; echo 'Failed to find location, falling back to copy'; set_color normal
            echo "Copying $hash"
            echo -n $hash | wl-copy
          end
        else
          set_color --bold red; echo "No hash in output"; set_color normal
          return 1
        end
      '';
      completion = "complete --command fix-hash --no-files --arguments '(_complete_command_offset)'";
    };
    
    notify = {
      description = "show notification after executing a command";
      body = ''
        $argv
        notify-send -i dialog-information -t 0 Shell "$argv[1] exited with code $status"
      '';
      completion = "complete --command notify --no-files --arguments '(_complete_command_offset)'";
    };
  };
}
