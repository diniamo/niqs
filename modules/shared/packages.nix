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
      ripgrep
      fd
      cht-sh
      duf
      jaq
      wget
      nix-tree
      sd

      flakePkgs.niqspkgs.nq-patched
    ];
  };
}
