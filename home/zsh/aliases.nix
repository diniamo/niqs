{
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    shellAliases = {
      # Needed for aliases
      sudo = "sudo ";
      listxwl = "hyprctl -j clients | jq -r '.[] | select( [ .xwayland == true ] | any ) | .title' | awk 'NF'";
      v = "nvim";
      # Create a file with execute permissions
      xtouch = "install /dev/null";
      rm = "rmtrash";
      hash = "sha256sum";
      copy = "wl-copy";
      paste = "wl-paste";
      ip4 = "${lib.getExe pkgs.dig} @resolver4.opendns.com myip.opendns.com +short -4";
      # ip6 = "${dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";
      mp = "mkdir -p";
      page = "$PAGER";
      open = "xdg-open";
      size = "du -sh";
      "-" = "cd -";
      fcd = "cd \"$(fd --type directory | fzf)\"";
      cht = "cht.sh";

      sc = "sudo systemctl";
      jc = "sudo journalctl";
      scu = "systemctl --user";
      jcu = "journalctl --user";

      # nix
      n = "nix";
      bloat = "nix path-info -Sh /run/current-system";
      clean = "nh clean all";
      shell = "nix shell";
      dev = "nix develop";
      run = "nix run";
      build = ''nix build --builders "" "$@"'';
      flake = "nix flake";

      # eza
      ls = "eza --git --icons --color=auto --group-directories-first";
      la = "ls --almost-all";
      l = "ls --long --time-style=long-iso";
      ll = "l --almost-all";
      # same as --sort=modified --reverse
      lm = "l --sort=age";
      llm = "ll --sort=age";
      lt = "ls --tree";
      tree = "lt";

      # git
      g = "git";
      lg = "lazygit";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gst = "git status";
      grhh = "git reset --hard";
      gb = "git branch";
      gm = "git merge";
      gfa = "git fetch --all";
      gpf = "git push --force";
      gco = "git checkout";
      gd = "git diff";
      gs = "git switch";
      gsc = "git switch --create";
      ga = "git add";
    };

    initExtra = ''
      # Can't have these in shellAliases due to escaping
      alias -s git="git clone"
    '';
  };
}
