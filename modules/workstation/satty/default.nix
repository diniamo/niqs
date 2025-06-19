{lib, pkgs, config, ...}: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) attrsOf package;

  tomlFormat = pkgs.formats.toml {};

  cfg = config.custom.satty;

  settingsFile = tomlFormat.generate "satty-config.toml" cfg.settings;
  wrapped = pkgs.symlinkJoin {
    inherit (cfg.package) version meta;
    pname = "satty-wrapped";

    paths = [ cfg.package ];

    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/satty \
        --add-flags '--config ${settingsFile}'
    '';
  };
in {
  imports = [ ./settings.nix ];
  
  options = {
    custom.satty = {
      enable = mkEnableOption "satty";
      
      package = mkPackageOption pkgs "satty" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped satty package.";
      };

      settings = mkOption {
        type = attrsOf (attrsOf tomlFormat.type);
        default = {};
        description = "Configuration passed using the `--config` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.satty.finalPackage =
      if cfg.settings != {} then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
