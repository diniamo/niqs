{ lib, pkgs, config, inputs, ... }: let
  inherit (lib) mkEnableOption mkForce mkIf getExe getExe';
  inherit (pkgs) coreutils;

  brightnessctl = getExe pkgs.brightnessctl;
in {
  imports = [ inputs.watt.nixosModules.default ];

  options = {
    custom.mobile.enable = mkEnableOption "configuration for mobile devices";
  };

  config = mkIf config.custom.mobile.enable {
    environment.systemPackages = [ pkgs.brightnessctl ];

    networking.networkmanager = {
      enable = true;
      plugins = mkForce [];
    };

    services = {
      # For remote rebuilding, since mobile devices are usually weak
      openssh = {
        enable = true;
        startWhenNeeded = true;
        settings.PermitRootLogin = "yes";
      };

      power-profiles-daemon.enable = mkForce false;
      watt.enable = true;
      upower.enable = true;
      thermald.enable = true;
    };

    systemd.user.services.poweralertd = {
      description = "Power Alert Daemon";
      serviceConfig.ExecStart = getExe pkgs.poweralertd;
      requires = [ "mako.service" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };

    custom = {
      sway.settings = ''
        bindsym XF86MonBrightnessDown exec ${brightnessctl} set 2%- -n
        bindsym XF86MonBrightnessUp exec ${brightnessctl} set 2%+
      '';

      swayidle.timeouts = [{
        time = 240;
        command = "${brightnessctl} get >/tmp/brightness; ${brightnessctl} set 5%";
        resume = "${brightnessctl} set \"$(${getExe' coreutils "cat"} /tmp/brightness || ${getExe' coreutils "echo"} -n 35%)\"";
      }];

      mpv = {
        # Disable all the high quality stuff for battery life
        settings.profile = mkForce null;
        profiles.anime = mkForce {
          sub-visibility = true;
        };
      };
    };
  };
}
