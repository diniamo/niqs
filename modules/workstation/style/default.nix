{
  inputs,
  pkgs,
  config,
  ...
}: let
  cfg = config.stylix;
in {
  imports = [
    inputs.stylix.nixosModules.stylix

    ./qt.nix
  ];

  config = {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
      polarity = "dark";
      image = ./wallpapers/romb.png;

      fonts = rec {
        sansSerif = {
          package = pkgs.inter;
          name = "Inter";
        };
        # Inter superiority
        serif = sansSerif;
        # This is the default but specify anyway
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };

        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
          name = "JetBrainsMono Nerd Font Mono";
        };
      };

      cursor = {
        # TODO: generate the cursor based on the color scheme once cbmp decides to work
        package = pkgs.bibata-cursors.overrideAttrs {
          buildPhase = ''
            runHook preBuild
            ctgen build.toml -s ${toString cfg.cursor.size} -p x11 -d "$bitmaps/${cfg.cursor.name}" -n '${cfg.cursor.name}' -c '${cfg.cursor.name} variant'
            runHook postBuild
          '';
        };
        name = "Bibata-Modern-Classic";
        size = 20;
      };
    };
  };
}
