{
  pkgs,
  lib',
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
    (
      lib'.wrapProgram pkgs xdragon {
        makeWrapperArgs = ["--add-flags" "--all --and-exit"];
      }
    )

    wl-clipboard
    neovide
    spotify
    gtrash
    ungoogled-chromium
    yt-dlp
    libreoffice-qt
    libqalculate
    qalculate-qt
    pulsemixer
    pavucontrol
    eza
    libnotify
    gist
    obsidian
    vesktop
  ];
}
