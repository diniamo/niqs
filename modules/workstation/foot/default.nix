{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) package;
  inherit (lib') iniType toYesNoINI;
  inherit (pkgs) writeText symlinkJoin makeBinaryWrapper;

  cfg = config.custom.foot;

  settingsFile = writeText "foot.ini" (toYesNoINI cfg.settings);
  wrapped = symlinkJoin {
    pname = "${cfg.package.pname}-wrapped";
    inherit (cfg.package) version meta;

    paths = [ cfg.package ];

    nativeBuildInputs = [ makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/foot \
        --add-flags '--config=${settingsFile}'
    '';
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.foot = {
      enable = mkEnableOption "foot";

      package = mkPackageOption pkgs "foot" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped foot package.";
      };

      settings = mkOption {
        type = iniType;
        default = {};
        description = "Configuration passed using the `--config` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.foot.finalPackage =
      if cfg.settings != {} then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
