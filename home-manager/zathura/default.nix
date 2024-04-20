{osConfig, ...}: let
  inherit (osConfig.modules) style;

  inherit (style) font;
  theme = style.colorScheme.slug;
in {
  programs.zathura = {
    enable = true;
    options = {
      font = "${font.name} ${font.sizeString}";
      smooth-scroll = true;
    };
    mappings = {
      h = "feedkeys '<C-Left>'";
      j = "feedkeys '<C-Down>'";
      k = "feedkeys '<C-Up>'";
      l = "feedkeys '<C-Right>'";
    };
    extraConfig = builtins.readFile ./themes/${theme};
  };
}
