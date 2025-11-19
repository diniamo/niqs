{ pkgs, flakePkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_zen;

  user.packages = (with pkgs; [
    dragon-drop
    wl-clipboard
    spotify
    gtrash
    libqalculate
    wiremix
    eza
    libnotify
    gist
    footage
    file
    git
    ffmpeg
    imagemagick
    fractal
  ]) ++ (with flakePkgs.niqspkgs; [
    flint
    dsync
    helium
  ]);
}
