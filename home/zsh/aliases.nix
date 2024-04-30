{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe getExe';

  dig = getExe pkgs.dig;
in {
  programs.zsh = {
    shellAliases = {
      # Needed for aliases
      sudo = "sudo ";
      listxwl = "hyprctl -j clients | jq -r '.[] | select( [ .xwayland == true ] | any ) | .title' | awk 'NF'";
      v = "nvim";
      # Create a file with execute permissions
      xtouch = "install /dev/null";
      rm = "rmtrash";
      rmd = getExe' pkgs.coreutils-full "rm";
      hash = "sha256sum";
      copy = "wl-copy";
      paste = "wl-paste";
      ip4 = "${dig} @resolver4.opendns.com myip.opendns.com +short -4";
      ip6 = "${dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";
      mp = "mkdir -p";
      page = "$PAGER";
      open = "xdg-open";
      size = "du -sh";
      "-" = "cd -";
      fcd = "cd \"$(fd --type directory | fzf)\"";

      sc = "sudo systemctl";
      jc = "sudo journalctl";
      scu = "systemctl --user";
      jcu = "journalctl --user";

      # nix
      n = "nix";
      bloat = "nix path-info -Sh /run/current-system";
      clean = "nh clean all";
      curgen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      shell = "nix shell";
      dev = "nix develop";
      run = "nix run";
      build = ''nix build --builders "" "$@"'';
      flake = "nix flake";

      # eza
      ls = "eza --git --icons --color=auto --group-directories-first";
      l = "ls -lh --time-style=long-iso";
      ll = "l -a";
      la = "ls -a";
      tree = "ls --tree";
      lt = "tree";

      # git
      g = "git";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gst = "git status";
      grhh = "git reset --hard";
      gb = "git branch";
      gm = "git merge";
    };

    initExtra = ''
      # Can't have these in shellAliases due to escaping
      alias -s git="git clone"
    '';
  };
}
