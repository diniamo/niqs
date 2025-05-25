{
  pkgs,
  lib',
  config,
  ...
}: let
  inherit (config.values) mainUser;

  fish = config.home-manager.users.${mainUser}.programs.fish.package;
in {
  boot.kernelPackages = pkgs.linuxPackages_zen;

  programs = {
    command-not-found.enable = false;
    fish = {
      enable = true;
      package = fish;
    };
  };
  
  users.users.${mainUser}.shell = fish;

  # For electron apps
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; let
      wrapProgram = args: lib'.wrapProgram ({
        inherit symlinkJoin;
        wrapper = makeBinaryWrapper;
      } // args);
    in [
      (wrapProgram {
        package = xdragon;
        wrapperArgs = ["--add-flags" "--all --and-exit"];
      })

      wl-clipboard
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
  };
}
