{osConfig, ...}: let
  inherit (osConfig.modules.style) monoFont;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [./themes/${osConfig.modules.style.colorScheme.slug}.toml];
      live_config_reload = false;
      ipc_socket = false;

      window = {
        padding = {
          x = 10;
          y = 10;
        };
        dynamic_padding = true;
        decorations = "None";
      };
      font = {
        normal = {
          style = "Regular";
          family = monoFont.name;
        };
        inherit (monoFont) size;
        builtin_box_drawing = false;
      };
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
