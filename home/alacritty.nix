{
  flakePkgs,
  osConfig,
  ...
}: {
  programs.alacritty = {
    enable = true;
    package = flakePkgs.niqspkgs.alacritty-sixel;

    settings = {
      ipc_socket = osConfig.values.terminal.firstInstance != null;
      live_config_reload = false;
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        dynamic_padding = true;
        decorations = "None";
      };
      font.builtin_box_drawing = false;
      selection.save_to_clipboard = true;
      cursor = {
        style.shape = "Beam";
        vi_mode_style.shape = "Block";
      };
      terminal.osc52 = "Disabled";
      mouse.hide_when_typing = true;
    };
  };
}
