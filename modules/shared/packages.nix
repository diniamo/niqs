{ pkgs, flakePkgs, lib, ... }: let
  inherit (lib) mkForce getExe;
in {
  environment = {
    defaultPackages = mkForce [];
    binsh = getExe pkgs.dash;

    systemPackages = with pkgs; [
      ripgrep
      fd
      cht-sh
      jq
      wget
      nix-tree
      duf

      flakePkgs.niqspkgs.nq-patched
    ];
  };

  nixpkgs.overlays = [(final: _: let
    inherit (final) emptyDirectory;
  in {
    nixos-rebuild-ng = emptyDirectory // {
      override = _: emptyDirectory;
      overrideAttrs = _: emptyDirectory;
    };
  })];
}
