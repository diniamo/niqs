{ lib, pkgs, config, lib', ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types mkIf getExe;
  inherit (lib') iniSection toKV toINI;
  inherit (pkgs.writers) writeText;

  cfg = config.custom.mako;

  intBool = bool: if bool then "1" else "0";
  settingsText = ''
    ${toKV intBool cfg.settings}
    ${toINI intBool cfg.criteria}
  '';
  settingsFile = writeText "mako-config" settingsText;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.mako = {
      enable = mkEnableOption "mako";
      package = mkPackageOption pkgs "mako" {};

      settings = mkOption {
        type = iniSection;
        default = {};
        description = "Configuration options.";
      };
      criteria = mkOption {
        type = types.attrsOf iniSection;
        default = {};
        description = "Criteria specific configuration options.";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.mako = {
      description = "Mako notification daemon";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${getExe cfg.package} --config ${settingsFile}";
      };
      restartTriggers = [ settingsFile ];
    };

    user.packages = [ cfg.package ];
  };
}
