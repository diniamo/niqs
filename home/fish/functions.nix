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
            if [ $i != 1 ]
              set sudo_args $argv[..(math $i - 1)]
            end
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
          if [ -f $file.pure ]
            echo "$file is already contaminated"
          else if not [ -f $file ]
            echo "$file is not a file or does not exist"
          else
            echo "Contaminating $file"
            mv $file $file.pure
            install -m 644 $file.pure $file
          end
        end
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
    };

    # Relies on `con` and `dec`
    sv = {
      description = "edit files that aren't writable";
      body = ''
        for file in $argv
          [ -f $file -a ! -w $file ]; and set -f cond $cond $file
        end

        con $cond
        $EDITOR -- $argv
        dec $cond
      '';
    };

    xv = {
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
      body = ''
        set -l tmp (mktemp)
        command yazi $argv --cwd-file=$tmp
        set -l dir (cat $tmp)
        [ -n $dir -a $cwd != $PWD ]; and cd $dir
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
    };

    mcd = {
      description = "create a directory and cd into it";
      argumentNames = "directory";
      body = ''
        mkdir -p $directory
        cd $directory
      '';
    };

    copypath = {
      description = "copy the path of a file";
      body = ''
        if set -q argv[1]
          set path (realpath -s $argv[1])
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
        end
      '';
    };

    notify = {
      description = "show notification after executing a command";
      body = ''
        $argv
        notify-send -i dialog-information Shell "$argv[1] has finished executing"
      '';
    };

    pkgpath = {
      description = "ensures the package is installed and prints its store path";
      argumentNames = "package";
      body = ''
        nix shell $package --command nix eval --raw $package
      '';
    };

    # Relies on pkgpath
    pkgtree = {
      description = "prints the tree of a package, extra arguments are appended to eza";
      body = "eza --tree --icons --group-directories-first $argv[2..] (pkgpath $argv[1])";
    };

    rpwd = {
      description = "rename current directory";
      argumentNames = "to";
      body = ''
        set dir (basename $PWD)
        cd ..
        mv $dir $to
        cd $to
      '';
    };

    listxwl = {
      description = "list XWayland windows in Hyprland";
      body = "hyprctl -j clients | jaq -r '.[] | select( [ .xwayland == true ] | any ) | .title'";
    };
  };
}
