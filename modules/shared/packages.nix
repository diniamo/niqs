{ pkgs, flakePkgs, lib, lib', ... }: let
  inherit (lib) mkForce getExe;
  inherit (lib') wrapProgram;
in {
  environment = {
    defaultPackages = mkForce [];
    binsh = getExe pkgs.dash;

    systemPackages = with pkgs; [
      (wrapProgram pkgs { package = dfrs; args = [ "--add-flags" "--columns mounted_on,available" ]; })
      
      htop
      ripgrep
      fd
      cht-sh
      jq
      wget
      nix-tree
      sd

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
