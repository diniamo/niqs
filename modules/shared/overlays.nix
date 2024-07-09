{flakePkgs, ...}: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      starship = starship-nix3-shell;
      alacritty = alacritty-sixel;
      swayimg = swayimg-git;
      lix = lix-super;
      comma = comma-sensible-print;
      nix-output-monitor = nom-traces-nf-icons;
      nh = nh-patched-nom;
    };
in {
  nixpkgs.overlays = [niqspkgs];
}
