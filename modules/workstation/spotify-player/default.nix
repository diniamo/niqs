{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf optional;
  inherit (lib.types) attrsOf listOf package;
  inherit (builtins) length;

  tomlFormat = pkgs.formats.toml {};
  tomlType = tomlFormat.type;
  
  cfg = config.custom.spotify-player;

  appFile = tomlFormat.generate "spotify-player-app.toml" cfg.settings;
  themeFile = tomlFormat.generate "spotify-player-theme.toml" { inherit (cfg) themes; };
  keymapFile = tomlFormat.generate "spotify-player-keymap.toml" { inherit (cfg) keymaps actions; };

  files = optional (cfg.settings != {}) appFile
    ++ optional (cfg.themes != {}) themeFile
    ++ optional (cfg.keymaps != {} || cfg.actions != {}) keymapFile;
  configDirectory = pkgs.linkFarmFromDrvs files;

  wrapped = pkgs.symlinkJoin {
    inherit (cfg.package) version meta;
    pname = "spotify-player-wrapped";

    paths = [ cfg.package ];

    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/spotify_player \
        --add-flags '--config-folder ${configDirectory}'
    '';
  };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.spotify-player = {
      enable = mkEnableOption "spotify-player";

      package = mkPackageOption pkgs "spotify-player" {};
      finalPackage = mkOption {
        type = package;
        readOnly = true;
        description = "The wrapped spotify-player package.";
      };

      settings = mkOption {
        type = attrsOf tomlType;
        default = {};
        description = "Configuration written to `.config/spotify-player/app.toml`.";
      };

      themes = mkOption {
        type = listOf tomlType;
        default = [];
        description = "Themes written to the `themes` field of `.config/spotify-player/theme.toml`.";
      };

      keymaps = mkOption {
        type = listOf tomlType;
        default = [];
        description = "Keymaps written to the `keymaps` field of `.config/spotify-player/keymap.toml`.";
      };
      actions = mkOption {
        type = listOf tomlType;
        default = [];
        description = "Actions written to the `actions` field of `.config/spotify-player/keymap.toml`.";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.spotify-player.finalPackage =
      if length files > 0 then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
