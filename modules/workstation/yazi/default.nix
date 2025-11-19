{ pkgs, lib, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types;

  cfg = config.custom.yazi;
in {
  imports = [
    ./settings.nix
    ./keymap.nix
    ./theme.nix
  ];

  options = {
    custom.yazi = {
      enable = mkEnableOption "yazi";

      package = mkPackageOption pkgs "yazi" {};
      finalPackage = mkOption {
        type = types.package;
        readOnly = true;
        description = "The wrapped Yazi package.";
      };

      plugins = mkOption {
        type = types.attrsOf (types.either types.package types.path);
        default = {};
        description = "The plugins to install";
      };
      settings = mkOption {
        type = (pkgs.formats.toml {}).type;
        default = {};
        description = "Settings written to yazi.toml.";
      };
    };
  };

  config = {
    custom.yazi.finalPackage = cfg.package.override {
      inherit (cfg) plugins settings;
    };

    user.packages = [ cfg.finalPackage ];
  };
}
