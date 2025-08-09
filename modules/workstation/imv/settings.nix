{ lib, config, pkgs, ... }: let
  inherit (lib) getExe;

  font = config.custom.style.fonts.regular;
in {
  custom = {
    style.matugen.templates.imv-colors.input = ./colors;

    imv = {
      enable = true;

      includes = [ (config.custom.style.matugen.templates.imv-colors.output) ];
      settings = {
        options = {
          overlay_font = "${font.name}:${font.sizeString}";
        };

        binds = {
          n = "next";
          p = "prev";
          ge = "goto -1";

          i = "overlay";
          c = "center; reset";

          "<greater>" = "rotate by 90";
          "<less>" = "rotate by -90";
          "<BackSpace>" = "rotate to 0";

          d = "exec ${getExe pkgs.dragon-drop} --and-exit \"$imv_current_file\"";
          "<Delete>" = "exec ${getExe pkgs.gtrash} put \"$imv_current_file\"; close";
        };
      };
    };
  };
}
