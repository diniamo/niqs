{ pkgs, packages, inputs, ... }: {
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
    noto-fonts-color-emoji
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  environment.systemPackages = with pkgs; with packages; [
    neovim
    htop
    wl-clipboard
    jerry
    vesktop
    pulsemixer
    playerctl
  ];
}
