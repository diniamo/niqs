{
  osConfig,
  config,
  ...
}: let
  inherit (osConfig.values) terminal;

  noDecorations = "gapsin:0, gapsout:0, border:false, shadow:false, rounding:false";
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "XDG_SESSION_DESKTOP, Hyprland"

      "GDK_BACKEND, wayland"
      "SDL_VIDEODRIVER, wayland,x11,windows"
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
      gaps_in = 0;
      gaps_out = 0;
      border_size = 1;

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
      middle_click_paste = false;
      focus_on_activate = true;

      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;

      mouse_move_enables_dpms = false;
      key_press_enables_dpms = true;

      new_window_takes_over_fullscreen = 1;
      exit_window_retains_fullscreen = true;
    };
    cursor = {
      no_hardware_cursors = 0;
    };
    render = {
      explicit_sync = 1;
      explicit_sync_kms = 1;
      expand_undersized_textures = false;
    };
    opengl.nvidia_anti_flicker = false;
    decoration = {
      rounding = 0;

      blur.enabled = false;
      shadow.enabled = false;
    };
    animations = {
      enabled = true;

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.1";

      animation = [
        "windows, 1, 5, myBezier"
        "windowsOut, 1, 5, default, popin 80%"
        "windowsMove, 1, 5, default, popin 80%"
        "fade, 1, 5, default"
        "border, 1, 5, default"
        "borderangle, 0, 8, default"
        # "workspaces, 1, 5, myBezier"
        # "specialWorkspace, 1, 5, myBezier, slidevert"
        "workspaces, 0"
        "specialWorkspace, 0"
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
      workspace_center_on = 1;
    };
    group = {
      insert_after_current = false;
      drag_into_group = 2;
      merge_groups_on_drag = false;

      groupbar = {
        font_family = config.stylix.fonts.sansSerif.name;
        font_size = config.stylix.fonts.sizes.desktop;
      };
    };
    windowrule = [
      "pin, ^(dragon)$"
      "float, ^(SVPManager)$"
      "float, ^(xdg-desktop-portal-gtk)$"
      "idleinhibit always, ^(org.qbittorrent.qBittorrent)$"
      "noanim, ^(ueberzugpp_)(.*)$"
    ];
    windowrulev2 = [
      # These 2 should fix floating windows
      "stayfocused, initialtitle:^()$, initialclass:^(steam)$"
      "minsize 1 1, initialtitle:^()$, initialclass:^(steam)$"
      "maximize, initialtitle:^(\S+)$, initialclass:^(steamwebhelper)$"

      "immediate, initialclass:^(steam_app_)(.*)$"
      "fullscreen, initialclass:^(steam_app_)(.*)$"
    ];
    workspace = [
      "w[v1] s[false], ${noDecorations}"
      "f[1], ${noDecorations}"

      "special:terminal, on-created-empty:${terminal.command}"
      "special:mixer_gui, on-created-empty:pavucontrol"
      "special:mixer_tui, on-created-empty:${terminal.command} ${terminal.separator} pulsemixer"
      "special:music_gui, on-created-empty:spotify"
      "special:music_tui, on-created-empty:${terminal.command} ${terminal.separator} spotify_player"
      "special:calculator_gui, on-created-empty:qalculate-qt"
      "special:calculator_tui, on-created-empty:${terminal.command} ${terminal.separator} qalc"
      "special:file_manager_gui, on-created-empty:thunar"
      "special:file_manager_tui, on-created-empty:${terminal.command} ${terminal.separator} yazi"
    ];
  };
}
