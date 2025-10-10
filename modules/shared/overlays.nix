{ flakePkgs, ... }: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      nix = nix-patched;
      comma = comma-patched;
      nix-output-monitor = nom-patched;
      file-roller = file-roller-gtk3;
      sway-unwrapped = sway-unwrapped-git;
      zoxide = zoxide-patched;
      imv = imv-diniamo;
      direnv = direnv-patched;
      mako = mako-patched;
    };
in {
  nixpkgs.overlays = [ niqspkgs ];
}
