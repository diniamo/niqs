{
  lib,
  pkgs,
  ...
}: {
  programs.fish.shellAliases = {
    rm = "gtrash put --rm-mode";
    ip4 = "${lib.getExe pkgs.dig} @resolver4.opendns.com myip.opendns.com +short -4";
    # ip6 = "${dig} @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";
    cat = "bat --style=plain";

    # eza
    ls = "eza --git --icons --group-directories-first";
    la = "ls --almost-all";
    l = "ls --long --time-style=long-iso";
    ll = "l --almost-all";
    # same as --sort=modified --reverse
    lm = "l --sort=age";
    llm = "ll --sort=age";
    lt = "ls --tree";
    tree = "ls --tree";
  };
}
