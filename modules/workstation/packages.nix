{
  pkgs,
  inputs,
  config,
  wrappedPkgs,
  ...
}: let
  inherit (config) values;
  xdgPortalName = config.xdg.portal.name;
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs."xdg-desktop-portal-${xdgPortalName}"];
    config.common.default = ["hyprland" xdgPortalName];
  };

  programs.zsh.enable = true;
  users.users.${values.mainUser}.shell = config.home-manager.users.${values.mainUser}.programs.zsh.package;

  environment.sessionVariables = {
    # For electron apps
    NIXOS_OZONE_WL = "1";
    LESS = "-R";
  };

  fonts.packages = let
    inherit (config.modules.style) font monoFont;
  in
    with pkgs; [
      font.package
      monoFont.package

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
    ];

  environment.systemPackages = with pkgs; [
    wrappedPkgs.xdragon

    wl-clipboard
    neovide
    spotify
    trash-cli
    rmtrash
    ungoogled-chromium
    yt-dlp
    libreoffice-qt
    libqalculate
    qalculate-qt
    pulsemixer
    eza
    libnotify
    gist
    obsidian
    vesktop
  ];
}
