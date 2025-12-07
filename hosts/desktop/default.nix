{ config, pkgs, ... }: {
  imports = [ ./hardware.nix ];

  custom = {
    boot.secure = true;
    amdgpu.enable = true;
    gaming = {
      enable = true;
      vr = true;
    };

    mpv.profiles.anime = {
      # 15-15 GiB
      demuxer-max-bytes = 16106127360;
      demuxer-max-back-bytes = 16106127360;
    };
  };

  hardware.opentabletdriver.enable = true;

  user.packages = with pkgs; [
    transmission_4-gtk
    anki
    krita
  ];

  custom.dwl.monitors = {
    DP-1 = { x = 0; y = 0; mode = 1; adaptive = true; };
    DP-2 = { x = 1920; y = 0; };
  };

  networking = {
    hostName = "${config.user.name}-PC";
    firewall.allowedTCPPorts = [ 5300 ];
  };

  system.stateVersion = "23.11";
}
