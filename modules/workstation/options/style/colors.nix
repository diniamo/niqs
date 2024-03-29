{
  lib,
  lib',
  config,
  ...
}: let
  inherit (lib) mkOptionType mkOption types;
  inherit (lib.strings) hasPrefix isString removePrefix;
  inherit (lib.types) attrsOf;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib') nameToSlug;

  getPaletteFromSlug = slug:
    if builtins.pathExists ./palettes/${slug}.nix
    then (import ./palettes/${slug}.nix).palette
    else throw "The following colorscheme was specified, but does not exist: ${slug}";

  hexColorWithPrefixType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && hasPrefix "#" x;
  };
  hexColorType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && !(hasPrefix "#" x);
  };

  cfg = config.modules.style.colorScheme;
in {
  options = {
    modules.style.colorScheme = {
      # "Name Of The Scheme"
      name = mkOption {
        type = types.str;
        description = "The name of the system-wide color scheme";
        default = "Catppuccin Macchiato";
      };
      # "name-of-the-scheme"
      slug = mkOption {
        type = types.str;
        default = nameToSlug "${toString cfg.name}"; # toString to avoid type errors if null, returns ""
        description = ''
                 The slugified version of the colorscheme's name.

          Only change this if it's different from the inferred value.
        '';
      };
      colorsWithPrefix = mkOption {
        type = attrsOf hexColorWithPrefixType;
        default = getPaletteFromSlug cfg.slug;
        description = "The attribute set of the colors of the color scheme with the # prefixes included.";
      };
      colors = mkOption {
        type = attrsOf hexColorType;
        default = mapAttrs (_: value: removePrefix "#" value) cfg.colorsWithPrefix;
        description = "The attribute set of the colors of the color scheme.";
      };
      # This is currently unused, even though it could be in multiple places
      # since I don't plan on using light theme
      variant = mkOption {
        type = types.enum ["dark" "light"];
        default =
          if removePrefix "#" cfg.colors.base00 < "5"
          then "dark"
          else "light";
        description = "Possible values: dark, light";
      };
    };
  };
}
