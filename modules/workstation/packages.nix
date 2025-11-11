{ pkgs, flakePkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_zen;

  user.packages = with pkgs; with flakePkgs.niqspkgs; [
    xdragon
    wl-clipboard
    spotify
    gtrash
    libqalculate
    wiremix
    eza
    libnotify
    gist
    footage
    flint
    dsync
    file
    git
    ffmpeg
    imagemagick
    fractal
  ];
}
