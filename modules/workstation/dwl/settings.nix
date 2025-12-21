{ config, pkgs, flakePkgs, lib, inputs, ... }: let
  inherit (lib) getExe getExe' optionalString;
  inherit (pkgs.writers) writeDash;
  inherit (config.custom) style;

  inherit (config) custom;
  scripts = import ./scripts.nix { inherit pkgs flakePkgs lib config; };

  foot = getExe custom.foot.finalPackage;
  fuzzel = getExe custom.fuzzel.finalPackage;
  helium = getExe flakePkgs.niqspkgs.helium;
  still = getExe flakePkgs.niqspkgs.still;
  grim = getExe pkgs.grim;
  slurp = getExe pkgs.slurp;
  wl-copy = getExe' pkgs.wl-clipboard "wl-copy";
  playerctl = getExe pkgs.playerctl;
  wpctl = getExe' pkgs.wireplumber "wpctl";
  makoctl = getExe' custom.mako.package "makoctl";
  brightnessctl = getExe pkgs.brightnessctl;

  screenshotMonitor = writeDash "screenshot-monitor.sh" ''
    set -e
    read MONITOR
    ${grim} -o "$MONITOR" - | ${wl-copy} --type image/png
  '';
  screenshotWindow = writeDash "screenshot-window.sh" ''
    set -e
    read MONITOR
    read X Y WIDTH HEIGHT
    ${grim} -g "$X,$Y ''${WIDTH}x''${HEIGHT}" - | ${wl-copy} --type image/png
  '';
in {
  custom.style.matugen.templates.dwl-colors.input = ./colors.h;

  custom.dwl = {
    enable = true;
    package = pkgs.dwl.overrideAttrs { src = inputs.dwl; };

    # TODO: screenshot current monitor/window
    # This is a pretty hacky way of embedding paths, but I want to keep as much
    # configuration in the header file as possible, without resorting to things
    # like replaceVars
    settings = ''
      #include "${style.matugen.templates.dwl-colors.output}"
      static const char *cursor_theme  = "${style.cursor.name}";
      static const char  cursor_size[] = "${style.cursor.sizeString}";

      #include "${./config.h}"
        { MOD,   KEY(Return),               spawn,     CMD("${foot}") },
        { MOD,   KEY(space),                spawn,     CMD("${fuzzel}") },
        { MOD,   KEY(w),                    spawn,     CMD("${helium}") },
        { 0,     KEY(XF86Tools),            spawn,     CMD("${getExe pkgs.spotify}") },
        { 0,     KEY(XF86Calculator),       spawn,     CMD("${foot}", "${getExe pkgs.libqalculate}") },
        { 0,     KEY(XF86HomePage),         spawn,     CMD("${helium}") },

        { MOD,   KEY(g),                    spawn,     CMD("${scripts.notifyInformation}") },
        { MOD,   KEY(i),                    spawn,     CMD("${scripts.toggleInhibitor}") },
        { MOD,   KEY(x),                    spawn,     CMD("${scripts.logoutMenu}") },

        { MOD,   KEY(BackSpace),            spawn,     CMD("${makoctl}", "dismiss") },
        { MOD,   KEY(o),                    spawn,     CMD("${makoctl}", "menu", "--", "${fuzzel}", "--dmenu", "--placeholder", "Select action") },

        { 0,     KEY(Print),                spawninfo, CMD("${screenshotMonitor}") },
        { ALT,   KEY(Sys_Req),              spawninfo, CMD("${screenshotWindow}") },
        { CTRL,  KEY(Print),                spawn,     SH("${still} -c '${slurp} | ${grim} -g - -' | ${wl-copy} --type image/png") },
        { SHIFT, KEY(Print),                spawn,     SH("${still} -c '${slurp} | ${grim} -g - -' | ${getExe custom.imv.finalPackage} -") },
        { MOD,   KEY(e),                    spawn,     SH("${getExe' pkgs.wl-clipboard "wl-paste"} | ${getExe custom.satty.finalPackage} --filename -") },
        { MOD,   KEY(c),                    spawn,     SH("${getExe pkgs.hyprpicker} --autocopy") },

        { 0,     KEY(XF86AudioNext),        spawn,     CMD("${playerctl}", "next") },
        { 0,     KEY(XF86AudioPrev),        spawn,     CMD("${playerctl}", "previous") },
        { 0,     KEY(XF86AudioPlay),        spawn,     CMD("${playerctl}", "play-pause") },
        { 0,     KEY(XF86AudioStop),        spawn,     CMD("${playerctl}", "position", 0) },
        { 0,     KEY(XF86AudioLowerVolume), spawn,     CMD("${wpctl}", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05-") },
        { 0,     KEY(XF86AudioRaiseVolume), spawn,     CMD("${wpctl}", "set-volume", "@DEFAULT_AUDIO_SINK@", "0.05+") },
        { 0,     KEY(XF86AudioMute),        spawn,     CMD("${wpctl}", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle") },
        ${optionalString config.custom.mobile.enable ''
        { 0, KEY(XF86MonBrightnessDown), spawn, CMD("${brightnessctl}", "set", "2%-", "-n") },
        { 0, KEY(XF86MonBrightnessUp),   spawn, CMD("${brightnessctl}", "set", "2%+") },
        ''}
      };
    '';
  };
}
