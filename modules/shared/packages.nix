{
  pkgs,
  lib,
  ...
}: {
  environment = {
    defaultPackages = lib.mkForce [];
    binsh = lib.getExe pkgs.dash;

    systemPackages = with pkgs; [
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
  };
}
