{flakePkgs, ...}: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      swayimg = swayimg-git;
      lix = lix-patched;
      comma = comma-patched;
      nix-output-monitor = nom-patched;
      nh = nh-patched;
      fish = fish-patched;
      coreutils-full = coreutils-full-patched;
      jellyfin = jellyfin-intro-skipper;
      file-roller = file-roller-gtk3;
      direnv = direnv-patched;
    };
in {
  nixpkgs.overlays = [niqspkgs];
}
