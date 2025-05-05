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
    wrapProgram = args: lib'.wrapProgram ({
      inherit symlinkJoin;
      wrapper = makeBinaryWrapper;
    } // args);
  in [
    (wrapProgram {
      package = xdragon;
      wrapperArgs = ["--add-flags" "--all --and-exit"];
    })

    (wrapProgram {
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
