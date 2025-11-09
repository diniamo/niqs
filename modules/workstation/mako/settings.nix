{ lib, config, ... }: let
  inherit (lib) getExe' getExe concatStringsSep;

  inherit (config) custom;
  inherit (custom) style;
in {
  custom = {
    style.matugen.templates.mako-colors.input = ./colors;

    mako = {
      enable = true;

      settings = {
        include = style.matugen.templates.mako-colors.output;

        on-button-left = "invoke-default-action";
        on-button-middle = "dismiss";
        on-button-right = "exec ${getExe' custom.mako.package "makoctl"} menu -n \"$id\" -- ${getExe custom.fuzzel.finalPackage} --dmenu --placeholder 'Select action' --no-exit-on-keyboard-focus-loss";
        on-touch = "invoke-default-action";

        font = "${style.fonts.regular.name} 11";
        icon-path = concatStringsSep ":" (style.iconTheme.path);
        max-icon-size = 32;
        border-radius = 10;
        markup = false;
        layer = "overlay";
        default-timeout = 5000;
      };

      criteria = {
        "urgency=low".default-timeout = 3000;
        "urgency=critical".default-timeout = 0;
      };
    };
  };
}
