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
    };

    interactiveShellInit = ''
      abbr --add --set-cursor -- unfree 'NIXPKGS_ALLOW_UNFREE=1 % --impure'
      abbr --add --set-cursor -- insecure 'NIXPKGS_ALLOW_INSECURE=1 % --impure'
      abbr --add --set-cursor -- broken 'NIXPKGS_ALLOW_BROKEN=1 % --impure'

      abbr --add jj-clone --regex '.+\.git' --function _jj_clone_cd
      abbr --add command --regex '\\\\.*' --function _prepend_command
      abbr --add !! --position anywhere --function _last_history_entry
    '';
  };
}
