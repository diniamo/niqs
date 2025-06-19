{
  custom.mpv.inputSettings = {
    MBTN_LEFT = "cycle pause";

    MBTN_RIGHT = "script-binding select/menu";
    menu = "script-binding select/menu";
    "`" = "script-binding commands/open";
    "/" = "script-binding commands/open";
    "Alt+x" = "script-binding M-x";

    "0" = "no-osd seek 0 absolute; script-binding show_osc";
    "$" = "set pause yes; no-osd seek -1 absolute; script-binding show_osc";

    y = "add sub-delay -0.1";
    Y = "add sub-delay +0.1";
    z = "script-binding toggle-seeker";
    Z = "script-binding paste-timestamp";
    u = "revert-seek";
    U = "cycle-values sub-ass-override force scale";
    TAB = "script-binding skip-to-silence";

    o = "script-binding show_osc";

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
