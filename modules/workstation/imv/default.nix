{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf concatMapStringsSep;
  inherit (lib.types) package listOf path;
  inherit (lib') iniType toYesNoINI;
  inherit (pkgs) symlinkJoin makeBinaryWrapper;
  inherit (pkgs.writers) writeText;

  cfg = config.custom.imv;

  settingsFile = writeText "imv-config" ''
    ${concatMapStringsSep "\n" (include: "include='${include}'") cfg.includes}
    ${toYesNoINI cfg.settings}
  '';

  wrapped = symlinkJoin {
    pname = "${cfg.package.pname}-wrapped";
    inherit (cfg.package) version man meta;

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

      includes = mkOption {
        type = listOf path;
        default = [];
        description = "Additional configuration files to load.";
      };
      settings = mkOption {
        type = iniType;
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
