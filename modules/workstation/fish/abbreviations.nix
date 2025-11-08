{
  programs.fish = {
    shellAbbrs = {
      hash = "sha256sum";
      copy = "wl-copy";
      paste = "wl-paste";
      open = "xdg-open";
      size = "du -sh";
      "-" = "cd -";
      anime = "mpv --profile=anime";
      cht = "cht.sh";
      drop = "dragon-drop -a -x";

      sc = "systemctl";
      jc = "journalctl";
      scu = "systemctl --user";
      jcu = "journalctl --user";

      n = "nix";
      shell = "nix shell";
      dev = "nix develop --command fish";
      run = "nix run";
      build = "nix build";
      flake = "nix flake";
      repl = "nix repl --expr 'import <nixpkgs> {}'";
      system-size = "nix path-info -Sh /run/current-system";

      g = "git";
      lg = "lazygit";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gl = "git log";
      gst = "git status";
      grhh = "git reset --hard";
      gb = "git branch";
      gbc = "git branch --show-current";
      gs = "git switch";
      gsc = "git switch --create";
      gm = "git merge";
      gco = "git checkout";
      gf = "git fetch";
      gfa = "git fetch --all";
      gp = "git pull";
      gP = "git push";
      gpf = "git push --force-with-lease";
    };

    interactiveShellInit = ''
      abbr --add --set-cursor -- unfree 'NIXPKGS_ALLOW_UNFREE=1 % --impure'
      abbr --add --set-cursor -- insecure 'NIXPKGS_ALLOW_INSECURE=1 % --impure'
      abbr --add --set-cursor -- broken 'NIXPKGS_ALLOW_BROKEN=1 % --impure'

      abbr --add command --regex '\\\\.*' --function _prepend_command
      abbr --add !! --position anywhere --function _last_history_entry
    '';
  };
}
