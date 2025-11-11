{
  environment.sessionVariables = {
    SDL_VIDEODRIVER = "wayland,x11,windows";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
