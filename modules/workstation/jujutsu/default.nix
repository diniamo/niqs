{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf optionalString getExe;
  inherit (lib.types) attrsOf package;
  inherit (pkgs) symlinkJoin makeBinaryWrapper git;

  tomlFormat = pkgs.formats.toml {};
  tomlType = tomlFormat.type;
  
  cfg = config.custom.jujutsu;

  settingsFile = tomlFormat.generate "jj-config.toml" cfg.settings;

  gitWrapped = symlinkJoin {
    pname = "git-wrapped";
    inherit (git) version meta;

    paths = [ git ];

    nativeBuildInputs = [ makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/git \
        ${optionalString (cfg.settings ? user.name) "--add-flags '-c user.name=\"${cfg.settings.user.name}\"'"} \
        ${optionalString (cfg.settings ? user.email) "--add-flags '-c user.email=\"${cfg.settings.user.email}\"'"}
    '';
  };
  gitFinal =
    if cfg.settings ? user.name || cfg.settings ? user.email then gitWrapped
    else git;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.jujutsu = {
      enable = mkEnableOption "jujutsu";
      package = mkPackageOption pkgs "jujutsu" {};
      
      settings = mkOption {
        type = attrsOf tomlType;
        default = {};
        description = "Configuration written to `.config/jj/config.toml`.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.jujutsu.settings.git.executable-path = getExe gitFinal;

    user.packages = [ cfg.package ];

    home.files.".config/jj/config.toml" = mkIf (cfg.settings != {}) {
      source = settingsFile;
    };
  };
}
