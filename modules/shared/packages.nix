{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    htop
    man-pages
    man-pages-posix
    ripgrep
    fd
    cht-sh
    duf
    jq
    wget
    nh
    nix-tree
  ];
}
