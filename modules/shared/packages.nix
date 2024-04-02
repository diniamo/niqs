{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # This is used by scripts throughout my configuration, while it's installed by default on most systems, it should still be specified somewhere
    coreutils-full

    htop
    man-pages
    man-pages-posix
    ripgrep
    fd
    tldr
    duf
    jq
    wget
    comma
    nh
    nix-tree
  ];
}
