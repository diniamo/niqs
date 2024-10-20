{osConfig, ...}: let
  cursor = expansion: {
    setCursor = true;
    inherit expansion;
  };
in {
  programs.fish.shellAbbrs = {
    v = "nvim";
    nv = "neovide --fork";
    hash = "sha256sum";
    copy = "wl-copy";
    paste = "wl-paste";
    mp = "mkdir -p";
    page = "$PAGER";
    open = "xdg-open";
    size = "du -sh";
    "-" = "cd -";
    anime = "mpv --profile=anime";
    cht = "cht.sh";

    realwhich = cursor "realpath (which %)";

    sc = "systemctl";
    jc = "journalctl";
    scu = "systemctl --user";
    jcu = "journalctl --user";

    # nix
    n = "nix";
    clean = "nh clean all --keep ${toString osConfig.boot.loader.systemd-boot.configurationLimit}";
    shell = "nix shell";
    dev = "nix develop --command fish";
    run = "nix run";
    build = "nix build";
    flake = "nix flake";
    repl = "nix repl --expr 'import <nixpkgs> {}'";
    bloat = "nix path-info -Sh /run/current-system";
    unfree = cursor "NIXPKGS_ALLOW_UNFREE=1 % --impure";
    insecure = cursor "NIXPKGS_ALLOW_INSECURE=1 % --impure";
    broken = cursor "NIXPKGS_ALLOW_BROKEN=1 % --impure";

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
    gf = "git fetch";

    # fancy
    git-clone = {
      regex = ".+\\.git";
      function = "_prepend_git_clone";
    };
    command = {
      regex = "\\\\\\\\.*";
      function = "_prepend_command";
    };
    "!!".function = "_last_history_item";
  };

  programs.fish.functions = {
    _prepend_git_clone = ''echo -n "git clone $argv && cd $(string match -gr '/(.+)\.git$' $argv[1])"'';
    _last_history_item = "echo -n $history[1]";
    _prepend_command = "echo -n command (string sub -s 2 $argv[1]) $argv[2..]";
  };
}
