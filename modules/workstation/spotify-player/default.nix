{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf optional;
  inherit (lib.types) attrsOf listOf package;
  inherit (pkgs) linkFarm symlinkJoin makeBinaryWrapper;
  inherit (builtins) length;

  tomlFormat = pkgs.formats.toml {};
  tomlType = tomlFormat.type;
  
  cfg = config.custom.spotify-player;

  appFile = tomlFormat.generate "spotify-player-app.toml" cfg.settings;
  themeFile = tomlFormat.generate "spotify-player-theme.toml" { inherit (cfg) themes; };
  keymapFile = tomlFormat.generate "spotify-player-keymap.toml" { inherit (cfg) keymaps actions; };

  configLinks = optional (cfg.settings != {}) { name = "app.toml"; path = appFile; }
    ++ optional (cfg.themes != []) { name = "theme.toml"; path = themeFile; }
    ++ optional (cfg.keymaps != [] || cfg.actions != []) { name = "keymap.toml"; path = keymapFile; };
  configDirectory = linkFarm "spotify-player-config" configLinks;

  wrapped = symlinkJoin {
    pname = "spotify-player-wrapped";
    inherit (cfg.package) version meta;

    paths = [ cfg.package ];

    nativeBuildInputs = [ makeBinaryWrapper ];
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
      if length configLinks > 0 then wrapped
      else cfg.package;

    user.packages = [ cfg.finalPackage ];
  };
}
