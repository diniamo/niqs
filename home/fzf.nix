{config, ...}: {
  stylix.targets.fzf.enable = false;

  programs.fzf = {
    enable = true;

    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;

    colors = with config.lib.stylix.colors.withHashtag; {
      fg = base05;
      "fg+" = base06;
      bg = base00;
      "bg+" = base00;
      hl = base0B;
      "hl+" = base0B;
      info = base0F;
      marker = base0E;
      prompt = base0D;
      spinner = base0C;
      pointer = base08;
      header = base09;
    };
    defaultOptions = ["--border=rounded" "--pointer='>'"];
  };
}
