{flakePkgs, ...}: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      swayimg = swayimg-git;
      nix = lix-patched;
      comma = comma-patched;
      nix-output-monitor = nom-patched;
      fish = fish-patched;
      file-roller = file-roller-gtk3;
      sway-unwrapped = sway-unwrapped-patched;
    };
in {
  nixpkgs.overlays = [niqspkgs];
}
