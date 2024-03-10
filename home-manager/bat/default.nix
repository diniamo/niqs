{osConfig, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "default";
    };
    themes = {
      default = { src = ./themes/${osConfig.modules.style.colorScheme.slug}.tmTheme; };
    };
  };
}
