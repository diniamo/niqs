{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkOption types;

  cfg = config.modules.style;
in {
  imports = [./colors.nix ./gtk.nix ./qt.nix];

  options = {
    modules.style = {
      cursor = {
        name = mkOption {
          type = types.str;
          description = "The name of the cursor theme";
          default = "Bibata-Modern-Classic";
        };
        package = mkOption {
          type = types.package;
          description = "The cursor theme's package";
          default = pkgs.bibata-cursors.overrideAttrs {
            buildPhase = ''
              runHook preBuild
              ctgen build.toml -s ${toString cfg.cursor.size} -p x11 -d "$bitmaps/${cfg.cursor.name}" -n '${cfg.cursor.name}' -c '${cfg.cursor.name} variant'
              runHook postBuild
            '';
          };
        };
        size = mkOption {
          type = types.int;
          description = "The size of the cursor";
          default = 20;
        };
      };

      iconTheme = {
        name = mkOption {
          type = types.str;
          description = "The name of the icon theme";
          default = "Papirus-Dark";
        };
        package = mkOption {
          type = types.package;
          description = "The package for the icon theme";
          default = pkgs.catppuccin-papirus-folders.override {
            flavor = "macchiato";
            accent = "blue";
          };
        };
      };

      font = {
        name = mkOption {
          type = types.str;
          description = "The name of the font";
          default = "Inter";
        };
        package = mkOption {
          type = types.package;
          description = "The package of the font";
          default = pkgs.inter;
        };
        size = mkOption {
          type = types.int;
          description = "The size of the font";
          default = 11;
        };
        sizeString = mkOption {
          type = types.string;
          description = "The size of the font as a string";
          default = toString cfg.font.size;
        };
      };
      monoFont = {
        name = mkOption {
          type = types.str;
          description = "The name of the font";
          default = "JetBrainsMono Nerd Font Mono";
        };
        package = mkOption {
          type = types.package;
          description = "The package of the font";
          default = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        };
        size = mkOption {
          type = types.int;
          description = "The size of the font";
          default = 12;
        };
        sizeString = mkOption {
          type = types.string;
          description = "The size of the font as a string";
          default = toString cfg.monoFont.size;
        };
      };
    };
  };
}
