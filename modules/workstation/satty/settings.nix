{ pkgs, lib, config, ... }: let
  inherit (lib) getExe';
in {
  custom.satty = {
    enable = true;

    settings = {
      general = {
        fullscreen = false;
        early-exit = true;
        initial-tool = "brush";
        copy-command = getExe' pkgs.wl-clipboard "wl-copy";
        annotation-size-factor = 1;
        save-after-copy = false;
        default-hide-toolbars = false;
        primary-highlighter = "block";
      };

      font = {
        family = config.custom.style.fonts.regular.name;
        style = "Regular";
      };
    };
  };
}
