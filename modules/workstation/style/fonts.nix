{
  pkgs,
  config,
  ...
}: let
  inherit (config.stylix) fonts;
in {
  stylix.fonts = {
    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
      path = "${fonts.sansSerif.package}/share/fonts/truetype/Inter.ttc";
    };

    # Inter superiority
    serif = fonts.sansSerif;

    # This is the default but specify anyway
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
      path = "${fonts.emoji.package}/share/fonts/noto/NotoColorEmoji.ttf";
    };

    monospace = {
      package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      name = "JetBrainsMono Nerd Font Mono";
      path = "${fonts.monospace.package}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFontMono-Regular.ttf";
    };
  };
}
