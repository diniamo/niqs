{ pkgs, flakePkgs, lib, ... }: let
  inherit (lib) mkForce getExe;
in {
  environment = {
    defaultPackages = mkForce [];
    binsh = getExe pkgs.dash;

    systemPackages = with pkgs; [
      htop
      ripgrep
      fd
      cht-sh
      dfrs
      jaq
      wget
      nix-tree
      sd

      flakePkgs.niqspkgs.nq-patched
    ];
  };
}
