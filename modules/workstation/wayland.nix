{
  environment.sessionVariables = {
    SDL_VIDEODRIVER = "wayland,x11,windows";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland";
  };
}
