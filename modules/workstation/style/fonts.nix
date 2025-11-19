{ lib, config, ... }: let
  inherit (lib) mkOption mkForce;
  inherit (lib.types) submodule str package int;

  fontModule = mkOption {
    type = submodule ({ config, ... }: {
      options = {
        name = mkOption {
          type = str;
          description = "The name of the font.";
        };

        size = mkOption {
          type = int;
          description = "The standard size to use for the font.";
        };
        sizeString = mkOption {
          type = str;
          default = toString config.size;
          readOnly = true;
          description = "The standard size as a string.";
        };

        package = mkOption {
          type = package;
          description = "The package providing the font.";
        };
      };
    });
  };

  cfg = config.custom.style.fonts;
in {
  options = {
    custom.style.fonts = {
      regular = fontModule;
      monospace = fontModule;
      emoji = fontModule;
    };
  };

  config = {
    fonts = {
      packages = [
        cfg.regular.package
        cfg.monospace.package
        cfg.emoji.package
      ];

      fontconfig = {
        defaultFonts = {
          sansSerif = mkForce [ cfg.regular.name ];
          serif = mkForce [ cfg.regular.name ];
          monospace = mkForce [ cfg.monospace.name ];
          emoji = mkForce [ cfg.emoji.name ];
        };

        subpixel.rgba = "rgb";
      };
    };
  };
}
