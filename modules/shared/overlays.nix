{ flakePkgs, ... }: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      nix = nix-patched;
      comma = comma-patched;
      nix-output-monitor = nom-patched;
      file-roller = file-roller-gtk3;
      sway-unwrapped = sway-unwrapped-git;
      bat = bat-patched;
      zoxide = zoxide-patched;
      imv = imv-diniamo;
    };
in {
  nixpkgs.overlays = [ niqspkgs ];
}
