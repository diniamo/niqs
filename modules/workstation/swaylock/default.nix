{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) package attrsOf oneOf str int bool;
  inherit (lib') toFlagKV;
  inherit (pkgs) writeText;

  cfg = config.custom.swaylock;

  settingsFile = writeText "swaylock-config" (toFlagKV cfg.settings);
  wrapped = pkgs.symlinkJoin {
    inherit (cfg.package) version meta;
    pname = "swaylock-wrapped";

    paths = [ cfg.package ];

    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/swaylock \
        --add-flags '--config ${settingsFile}'
    '';
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.swaylock = {
      enable = mkEnableOption "swaylock";

      package = mkPackageOption pkgs "swaylock" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped swaylock package.";
      };

      settings = mkOption {
        type = attrsOf (oneOf [ str int bool ]);
        default = {};
        description = "Configuration passed using the `--config` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.swaylock.finalPackage =
      if cfg.settings != {} then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
