{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) nullOr path;

  cfg = config.custom.bat;
  home = config.home.directory;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.bat = {
      enable = mkEnableOption "bat";
      package = mkPackageOption pkgs "bat" {};

      theme = mkOption {
        type = nullOr path;
        default = null;
        description = "The path of the theme file.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];

    home.files = mkIf (cfg.theme != null) {
      ".config/bat/config" = {
        name = "bat-config";
        text = "--theme=nix";
      };

      ".config/bat/themes/nix.tmTheme" = {
        name = "bat-theme.tmTheme";
        source = cfg.theme;
        onChange = "bat cache --source ${home}/.config/bat --target ${home}/.cache/bat --build";
      };
    };
  };
}
