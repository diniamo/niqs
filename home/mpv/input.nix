{
  programs.mpv.bindings = {
    MBTN_LEFT = "cycle pause";
    # TODO: mpv menu
    # MBTN_RIGHT = "script-binding uosc/menu";
    # menu = "script-binding uosc/menu";

    "0" = "seek 0 absolute";
    "$" = "seek -1 absolute";

    z = "script-message-to seek_to toggle-seeker";
    Z = "script-message-to seek_to paste-timestamp";
    y = "add sub-delay -0.1";
    Y = "add sub-delay +0.1";

    u = "script-binding undo";
    U = "script-binding undoCaps";
    TAB = "script-binding skip-to-silence";

    o = "script-binding modernx/show_osc";

    J = "cycle sub";
    K = "cycle sub down";

    "+" = "add volume 5";
    "-" = "add volume -5";
    "ö" = "add volume 5";
    "9" = "add volume -5";
    WHEEL_UP = "add volume 2";
    WHEEL_DOWN = "add volume -2";
  };
}
