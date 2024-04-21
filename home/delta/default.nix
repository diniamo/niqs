{
  config,
  osConfig,
  ...
}: {
  programs.git.delta = {
    enable = true;
    options =
      (import ./themes/${osConfig.modules.style.colorScheme.slug}.nix)
      // {
        dark = true;
        line-numbers = true;
        side-by-side = true;
        navigate = true;
        hyperlinks = true;
        syntax-theme = config.programs.bat.config.theme;
      };
  };
}
