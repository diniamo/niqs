{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types mkIf getExe;

  cfg = config.custom.swaybg;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.swaybg = {
      enable = mkEnableOption "swaybg";
      package = mkPackageOption pkgs "swaybg" {};

      image = mkOption {
        type = types.path;
        description = "The background image.";
      };
      mode = mkOption {
        type = types.enum [ "stretch" "fill" "fit" "center" "tile" ];
        default = "stretch";
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.swaybg = {
      description = "swaybg background displayer";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig.ExecStart = "${getExe cfg.package} --image '${cfg.image}' --mode '${cfg.mode}'";
    };
  };
}
