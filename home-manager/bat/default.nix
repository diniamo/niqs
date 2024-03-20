{osConfig, ...}: let
  inherit (osConfig.modules.style.colorScheme) slug;
in {
  programs.bat = {
    enable = true;
    config = {
      theme = slug;
    };
    themes = {
      "${slug}" = {src = ./themes/${slug}.tmTheme;};
    };
  };
}
