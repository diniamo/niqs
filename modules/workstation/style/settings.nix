{ pkgs, inputs, config, ... }: let
  inherit (config.custom.style) dark wallpaper cursor;
in {
  custom.style = {
    dark = true;
    wallpaper = "${inputs.wallpapers}/miles.png";
    
    fonts = {
      regular = {
        name = "Inter";
        size = 12;
        package = pkgs.inter;
      };

      monospace = {
        name = "JetBrainsMono Nerd Font Mono";
        size = 12;
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };

    cursor = {
      name = "Bibata-Modern-${if dark then "Classic" else "Ice"}";
      size = 22;
      package = pkgs.bibata-cursors.overrideAttrs {
        buildPhase = ''
          runHook preBuild
          ctgen configs/normal/x.build.toml -s ${cursor.sizeString} -p x11 -d "$bitmaps/${cursor.name}" -n '${cursor.name}' -c '${cursor.name} variant'
          runHook postBuild
        '';
      };
    };

    iconTheme = {
      name = "Papirus-${if dark then "Dark" else "Light"}";
      package = pkgs.papirus-icon-theme;
    };
    
    matugen = {
      image = wallpaper;
      mode = if dark then "dark" else "light";
      type = "scheme-content";
      contrast = 0.0;

      colors = {
        red = "#ed8796";
        green = "#a6da95";
        yellow = "#eed49f";
        blue = "#8aadf4";
        magenta = "#f5bde6";
        cyan = "#8bd5ca";
      };
    };
  };
}
