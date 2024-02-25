{
  pkgs,
  packages,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) throwIf versionOlder mkIf;

  nvidia = config.modules.values.nvidia;
  flags =
    if nvidia
    then ["--disable-gpu"]
    else [];
  wrapped = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          vesktop = {
            basePackage = pkgs.vesktop;
            inherit flags;
          };
          obsidian = {
            basePackage = pkgs.obsidian;
            inherit flags;
          };
        };
      }
    ];
  };
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
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
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # This is needed for Obsidian until they update to a newer electron version
  # https://github.com/NixOS/nixpkgs/issues/273611
  nixpkgs.config.permittedInsecurePackages = throwIf (versionOlder "1.5.3" pkgs.obsidian.version) "Obsidian has been updated, check if it still requires electron 25 and if not, remove this line, then rebuild" ["electron-25.9.0"];

  environment.systemPackages = let
    nixpkgs = with pkgs; [
      wrapped

      wl-clipboard
      pulsemixer
      playerctl
      neovide
      spotify
      btop
    ];
    flakepkgs = with packages; [
      jerry.jerry
      lobster.lobster
      hyprwm-contrib.grimblast
    ];
  in
    nixpkgs ++ flakepkgs;
}
