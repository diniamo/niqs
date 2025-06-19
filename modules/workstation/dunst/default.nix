{ lib, pkgs, config, lib', ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types mkIf getExe concatMapStringsSep;
  inherit (lib.types) attrsOf oneOf str bool int listOf path;
  inherit (lib') toYesNoINI;
  inherit (pkgs.writers) writeText;

  cfg = config.custom.dunst;

  settingsFile = writeText "dunstrc" (toYesNoINI cfg.settings);
  flags = concatMapStringsSep " " (file: "-config ${file}") cfg.configFiles;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.dunst = {
      enable = mkEnableOption "dunst";
      package = mkPackageOption pkgs "dunst" {};

      configFiles = mkOption {
        type = listOf path;
        default = [];
        description = "Configuration files passed using the `-config` flag.";
      };
      settings = mkOption {
        type = attrsOf (attrsOf (oneOf [ str bool int (listOf str) ]));
        default = {};
        description = "Configuration added to {option}`custom.dunst.configFiles`.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.dunst.configFiles = mkIf (cfg.settings != {}) [ settingsFile ];

    systemd.user.services.dunst = {
      description = "Dunst notification daemon";
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${getExe cfg.package} ${flags}";
      };
      reloadTriggers = cfg.configFiles;
    };

    user.packages = [ cfg.package ];
  };
}
