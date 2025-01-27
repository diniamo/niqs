{
  pkgs,
  lib,
  config,
  ...
}: {
  systemd.user.services.polkit-authentication-agent = {
    description = "PolicyKit Authentication Agent";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
    };
    wantedBy = ["graphical-session.target"];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "gtk";
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
        else pkgs.ananicy-rules-cachyos;
    };
    power-profiles-daemon.enable = true;

    # printing = {
    #   enable = true;
    #   drivers = [pkgs.canon-cups-ufr2];
    # };
    #
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };

    blueman.enable = true;

    interception-tools = {
      enable = true;
      plugins = [pkgs.interception-tools-plugins.caps2esc];
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
