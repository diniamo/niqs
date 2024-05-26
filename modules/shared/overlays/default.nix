{flakePkgs,...}:{
  nixpkgs.overlays = [
    (final: prev: let
      # inherit (lib') overrideError;
      # inherit (final) fetchFromGitHub;
    in {
      starship = flakePkgs.niqspkgs.starship-nix3-shell;
    })
  ];
}
