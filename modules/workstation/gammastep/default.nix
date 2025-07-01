{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf getExe optionalString;

  iniFormat = pkgs.formats.ini {};

  cfg = config.custom.gammastep;

  settingsFile = iniFormat.generate "gammastep-config.ini" cfg.settings;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.gammastep = {
      enable = mkEnableOption "gammastep";
      package = mkPackageOption pkgs "gammastep" {};

      settings = mkOption {
        type = iniFormat.type;
        default = {};
        description = "Configuration passed using the `-c` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    user.packages = [ cfg.package ];

    systemd.user.services.gammastep = {
      description = "Gammastep color temperature manager.";
      after = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = getExe cfg.package
          + optionalString (cfg.settings != null) " -c ${settingsFile}";
        # May crash when the Wayland session exits,
        # but we want to start it with the next session anyway.
        Restart = "always";
      };
    };
  };
}
