{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;

  dig = getExe pkgs.dig;
in {
  programs.zsh.shellAliases = {
    # Needed for aliases
    sudo = "sudo ";
    listxwl = "hyprctl -j clients | jq -r '.[] | select( [ .xwayland == true ] | any ) | .title' | awk 'NF'";
    v = "nvim";
    # Create a file with execute permissions
    xtouch = "install /dev/null";
    rm = "rmtrash";
    rmd = "command rm";
    hash = "sha256sum";
    copy = "wl-copy";
    paste = "wl-paste";
    ip = "${dig} @resolver4.opendns.com myip.opendns.com +short";
    ip4 = "${dig} @resolver4.opendns.com myip.opendns.com +short -4";
    ip6 = "${dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";
    mp = "mkdir -p";
    page = "$PAGER";
    open = "xdg-open";
    n = "nix";
    pshell = "nix-shell --packages";
    dev = "nix develop";
    update-input = "nix flake lock --update-input";
    # nix-clean = "sudo nix-collect-garbage --delete-older-than 3d; nix-collect-garbage -d";
    size = "du -sh";
    "-" = "cd -";

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
  };
}
