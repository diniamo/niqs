{
  pkgs,
  wrappedPkgs,
  inputs,
  config,
  ...
}: let
  inherit (config.values) mainUser;
in {
  imports = [inputs.hyprland.nixosModules.default];

  programs.hyprland.enable = true;

  programs.zsh.enable = true;
  users.users.${mainUser}.shell = config.home-manager.users.${mainUser}.programs.zsh.package;

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
    wrappedPkgs.xdragon

    wl-clipboard
    neovide
    spotify
    rmtrash
    trash-cli
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
