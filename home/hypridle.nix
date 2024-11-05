{
  osConfig,
  lib,
  ...
}: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        unlock_cmd = "pkill --signal SIGUSR1 hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener =
        [
          {
            timeout = 300; # 5m
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330; # 5.5m
            on-timeout = "hyprctl dipsatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 600; # 10m
            on-timeout = "systemctl suspend";
          }
        ]
        ++ lib.optional osConfig.custom.mobile.enable {
          timeout = 120; # 2m
          on-timeout = "brightnessctl get > /tmp/brightness && brightnessctl set 5%";
          on-resume = "brightnessctl set $(cat /tmp/brightness || printf '32\%')";
        };
    };
  };
}
