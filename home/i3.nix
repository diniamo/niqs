{
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (osConfig.modules.style) font;
  colors = osConfig.modules.style.colorScheme.colorsWithPrefix;
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      colors = {
        focused = {
          background = colors.base00;
          text = colors.base05;
          indicator = colors.base06;
          border = colors.base07;
          childBorder = colors.base07;
        };
        focusedInactive = {
          background = colors.base00;
          text = colors.base05;
          indicator = colors.base06;
          border = colors.base04;
          childBorder = colors.base04;
        };
        unfocused = {
          background = colors.base00;
          text = colors.base05;
          indicator = colors.base06;
          border = colors.base04;
          childBorder = colors.base04;
        };
        urgent = {
          background = colors.base00;
          text = colors.base09;
          indicator = colors.base04;
          border = colors.base09;
          childBorder = colors.base09;
        };
        placeholder = {
          background = colors.base00;
          text = colors.base05;
          indicator = colors.base04;
          border = colors.base04;
          childBorder = colors.base04;
        };
        background = colors.base00;
      };
      defaultWorkspace = "workspace number 1";
      floating = {
        border = 1;
        titlebar = false;
      };
      fonts = {
        names = [font.name];
        style = "Regular";
        size = font.size + 0.0;
      };
      gaps = {
        smartBorders = "on";
        smartGaps = true;
      };
      menu = lib.getExe pkgs.onagre;
      modifier = "Mod4";
      terminal = "alacritty";
      window = {
        border = 1;
        titlebar = false;
      };
      startup = [
        {command = "setxkbmap -layout hu -option caps:super";}
      ];
    };
  };
}
