{ lib, config, ... }: 
let
  inherit (lib) mkOption nameToSlug;
  inherit (lib.types) str enum mkOptionType attrsOf coercedTo;
  inherit (lib.strings) isString hasPrefix removePrefix;

  getPaletteFromSlug = slug:
    if builtins.pathExists ./palettes/${slug}.nix
    then (import ./palettes/${slug}.nix).palette
    else throw "The following colorscheme was specified, but does not exist: ${slug}";

  hexColorType = mkOptionType {
    name = "hex-color";
    descriptionClass = "noun";
    description = "RGB color in hex format";
    check = x: isString x && !(hasPrefix "#" x);
  };
  colorType = attrsOf (coercedTo str (removePrefix "#") hexColorType);

  cfg = config.modules.style;
in {
  options.modules.style = {
    colorScheme = {
      # "Name Of The Scheme"
      name = mkOption {
        type = str;
        description = "The name of the system-wide color scheme";
        default = "Catppuccin Macchiato";
      };
      # "name-of-the-scheme"
      slug = mkOption {
        type = str;
        default = nameToSlug "${toString cfg.colorScheme.name}"; # toString to avoid type errors if null, returns ""
        description = ''
          The slugified version of the colorscheme's name.

	  Only change this if it's different from the inferred value.
        '';
      };
      colors = mkOption {
       	type = colorType;
	default = getPaletteFromSlug cfg.colorScheme.slug;
	description = "The attribute set of the colors of the color scheme.";
      };
      variant = mkOption {
        type = enum ["dark" "light"];
	default =
	  if removePrefix "#" cfg.colorScheme.colors.base00 < "5"
	  then "dark"
	  else "light";
	description = "Possible values: dark, light";
      };
    };
  };
}
