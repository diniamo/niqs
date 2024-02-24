{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    htop
    man-pages
    man-pages-posix
  ];
}
