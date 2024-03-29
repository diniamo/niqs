{
  config,
  osConfig,
  ...
}: let
  theme = osConfig.modules.style.colorScheme.slug;
  path = "${config.xdg.configHome}/btop/themes/${theme}.theme";
in {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = path;
      vim_keys = true;
      show_boxes = "proc cpu";
    };
  };

  # Specifying a path pointing directly to the nix store doesn't work for some reason
  home.file."${path}".source = ./themes/${theme}.theme;
}
