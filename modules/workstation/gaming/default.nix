{ lib, config, pkgs, ... }: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.custom.gaming;
in {
  imports = [
    ./gamemode.nix
    ./pipewire-low-latency.nix
    ./platform-optimizations.nix
  ];

  options = {
    custom.gaming = {
      enable = mkEnableOption "gaming settings";
    };
  };

  config = mkIf cfg.enable {
    custom.mangohud.enable = true;

    services.pipewire.alsa.support32Bit = true;
    security.rtkit.enable = true;
    hardware.xpadneo.enable = true;
    hardware.graphics.enable32Bit = true;

    environment = {
      systemPackages = [(pkgs.lutris.override {
        # I can still use the Steam from my environment, which is what I want, since it has wrapper options set.
        steamSupport = false;
      })];

      sessionVariables.PROTON_ENABLE_WAYLAND = 1;
    };

    home.files.".local/share/lutris/runners/proton/GE-Proton".source = pkgs.proton-ge-bin.steamcompattool;

    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;

        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
    };
  };
}
