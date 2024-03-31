{osConfig, ...}: let
  colors = osConfig.modules.style.colorScheme.colorsWithPrefix;
in {
  programs.fzf = {
    enable = true;

    colors = {
      "bg+" = colors.base00;
    };
    defaultOptions = ["--border=rounded"];
  };
}
