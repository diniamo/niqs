{ lib, pkgs, config, ... }: let
  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
  inherit (lib.types) attrsOf listOf;

  tomlFormat = pkgs.formats.toml {};
  tomlType = tomlFormat.type;
  
  cfg = config.custom.spotify-player;

  appFile = tomlFormat.generate "spotify-player-app.toml" cfg.settings;
  themeFile = tomlFormat.generate "spotify-player-theme.toml" { inherit (cfg) themes; };
  keymapFile = tomlFormat.generate "spotify-player-keymap.toml" { inherit (cfg) keymaps actions; };
in {
  imports = [ ./settings.nix ];

  options = {
    custom.spotify-player = {
      enable = mkEnableOption "spotify-player";
      package = mkPackageOption pkgs "spotify-player" {};

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
    user.packages = [ cfg.package ];

    home.files = {
      ".config/spotify-player/app.toml" = mkIf (cfg.settings != {}) { source = appFile; };
      ".config/spotify-player/theme.toml" = mkIf (cfg.themes != []) { source = themeFile; };
      ".config/spotify-player/keymap.toml" = mkIf (cfg.keymaps != [] || cfg.actions != []) { source = keymapFile; };
    };
  };
}
