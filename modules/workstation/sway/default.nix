{ pkgs, lib, config, ... }: let
  inherit (lib) mkOption mkIf getExe getExe';
  inherit (lib.types) lines;

  inherit (config.custom.sway) settings;
  inherit (config.programs.sway) package;
in {
  imports = [ ./settings.nix ];

  options = {
    custom.sway = {
      settings = mkOption {
        type = lines;
        default = "";
        description = "Sway configuration.";
      };
    };
  };

  config = {
    programs.sway = {
      enable = true;
      extraPackages = [];
      wrapperFeatures.base = false;
    };

    xdg.portal = {
      config.sway."org.freedesktop.impl.portal.Screenshot.PickColor" = getExe pkgs.hyprpicker;
      wlr.settings.screencast.max_fps = 60;
    };

    environment.sessionVariables = {
      WLR_RENDERER = "vulkan";
      SDL_VIDEODRIVER = "wayland,x11,windows";
      QT_QPA_PLATFORM = "wayland;xcb";
      GDK_BACKEND = "wayland";
    };

    home.files.".config/sway/config" = mkIf (settings != "") {
      name = "sway-config";
      text = settings;
      onChange = ''
        socket="/run/user/$UID/sway-ipc.$UID.$(${getExe' pkgs.procps "pgrep"} --uid $UID --exact .sway-wrapped).sock" &&
          test -S $socket &&
          ${getExe' package "swaymsg"} --socket $socket reload &>/dev/null
      '';
    };
  };
}
