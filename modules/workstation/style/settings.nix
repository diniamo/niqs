{ pkgs, inputs, config, ... }: let
  inherit (config.custom.style) dark;
in {
  custom.style = {
    dark = true;
    
    matugen = {
      image = "${inputs.wallpapers}/miles.png";
      mode = if dark then "dark" else "light";
    };

    fonts = {
      regular = {
        name = "Inter";
        size = 12;
        package = pkgs.inter;
      };

      monospace = {
        name = "JetBrainsMono Nerd Font Mono";
        size = 12;
        package = pkgs.jetbrains-mono;
      };
    };

    cursor = rec {
      name = "Bibata-Modern-${if dark then "Classic" else "Ice"}";
      size = 22;
      package = pkgs.bibata-cursors.overrideAttrs {
        buildPhase = ''
          runHook preBuild
          ctgen configs/normal/x.build.toml -s ${toString size} -p x11 -d "$bitmaps/${name}" -n '${name}' -c '${name} variant'
          runHook postBuild
        '';
      };
    };

    iconTheme = {
      name = "Papirus-${if dark then "Dark" else "Light"}";
      package = pkgs.papirus-icon-theme;
    };
  };
}
