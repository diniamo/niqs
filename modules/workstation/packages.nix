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
    (lib'.wrapProgram {
      inherit pkgs;
      package = "xdragon";
      executable = "dragon";
      wrapperArgs = ["--add-flags" "--all --and-exit"];
    })

    (lib'.wrapProgram {
      inherit pkgs;
      package = "chatterino2";
      wrapperArgs = ["--prefix" "PATH" ":" "${streamlink}/bin"];
    })

    wl-clipboard
    neovide
    spotify
    gtrash
    yt-dlp
    libqalculate
    qalculate-qt
    pulsemixer
    pavucontrol
    eza
    libnotify
    gist
    obsidian
    discord-canary
  ];
}
