{
  pkgs,
  inputs,
  config,
  wrappedPkgs,
  ...
}: let
  inherit (config) values;
  xdgPortalName = config.xdg.portal.name;

  electronPackages =
    if config.modules.nvidia.enable
    then
      with wrappedPkgs; [
        obsidian-nvidia
        webcord-nvidia
      ]
    else
      with pkgs; [
        obsidian
        webcord
      ];
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

  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

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

  environment.systemPackages = with pkgs;
    [
      wrappedPkgs.xdragon

      wl-clipboard
      neovide
      spotify
      trash-cli
      ungoogled-chromium
      yt-dlp
      libreoffice-qt
      libqalculate
      pulsemixer
      rmtrash
      eza
      libnotify
      dolphin
    ]
    ++ electronPackages;
}
