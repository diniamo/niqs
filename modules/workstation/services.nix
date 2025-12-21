{ pkgs, lib, config, ... }: {
  systemd.user.services.polkit-authentication-agent = {
    description = "PolicyKit Authentication Agent";
    serviceConfig.ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
    wantedBy = [ "graphical-session.target" ];
  };

  security.pam.services.greetd.enableGnomeKeyring = true;

  services = {
    gnome.gnome-keyring.enable = true;

    greetd = {
      enable = true;
      restart = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet} --window-padding 1 --time --time-format '%R - %F' --remember --remember-session --asterisks";
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

    blueman.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
