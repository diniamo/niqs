{ pkgs, lib, lib', config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption types mkIf optional optionalAttrs optionalString;
  inherit (lib.types) attrsOf nullOr listOf package str;
  inherit (lib') iniAtom toYesNoKV toYesNoINI toSpaceKV toMpvScriptOpts;
  inherit (pkgs) runCommandLocal;

  settingsType = attrsOf (nullOr iniAtom);

  cfg = config.custom.mpv;
  hasSettings = cfg.settings != {} || cfg.profiles != {};
  hasInputSettings = cfg.inputSettings != {};

  scriptOptsFlag = "--script-opts=${toMpvScriptOpts cfg.scriptOpts}";
  configDirectory = runCommandLocal "mpv-config" (
    optionalAttrs hasSettings {
      configText = ''
        ${toYesNoKV cfg.settings}
        ${toYesNoINI cfg.profiles}
      '';
    } // optionalAttrs hasInputSettings {
      inputText = toSpaceKV cfg.inputSettings;
    }
  ) ''
    mkdir $out
    ${optionalString hasSettings "echo -n \"$configText\" > $out/mpv.conf"}
    ${optionalString hasInputSettings "echo -n \"$inputText\" > $out/input.conf"}
  '';

  flags = optional (cfg.scriptOpts != {}) scriptOptsFlag
    ++ optional (hasSettings || hasInputSettings) "--config-dir=${configDirectory}";
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
    custom.mpv.finalPackage = cfg.package.wrapper {
      mpv = cfg.package;

      inherit (cfg) scripts;
      extraMakeWrapperArgs = [ "--add-flags" flags ];
    };

    user.packages = [ cfg.finalPackage ];
  };
}
