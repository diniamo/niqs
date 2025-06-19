{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) package;
  inherit (pkgs) symlinkJoin makeBinaryWrapper;

  iniFormat = pkgs.formats.ini {};

  cfg = config.custom.imv;

  settingsFile = iniFormat.generate "imv_config" cfg.settings;
  wrapped = symlinkJoin {
    pname = "${cfg.package.pname}-wrapped";
    inherit (cfg.package) version meta;

    paths = [ cfg.package ];

    nativeBuildInputs = [ makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/imv \
        --set imv_config ${settingsFile}
    '';
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.imv = {
      enable = mkEnableOption "imv";
      
      package = mkPackageOption pkgs "imv" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped imv package.";
      };

      settings = mkOption {
        type = iniFormat.type;
        default = {};
        description = "Configuration passed using the imv_config environment variable.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.imv.finalPackage =
      if cfg.settings != {} then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
