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
      thermald.enable = true;
    };

    custom = {
      sway.settings = ''
        bindsym XF86MonBrightnessDown exec ${brightnessctl} set 2%- -n
        bindsym XF86MonBrightnessUp exec ${brightnessctl} set 2%+
      '';

      swayidle.timeouts = [{
        time = 240;
        command = "${brightnessctl} get >/tmp/brightness; ${brightnessctl} set 5%";
        resume = "${brightnessctl} set \"$(${getExe' coreutils "cat"} /tmp/brightness || ${getExe' coreutils "echo"} -n 32%)\"";
      }];
    };
  };
}
