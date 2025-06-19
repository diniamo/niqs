{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) attrsOf listOf package;

  tomlFormat = pkgs.formats.toml {};
  tomlType = tomlFormat.type;
  
  cfg = config.custom.jujutsu;

  settingsFile = tomlFormat.generate "jj-config.toml" cfg.settings;
  wrapped = pkgs.symlinkJoin {
    inherit (cfg.package) version meta;
    pname = "jujutsu-wrapped";

    paths = [ cfg.package ];

    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/jj \
        --add-flags '--config-file ${settingsFile}'
    '';
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.jujutsu = {
      enable = mkEnableOption "jujutsu";

      package = mkPackageOption pkgs "jujutsu" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped jujutsu package.";
      };

      settings = mkOption {
        type = attrsOf tomlType;
        default = {};
        description = "Configuration written to `.config/jj/config.toml`.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.jujutsu.finalPackage =
      if cfg.settings != {} then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
