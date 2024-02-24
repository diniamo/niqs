{ pkgs, packages, inputs, lib, config, ... }: 
let
  inherit (lib) throwIf versionOlder;

  electronFlags = pkg: if config.modules.values.nvidia then
    pkg.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        sed -Ei "s/(Exec=\w+)/\0 --disable-gpu/" "$out/share/applications/${pkg.pname}.desktop"
      '';
    })
  else pkg;
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
    inter
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];
  
  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # This is needed for Obsidian until they update to a newer electron version
  # https://github.com/NixOS/nixpkgs/issues/273611
  nixpkgs.config.permittedInsecurePackages = throwIf (versionOlder "1.5.3" pkgs.obsidian.version) "Obsidian has been updated, check if it still requires electron 25 and if not, remove this line, then rebuild" ["electron-25.9.0"];

  environment.systemPackages = with pkgs; [
    htop
    wl-clipboard
    (electronFlags vesktop)
    pulsemixer
    playerctl
    (electronFlags obsidian)
    neovide
    spotify

    packages.jerry
  ];
}
