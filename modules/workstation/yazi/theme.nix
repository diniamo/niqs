{
  programs.yazi.settings.theme = {
    mgr = {
      preview_hovered = { bold = true; };
      find_keyword = { fg = "green"; bold = true; };
      find_position = { italic = true; hidden = true; };
      marker_marked = { fg = "cyan"; bg = "cyan"; };
      marker_selected = { fg = "lightcyan"; bg = "lightcyan"; };
      count_copied = { fg = "green"; };
      count_cut = { fg = "yellow"; };
      count_selected = { fg = "cyan"; };
      syntect_theme = ./syntect.tmTheme;
    };

    mode = {
      normal_main = { fg = "black"; bg = "blue"; };
      normal_alt = { fg = "blue"; bg = "darkgray"; };
      select_main = { fg = "black"; bg = "lightcyan"; };
      select_alt = { fg = "lightcyan"; bg = "darkgray"; };
      unset_main = { fg = "black"; bg = "red"; };
      unset_alt = { fg = "red"; bg = "darkgray"; };
    };

    tabs = {
      sep_inner = { open = ""; close = ""; };
      sep_outer = { open = ""; close = ""; };
      active = { fg = "lightcyan"; bg = "reset"; bold = true; };
      inactive = { fg = "darkgray"; bg = "reset"; };
    };
  };
}
