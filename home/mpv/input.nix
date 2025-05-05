{
  programs.mpv.bindings = {
    MBTN_LEFT = "cycle pause";
    # TODO: mpv menu
    # MBTN_RIGHT = "script-binding uosc/menu";
    # menu = "script-binding uosc/menu";

    "0" = "seek 0 absolute";
    "$" = "seek -1 absolute";

    z = "script-binding toggle-seeker";
    Z = "script-binding paste-timestamp";
    y = "add sub-delay -0.1";
    Y = "add sub-delay +0.1";

    u = "script-binding undo";
    U = "script-binding undoCaps";
    TAB = "script-binding skip-to-silence";

    o = "script-binding show_osc";

    J = "cycle sub";
    K = "cycle sub down";

    RIGHT = "no-osd seek 5; script-binding show_osc";
    LEFT = "no-osd seek -5; script-binding show_osc";
    UP = "no-osd seek 85; script-binding show_osc";
    DOWN = "no-osd seek -85; script-binding show_osc";

    "+" = "no-osd add volume 5; script-binding show_osc";
    "-" = "no-osd add volume -5; script-binding show_osc";
    "ö" = "no-osd add volume 5; script-binding show_osc";
    "9" = "no-osd add volume -5; script-binding show_osc";
    WHEEL_UP = "no-osd add volume 2; script-binding show_osc";
    WHEEL_DOWN = "no-osd add volume -2; script-binding show_osc";
  };
}
