{
  pkgs,
  inputs,
  config,
  wrappedPkgs,
  ...
}: let
  inherit (config) values;
  xdgPortalName = config.xdg.portal.name;

  flags =
    if config.modules.nvidia.enable
    then ["--disable-gpu"]
    else [];
  wrapped = inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          discord = {
            basePackage = pkgs.webcord;
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

  environment.systemPackages = with pkgs; [
    wrapped
    wrappedPkgs.xdragon

    wl-clipboard
    neovide
    spotify
    trash-cli
    ungoogled-chromium
    yt-dlp
    libreoffice
    libqalculate
    pulsemixer
    rmtrash
    eza
  ];
}
