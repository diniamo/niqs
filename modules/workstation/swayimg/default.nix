{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf concatMapStringsSep;
  inherit (lib.types) package listOf path;
  inherit (lib') iniType toYesNoINI;
  inherit (pkgs) symlinkJoin makeBinaryWrapper writeText;

  cfg = config.custom.swayimg;

  generated = ''
    ${concatMapStringsSep "\n" (include: "include ${include}") cfg.includes}
    ${toYesNoINI cfg.settings}
  '';
  configFile = writeText "swayimgrc" generated;
  wrapped = symlinkJoin {
    pname = "swayimg-wrapped";
    inherit (cfg.package) version meta;

    paths = [ cfg.package ];

    nativeBuildInputs = [ makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/swayimg \
        --add-flags '--config-file=${configFile}'
    '';
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.swayimg = {
      enable = mkEnableOption "swayimg";
      
      package = mkPackageOption pkgs "swayimg" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped swayimg package.";
      };

      includes = mkOption {
        type = listOf path;
        default = [];
        description = "Configuration ";
      };
      settings = mkOption {
        type = iniType;
        default = {};
        description = "Configuration passed using the `--config-file` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.swayimg.finalPackage =
      if cfg.settings != {} || cfg.includes != [] then wrapped
      else cfg.package;
      
    user.packages = [ cfg.finalPackage ];
  };
}
