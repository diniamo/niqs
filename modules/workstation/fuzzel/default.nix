{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) package;
  inherit (pkgs) symlinkJoin makeBinaryWrapper;

  iniFormat = pkgs.formats.ini {};

  cfg = config.custom.fuzzel;

  settingsFile = iniFormat.generate "fuzzel.ini" cfg.settings;
  wrapped = symlinkJoin {
    pname = "${cfg.package.pname}-wrapped";
    inherit (cfg.package) version meta;

    paths = [ cfg.package ];

    nativeBuildInputs = [ makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/fuzzel \
        --add-flags '--config=${settingsFile}'
    '';
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.fuzzel = {
      enable = mkEnableOption "fuzzel";

      package = mkPackageOption pkgs "fuzzel" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped fuzzel package.";
      };

      settings = mkOption {
        type = iniFormat.type;
        default = {};
        description = "Configuration passed using the `--config` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.fuzzel.finalPackage =
      if cfg.settings != {} then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
