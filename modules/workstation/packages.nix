{ pkgs, packages, inputs, lib, ... }: 
let
  inherit (lib) throwIf versionOlder;
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # For flameshot, might use it in the future
    config.common = {
      default = "gtk";
      "org.freedesktop.impl.portal.Screencast" = "hyprland";
      "org.freedesktop.impl.portal.Screenshot" = "hyprland";
    };
  };
  
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts-extra
    inter
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  # This is needed for Obsidian until they update to a newer electron version
  # https://github.com/NixOS/nixpkgs/issues/273611
  nixpkgs.config.permittedInsecurePackages = throwIf (versionOlder "1.5.3" pkgs.obsidian.version) "Obsidian has been updated, check if it still requires electron 25 and if not, remove this line, then rebuild" ["electron-25.9.0"];

  environment.systemPackages = with pkgs; with packages; [
    htop
    wl-clipboard
    vesktop
    pulsemixer
    playerctl
    obsidian

    jerry
  ];
}
