{
  pkgs,
  wrappedPkgs,
  config,
  ...
}: let
  inherit (config.values) mainUser;
in {
  programs.command-not-found.enable = false;
  programs.fish.enable = true;
  users.users.${mainUser}.shell = config.home-manager.users.${mainUser}.programs.fish.package;

  # For electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    wrappedPkgs.xdragon

    wl-clipboard
    neovide
    spotify
    trashy
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
