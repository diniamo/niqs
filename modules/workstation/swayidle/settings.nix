{ pkgs, lib, config, ... }: let
  inherit (lib) getExe getExe';

  pidof = getExe' pkgs.procps "pidof";
  swaylock = getExe config.custom.swaylock.finalPackage;
  loginctl = getExe' config.systemd.package "loginctl";
  swaymsg = getExe' config.programs.sway.package "swaymsg";
  systemctl = getExe' config.systemd.package "systemctl";
in {
  custom.swayidle = {
    enable = true;

    extraFlags = [ "-w" ];

    events = [
      {
        type = "before-sleep";
        # loginctl lock-session doesn't seem to block, so I have to lock directly here
        command = "${pidof} swaylock || ${swaylock} --daemonize";
      }
      {
        type = "lock";
        command = "${pidof} swaylock || ${swaylock} --daemonize";
      }
      {
        type = "unlock";
        command = "${getExe' pkgs.procps "pkill"} -USR1 --exact swaylock";
      }
    ];

    timeouts = [
      {
        time = 300;
        command = "${loginctl} lock-session";
      }
      {
        time = 330;
        command = "${swaymsg} 'output * power off'";
        resume = "${swaymsg} 'output * power on'";
      }
      {
        time = 600;
        command = "${systemctl} suspend";
      }
    ];
  };
}
