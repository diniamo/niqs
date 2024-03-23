{
  wayland.windowManager.hyprland.settings = {
    env = [
      "XDG_SESSION_TYPE, wayland"
      "XDG_CURRENT_DESKTOP, Hyprland"
      "XDG_SESSION_DESKTOP, Hyprland"

      "GDK_BACKEND, wayland"
      "SDL_VIDEODRIVER, wayland"
      "QT_QPA_PLATFORM, wayland;xcb"
    ];
    input = {
      kb_layout = "hu";
      kb_options = "caps:super";

      accel_profile = "flat";
      follow_mouse = 2;
      scroll_method = "on_button_down";

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.8;
        tap-to-click = false;
      };

      # -1 to 1 multiplier
      sensitivity = 0;
    };
    general = {
      gaps_in = 2;
      gaps_out = 2;
      border_size = 2;
      "col.active_border" = "rgb(8aadf4)";
      "col.inactive_border" = "rgb(494d64)";

      layout = "dwindle";
    };
    xwayland = {
      force_zero_scaling = true;
    };
    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      disable_autoreload = true;

      mouse_move_enables_dpms = false;
      key_press_enables_dpms = true;

      new_window_takes_over_fullscreen = 1;
    };
    decoration = {
      rounding = 10;

      blur.enabled = false;
      drop_shadow = false;
    };
    animations = {
      enabled = true;

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      special_scale_factor = 0.95;
    };
    gestures = {
      workspace_swipe = true;
      workspace_swipe_direction_lock = false;
      workspace_swipe_cancel_ratio = 0.15;
    };
    binds.allow_workspace_cycles = true;
    windowrule = [
      "pin, dragon-drop"
      "float, SVPManager"

      "tile, resolve"
      "float, title:resolve"

      "idleinhibit always, org.qbittorrent.qBittorrent"

      "noanim, ueberzugpp_.*"
    ];
    windowrulev2 = [
      "stayfocused, title:^()$, class:^(steam)$"
      "minsize 1 1, title:^()$, class:^(steam)$"
    ];
  };
}
