{
  pkgs,
  lib,
  config,
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
          command = "${getExe pkgs.greetd.tuigreet} --window-padding 1 --time --time-format '%R - %F' --remember --remember-session --asterisks";
          user = "greeter";
        };
      };
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
    power-profiles-daemon.enable = true;
    blueman.enable = true;

    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider =
        if config.programs.gamemode.enable
        then
          pkgs.ananicy-rules-cachyos.overrideAttrs {
            preInstall = ''
              rm -r 00-default/games
            '';
          }
        else pkgs.ananicy-cpp-rules;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
