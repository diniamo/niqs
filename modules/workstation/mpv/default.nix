{pkgs, lib, lib', config, ...}: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkDefault types mkIf optional optionals;
  inherit (lib.types) attrsOf oneOf str int bool float listOf either package;
  inherit (lib') toYesNoKV toYesNoINI toSpaceKV toMpvScriptOpts;
  inherit (pkgs) writeText;

  atom = oneOf [ str int bool float ];
  settingsType = attrsOf (either atom (listOf atom));

  cfg = config.mpv;

  configFile = writeText "mpv.conf" ''
    ${toYesNoKV cfg.settings}

    ${toYesNoINI cfg.profiles}
  '';
  inputFile = writeText "mpv-input.conf" (toSpaceKV cfg.inputSettings);
  scriptOptsFlag = "--script-opts=${toMpvScriptOpts cfg.scriptOpts}";
in {
  imports = [
    ./settings.nix
    ./input.nix
    ./scripts.nix
  ];

  options = {
    custom.mpv = {
      enable = mkEnableOption "mpv";
      
      package = mkPackageOption pkgs "mpv-unwrapped" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped mpv package.";
      };

      flags = mkOption {
        type = listOf str;
        default = [];
        description = "Extra flags to pass to mpv.";
      };

      scripts = mkOption {
        type = listOf package;
        default = [];
        description = "Scripts to enable.";
      };
      scriptOpts = mkOption {
        type = attrsOf settingsType;
        default = {};
        description = "Script options.";
      };
        
      settings = mkOption {
        type = settingsType;
        default = {};
        description = "Mpv configuration.";
      };
      profiles = mkOption {
        type = attrsOf settingsType;
        default = {};
        description = "Profiles to define.";
      };
      
      inputSettings = mkOption {
        type = attrsOf str;
        default = {};
        description = "Input configuration.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.mpv = {
      flags = [ "--no-config" "--load-scripts=no" ]
        ++ optional (cfg.settings != {} || cfg.profiles != {}) "--include=${configFile}"
        ++ optional (cfg.inputSettings != {}) "--input-conf=${inputFile}"
        ++ optional (cfg.scriptOpts != {}) scriptOptsFlag;

      finalPackage = cfg.package.wrapper {
        inherit (cfg) scripts;

        extraMakeWrapperArgs =
          optionals (cfg.flags != []) ["--add-flags" cfg.extraFlags];
      };
    };

    user.packages = [cfg.finalPackage];
  };
}
