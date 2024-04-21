{osConfig, ...}: let
  inherit (osConfig.modules.style) font;
  inherit (osConfig.modules.style.colorScheme) slug;
in {
  programs.zathura = {
    enable = true;
    options = {
      font = "${font.name} ${font.sizeString}";
    };
    mappings = {
      h = "feedkeys '<C-Left>'";
      j = "feedkeys '<C-Down>'";
      k = "feedkeys '<C-Up>'";
      l = "feedkeys '<C-Right>'";
    };
    extraConfig = builtins.readFile ./themes/${slug};
  };
}
