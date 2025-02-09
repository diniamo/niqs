{
  programs.mpv.bindings = {
    MBTN_LEFT = "cycle pause; script-binding uosc/flash-pause-indicator";
    p = "cycle pause; script-binding uosc/flash-pause-indicator";
    SPACE = "cycle pause; script-binding uosc/flash-pause-indicator";
    MBTN_RIGHT = "script-binding uosc/menu";
    menu = "script-binding uosc/menu";

    "0" = "seek 0 absolute";
    "$" = "seek -1 absolute";

    z = "script-message-to seek_to toggle-seeker";
    Z = "script-message-to seek_to paste-timestamp";
    y = "add sub-delay -0.1";
    Y = "add sub-delay +0.1";

    u = "script-binding undo; script-binding uosc/flash-timeline";
    U = "script-binding undoCaps; script-binding uosc/flash-timeline";
    TAB = "script-binding skip-to-silence";

    o = "script-message-to uosc flash-elements timeline,top_bar";

    h = "seek -5; script-binding uosc/flash-timeline";
    j = "seek -85; script-binding uosc/flash-timeline";
    k = "seek 85; script-binding uosc/flash-timeline";
    l = "seek 5; script-binding uosc/flash-timeline";

    J = "cycle sub";
    K = "cycle sub down";

    m = "no-osd cycle mute; script-binding uosc/flash-volume";
    "+" = "no-osd add volume 5; script-binding uosc/flash-volume";
    "-" = "no-osd add volume -5; script-binding uosc/flash-volume";
    "ö" = "no-osd add volume 5; script-binding uosc/flash-volume";
    "9" = "no-osd add volume -5; script-binding uosc/flash-volume";
    WHEEL_UP = "no-osd add volume 2; script-binding uosc/flash-volume";
    WHEEL_DOWN = "no-osd add volume -2; script-binding uosc/flash-volume";

    "[" = "no-osd add speed -0.25; script-binding uosc/flash-speed";
    "]" = "no-osd add speed 0.25; script-binding uosc/flash-speed";
    "BS" = "no-osd set speed 1; script-binding uosc/flash-speed";
    ">" = "script-binding uosc/next; script-message-to uosc flash-elements top_bar,timeline";
    "<" = "script-binding uosc/prev; script-message-to uosc flash-elements top_bar,timeline";
  };
}
