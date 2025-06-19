{ flakePkgs, ... }: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      swayimg = swayimg-git;
      nix = dnix;
      comma = comma-patched;
      nix-output-monitor = nom-patched;
      file-roller = file-roller-gtk3;
      sway-unwrapped = sway-unwrapped-git;
    };
in {
  nixpkgs.overlays = [ niqspkgs ];
}
