{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) package listOf path;
  inherit (lib') iniSection toFlagKV;
  inherit (pkgs) runCommandLocal symlinkJoin makeBinaryWrapper;

  cfg = config.custom.swaylock;

  settingsFile = runCommandLocal "swaylock-config" {
    settings = toFlagKV cfg.settings;
    files = cfg.configFiles;
  } ''
    echo -n "$settings" > $out
    echo >> $out
    for file in "''${files[@]}"; do
      cat "$file" >> $out
    done
  '';
  wrapped = symlinkJoin {
    pname = "${cfg.package.pname}-wrapped";
    inherit (cfg.package) version meta;

    paths = [ cfg.package ];

    nativeBuildInputs = [ makeBinaryWrapper ];
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

      configFiles = mkOption {
        type = listOf path;
        default = [];
        description = "List of files to append to the config file.";
      };
      settings = mkOption {
        type = iniSection;
        default = {};
        description = "Configuration passed using the `--config` flag.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.swaylock.finalPackage =
      if cfg.settings != {} || cfg.configFiles != [] then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
