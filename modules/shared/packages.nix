{pkgs, lib, ...}: {
  environment.defaultPackages = lib.mkForce [];
  environment.systemPackages = with pkgs; [
    htop
    man-pages
    man-pages-posix
    ripgrep
    fd
    cht-sh
    duf
    jaq
    wget
    nh
    nix-tree
    nix-inspect
  ];
}
