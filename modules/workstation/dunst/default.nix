{ lib, pkgs, config, lib', ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types mkIf getExe optionalString;
  inherit (lib.types) attrsOf oneOf str bool int listOf;
  inherit (lib') toYesNoINI;
  inherit (pkgs.writers) writeText;

  cfg = config.custom.dunst;

  configFile = writeText "dunstrc" (toYesNoINI cfg.settings);
in {
  options = {
    custom.dunst = {
      enable = mkEnableOption "dunst";
      package = mkPackageOption pkgs "dunst" {};

      settings = mkOption {
        type = attrsOf (attrsOf (oneOf [ str bool int (listOf str) ]));
        default = {};
        description = "Configuration passed using the `-config` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.dunst = {
      description = "Dunst notification daemon";
      partOf = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = getExe cfg.package + optionalString (cfg.settings != {}) " -config ${configFile}";
      };
      reloadTriggers = [ configFile ];
    };

    user.packages = [ cfg.package ];
  };
}
