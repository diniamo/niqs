{osConfig, ...}: let
  colors = osConfig.modules.style.colorScheme.colorsWithPrefix;
in {
  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
    enableBashIntegration = false;

    colors = {
      "bg+" = colors.base00;
    };
    defaultOptions = ["--border=rounded"];
  };
}
