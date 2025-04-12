{
  pkgs,
  flakePkgs,
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
      nix-tree

      (flakePkgs.rebuild.default.override {
        nix-output-monitor = nix-output-monitor;
      })
    ];
  };
}
