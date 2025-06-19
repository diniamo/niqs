{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe getExe';

  inherit (config) custom programs;
  scripts = import ./scripts.nix { inherit pkgs lib config; };

  settingsFile = pkgs.replaceVars {
    src = ./config;
    replacements = {
      # font = ;
      # fontSize = ;
      # background = ;

      # cursorTheme = ;
      # cursorSize = ;
      
      # colorsFocused = ;
      # colorsFocusedInactive = ;
      # colorsUnfocused = ;
      # colorsUrgent = ;
      # colorsPlaceholder = ;
      # colorsBackground = ;

      fuzzel = getExe custom.fuzzel.finalPackage;
      foot = getExe programs.foot.package;
      emacs = getExe custom.emacs.finalPackage;
      librewolf = getExe custom.librewolf.finalPackage;
      spotify = getExe pkgs.spotify;

      grim = getExe pkgs.grim;
      imv = getExe custom.imv.finalPackage;
      satty = getExe custom.satty.finalPackage;
      wl-copy = getExe' pkgs.wl-clipboard "wl-copy";
      wl-paste = getExe' pkgs.wl-clipboard "wl-paste";

      playerctl = getExe pkgs.playerctl;
      wpctl = getExe' pkgs.wireplumber "wpctl";
      brightnessctl = getExe pkgs.brightnessctl;

      inherit (scripts) notifyTime toggleInhibitSleep logoutMenu;
    };
  };
in {
  programs.sway = {
    enable = true;
    extraPackages = [];
    extraOptions = [ "--config" settingsFile ];
  };

  xdg.portal = {
    config.sway."org.freedesktop.impl.portal.Screenshot.PickColor" = lib.getExe pkgs.hyprpicker;
    wlr.settings.screencast = {
      max_fps = 60;
    };
  };

  environment.sessionVariables = {
    SDL_VIDEODRIVER = "wayland,x11,windows";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland";
  };

  fonts.fontconfig.subpixel.rgba = "rgb";
}
