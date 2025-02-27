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

  environment.systemPackages = with pkgs; let
    inherit (lib') wrapProgram;
    wrapper = makeBinaryWrapper;
  in [
    (wrapProgram {
      inherit symlinkJoin wrapper;
      package = xdragon;
      executable = "dragon";
      wrapperArgs = ["--add-flags" "--all --and-exit"];
    })

    (wrapProgram {
      inherit symlinkJoin wrapper;
      package = chatterino2;
      wrapperArgs = ["--prefix" "PATH" ":" "${streamlink}/bin"];
    })

    wl-clipboard
    neovide
    spotify
    gtrash
    libqalculate
    pulsemixer
    pavucontrol
    eza
    libnotify
    gist
    obsidian
    video-trimmer
  ];
}
