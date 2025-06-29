{ flakePkgs, ... }: let
  niqspkgs = _: _:
    with flakePkgs.niqspkgs; {
      swayimg = swayimg-git;
      nix = nix-patched;
      comma = comma-patched;
      nix-output-monitor = nom-patched;
      file-roller = file-roller-gtk3;
      sway-unwrapped = sway-unwrapped-git;
      bat = bat-patched;
      zoxide = zoxide-patched;
    };
in {
  nixpkgs.overlays = [ niqspkgs ];
}
