{
  programs.fish.shellAliases = {
    tm = "gtrash put";
    cat = "bat --style=plain";

    ls = "eza --git --icons --group-directories-first";
    la = "ls --almost-all";
    l = "ls --long --time-style=long-iso";
    ll = "l --almost-all";
    lm = "l --sort=age";
    llm = "ll --sort=age";
    lt = "ls --tree";
  };
}
