{config, ...}: {
  programs.git.delta = {
    enable = true;
    # TODO: there is no stylix module
    options =
      (import ./themes/catppuccin-macchiato.nix)
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
