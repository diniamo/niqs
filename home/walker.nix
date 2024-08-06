{
  inputs,
  flakePkgs,
  ...
}: {
  imports = [inputs.walker.homeManagerModules.default];

  programs.walker = {
    enable = true;
    package = flakePkgs.walker.default;
    runAsService = true;

    config = {
      theme_base = ["catppuccin"];

      activation_mode.disabled = true;
      ignore_mouse = true;
    };

    theme = {
      layout = {
        ui.window.box = {
          v_align = "center";
          orientation = "vertical";
        };
      };

      style = ''
        child {
          border-radius: 0;
        }
      '';
    };
  };
}
