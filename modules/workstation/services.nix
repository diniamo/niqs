{
  pkgs,
  lib,
  config,
  ...
}: {
  systemd.services.polkit-authentication-agent = {
    description = "PolicyKit Authentication Agent";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
    };
    wantedBy = ["graphical-session.target"];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-kde];
    config.common.default = ["kde"];
  };

  services = {
    greetd = {
      enable = true;
      restart = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.greetd.tuigreet} --window-padding 1 --time --time-format '%R - %F' --remember --remember-session --asterisks";
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
    playerctld.enable = true;

    power-profiles-daemon.enable = true;
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

    blueman.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
