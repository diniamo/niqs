{
  lib,
  osConfig,
  ...
}: {
  services.swayidle = {
    enable = true;

    extraArgs = ["-w"];

    events = [
      # loginctl lock-session doesn't seem to block, so I have to lock directly here
      {
        event = "before-sleep";
        command = "pidof swaylock || swaylock -f";
      }
      # Wakeups don't trigger the resumeCommand below for some reason
      {
        event = "after-resume";
        command = "swaymsg 'output * power on'";
      }
      {
        event = "lock";
        command = "pidof swaylock || swaylock -f";
      }
      {
        event = "unlock";
        command = "pkill -USR1 swaylock";
      }
    ];

    timeouts =
      [
        {
          timeout = 300;
          command = "loginctl lock-session";
        }
        {
          timeout = 330;
          command = "swaymsg 'output * power off'";
          resumeCommand = "swaymsg 'output * power on'";
        }
        {
          timeout = 600;
          command = "systemctl suspend";
        }
      ]
      ++ lib.optional osConfig.custom.mobile.enable {
        timeout = 240;
        command = "brightnessctl get > /tmp/brightness; brightnessctl set 5%";
        resumeCommand = "brightnessctl set \"$(cat /tmp/brightness || echo -n 32%)\"";
      };
  };

  systemd.user.services.swayidle.Service = {
    Environment = lib.mkForce [];
    PassEnvironment = "PATH SWAYSOCK";
  };
}
