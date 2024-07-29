{osConfig, ...}: let
  inherit (osConfig.values) terminal;

  noDecorations = "gapsin:0, gapsout:0, border:false, shadow:false, rounding:false, decorate:false";
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "XDG_SESSION_DESKTOP, Hyprland"

      "GDK_BACKEND, wayland"
      "SDL_VIDEODRIVER, wayland"
      "QT_QPA_PLATFORM, wayland;xcb"
    ];
    input = {
      kb_layout = "hu";
      kb_options = "caps:swapescape,altwin:swap_lalt_lwin";

      accel_profile = "flat";
      scroll_method = "on_button_down";

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.8;
        tap-to-click = false;
      };
    };
    general = {
      gaps_in = 2;
      gaps_out = 2;
      border_size = 1;

      layout = "dwindle";
    };
    xwayland.force_zero_scaling = true;
    # Firefox is broken
    # experimental.explicit_sync = true;
    # opengl.nvidia_anti_flicker = false;
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      disable_autoreload = true;

      mouse_move_enables_dpms = false;
      key_press_enables_dpms = true;

      new_window_takes_over_fullscreen = 1;
      # Workaround for #6038 / #6237
      initial_workspace_tracking = 0;
    };
    decoration = {
      rounding = 10;

      blur.enabled = false;
      drop_shadow = false;
    };
    animations = {
      enabled = false;

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.1";

      animation = [
        "windows, 1, 5, myBezier"
        "windowsOut, 1, 5, default, popin 80%"
        "windowsMove, 1, 5, default, popin 80%"
        "fade, 1, 5, default"
        "border, 1, 5, default"
        "borderangle, 0, 8, default"
        "workspaces, 1, 5, myBezier"
        "specialWorkspace, 1, 5, myBezier, slidevert"
      ];
    };
    dwindle = {
      pseudotile = true;
      force_split = 2;
      special_scale_factor = 0.95;
    };
    gestures = {
      workspace_swipe = true;
      workspace_swipe_direction_lock = false;
      workspace_swipe_cancel_ratio = 0.15;
    };
    binds = {
      allow_workspace_cycles = true;
    };
    windowrule = [
      "pin, ^(dragon)$"
      "float, ^(SVPManager)$"
      "float, ^(org.freedesktop.impl.portal.desktop.kde)$"
      "idleinhibit always, ^(org.qbittorrent.qBittorrent)$"
      "noanim, ^(ueberzugpp_)(.*)$"
      "immediate, ^(steam_app_)(.*)$"
      "fullscreen, ^(steam_app_)(.*)$"
    ];
    windowrulev2 = [
      # These 2 should fix floating windows
      "stayfocused, initialtitle:^()$, initialclass:^(steam)$"
      "minsize 1 1, initialtitle:^()$, initialclass:^(steam)$"
      "maximize, initialtitle:^(\S+)$, initialclass:^(steamwebhelper)$"
    ];
    workspace = [
      "w[v1] s[false], ${noDecorations}"
      "f[1], ${noDecorations}"

      "special:terminal, on-created-empty:${terminal.command}"
      "special:mixer, on-created-empty:${terminal.command} ${terminal.separator} pulsemixer"
      "special:music, on-created-empty:spotify"
      # The library spotify-player uses for sixel checks TERM for supported terminals
      # so we fake it, since alacritty isn't in the list
      "special:music_tui, on-created-empty:${terminal.command} ${terminal.separator} env TERM=xterm-256color spotify_player"
      "special:calculator, on-created-empty:qalculate-qt"
      "special:file_manager, on-created-empty:${terminal.command} ${terminal.separator} yazi"
      "special:file_manager_gui, on-created-empty:thunar"
    ];
  };
}
