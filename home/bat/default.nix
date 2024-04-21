{osConfig, ...}: let
  inherit (osConfig.modules.style.colorScheme) name slug;
in {
  programs.bat = {
    enable = true;
    config.theme = name;
    themes.${name} = {src = ./themes/${slug}.tmTheme;};
  };
}
