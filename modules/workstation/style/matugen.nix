{ lib, lib', config, pkgs, ... }: let
  inherit (lib) mkOption mkPackageOption getExe;
  inherit (lib.types) enum float attrsOf submodule path str;
  inherit (lib') attrsToLines;

  cfg = config.custom.style.matugen;
  
  themes = pkgs.runCommandLocal "matugen-themes" {} ''
    configFile="$(mktemp)"
    cat > $configFile <<EOF
    [config.custom_colors]
    ${attrsToLines (color: value: "${color} = '${value}'") cfg.colors}
    [templates]
    ${attrsToLines (name: template: "${name} = { input_path = '${template.input}', output_path = '$out/${name}' }") cfg.templates}
    EOF

    ${getExe cfg.package} image ${cfg.image} \
      --type ${cfg.type} \
      --contrast ${toString cfg.contrast} \
      --mode ${cfg.mode} \
      --config $configFile
  '';
in {
  options = {
    custom.style.matugen = {
      package = mkPackageOption pkgs "matugen" {};

      image = mkOption {
        type = path;
        description = "Image to use for generating the color scheme.";
      };

      type = mkOption {
        type = enum [ "scheme-content" "scheme-expressive" "scheme-fidelity" "scheme-fruit-salad" "scheme-monochrome" "scheme-neutral" "scheme-rainbow" "scheme-tonal-spot" ];
        default = "scheme-tonal-spot";
        description = "Color scheme type.";
      };
      contrast = mkOption {
        type = float;
        default = 0.0;
        description = "Color scehem contrast.";
      };
      mode = mkOption {
        type = enum [ "dark" "light" ];
        default = "dark";
        description = "Color scheme mode (polarity).";
      };

      colors = mkOption {
        type = attrsOf str;
        default = {};
        description = "Custom colors.";
      };

      templates = mkOption {
        type = attrsOf (submodule ({ name, ... }: {
          options = {
            input = mkOption {
              type = path;
              description = "Path to the input file.";
            };

            output = mkOption {
              type = path;
              readOnly = true;
              default = "${themes}/${name}";
              description = "Path to the output file.";
            };
          };
        }));
        default = {};
        description = ''
          Templates to generate.
          The attribute name represents the name of the template in the configuration file.
        '';
      };
    };
  };
}
