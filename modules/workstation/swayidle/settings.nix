{
  services.swayidle = {
    enable = true;

    extraFlags = [ "-w" ];

    events = [
      {
        event = "before-sleep";
        # loginctl lock-session doesn't seem to block, so I have to lock directly here
        command = "pidof swaylock || swaylock -f";
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

    timeouts = [
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
    ];
  };

  systemd.user.services.swayidle.serviceConfig.PassEnvironment = "SWAYSOCK";
}
