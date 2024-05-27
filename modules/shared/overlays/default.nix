{flakePkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      starship = flakePkgs.niqspkgs.starship-nix3-shell;
    })
  ];
}
