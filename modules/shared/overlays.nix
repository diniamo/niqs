{flakePkgs, ...}: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      starship = starship-nix3-shell;
      alacritty = alacritty-sixel;
      swayimg = swayimg-git;
      lix = lix-super;
      comma = comma-patched;
      nix-output-monitor = nom-traces-nf-icons;
      nh = nh-patched-nom;
      fish = fish-patched;
      satty = satty-git;
      coreutils-full = coreutils-full-advcpmv;
    };
in {
  nixpkgs.overlays = [niqspkgs];
}
