{config, ...}: {
  programs.fzf = {
    enable = true;

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
      pointer = base15;
      header = base09;
    };
        
    options = [
      "--border=rounded"
      "--pointer='>'"
      "--bind=ctrl-s:toggle"
    ];
  };
}
