{
  pkgs,
  flakePkgs,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) throwIf versionOlder;

  inherit (config.modules.general) xdgDesktopPortal;
  inherit (config.modules) values;

  hmPrograms = config.home-manager.users.${values.mainUser}.programs;

  flags =
    if values.nvidia
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
    extraPortals = [pkgs."xdg-desktop-portal-${xdgDesktopPortal}"];
    config.common.default = ["hyprland" "${xdgDesktopPortal}"];
  };

  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };
  services.power-profiles-daemon.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # This is needed for Obsidian until they update to a newer electron version
  # https://github.com/NixOS/nixpkgs/issues/273611
  nixpkgs.config.permittedInsecurePackages = throwIf (versionOlder "1.5.3" pkgs.obsidian.version) "Obsidian has been updated, check if it still requires electron 25 and if not, remove this line, then rebuild" ["electron-25.9.0"];

  programs.zsh.enable = true;
  users.users.${values.mainUser}.shell = hmPrograms.zsh.package;

  fonts.packages = with pkgs; [
    inter
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  environment.systemPackages = let
    nixpkgs = with pkgs; [
      wrapped

      wl-clipboard
      pulsemixer
      neovide
      spotify
      trash-cli # TODO: rmtrash in shell configuration
      streamlink-twitch-gui-bin
      chatterino2
      xfce.thunar
      yt-dlp
      fzf
    ];

    mpv = hmPrograms.mpv.package;
    flakePackages = with flakePkgs; [
      (jerry.jerry.override {inherit mpv;})
      (lobster.lobster.override {inherit mpv;})
    ];
  in
    nixpkgs ++ flakePackages;
}
