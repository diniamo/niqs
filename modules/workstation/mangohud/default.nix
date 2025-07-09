{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib') iniSection toMangohudConf;
  inherit (pkgs.writers) writeText;

  cfg = config.custom.mangohud;

  settingsFile = writeText "MangoHud.conf" (toMangohudConf cfg.settings);
in {
  imports = [ ./settings.nix ];

  options = {
    custom.mangohud = {
      enable = mkEnableOption "MangoHud";
      package = mkPackageOption pkgs "mangohud" {};

      settings = mkOption {
        type = iniSection;
        default = {};
        description = "Configuration added to the MANGOHUD_CONFIG environment variable.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];

    environment.sessionVariables.MANGOHUD_CONFIGFILE = mkIf (cfg.settings != {}) settingsFile;
  };
}
