{ lib, lib', pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf concatMapStringsSep replaceString;
  inherit (lib.types) listOf attrsOf package path str;
  inherit (lib') iniSection attrsToLines;
  inherit (builtins) isString;
  inherit (pkgs) writeTextFile;

  cfg = config.custom.zathura;

  configDirectory = writeTextFile {
    name = "zathura-config";
    text = ''
      ${attrsToLines (name: value: "set ${name} ${if isString value then "\"${value}\"" else toString value}") cfg.set}
      ${concatMapStringsSep "\n" (file: "include ${file}") cfg.include}
      ${attrsToLines (key: function: "map ${key} ${function}") cfg.map}
      ${concatMapStringsSep "\n" (key: "unmap ${key}") cfg.unmap}
    '';
    destination = "/zathurarc";
  };
  wrapped = cfg.package.overrideAttrs (prev: {
    buildCommand = replaceString
      "--prefix PATH"
      "--add-flags '--config-dir=${configDirectory}' --prefix PATH"
      prev.buildCommand;
  });
in {
  imports = [ ./settings.nix ];

  options = {
    custom.zathura = {
      enable = mkEnableOption "zathura";
      
      package = mkPackageOption pkgs "zathura" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped zathura package.";
      };

      set = mkOption {
        type = iniSection;
        default = {};
        description = "`set` commands.";
      };
      include = mkOption {
        type = listOf path;
        default = [];
        description = "`include` commands.";
      };
      map = mkOption {
        type = attrsOf str;
        default = {};
        description = ''
          `map` commands.
          The mode may be added at the start of the name.
          Arguments may be added at the end of the value.
        '';
      };
      unmap = mkOption {
        type = listOf str;
        default = [];
        description = "`unmap` commands.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.zathura.finalPackage =
      if cfg.set != {} || cfg.include != [] || cfg.map != {} || cfg.unmap != [] then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
