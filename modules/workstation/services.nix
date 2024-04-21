{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  services = {
    greetd = {
      enable = true;
      restart = true;
      settings = {
        default_session = {
          command = "${getExe pkgs.greetd.tuigreet} --window-padding 1 --time --time-format '%R - %F' --remember --asterisks --cmd Hyprland";
          user = "greeter";
        };
      };
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
    };
    power-profiles-daemon.enable = true;
    blueman.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
