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
      jq
      wget
      nix-tree
      sd
      duf

      flakePkgs.niqspkgs.nq-patched
    ];
  };

  nixpkgs.overlays = [(final: prev: let
    inherit (final) emptyDirectory;
  in {
    nixos-rebuild-ng = emptyDirectory // {
      override = _: emptyDirectory;
      overrideAttrs = _: emptyDirectory;
    };
  })];
}
