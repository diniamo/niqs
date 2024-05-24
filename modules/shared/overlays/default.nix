{lib', ...}: {
  nixpkgs.overlays = [
    (final: prev: let
      inherit (lib') versionOverride;
      # inherit (final) fetchFromGitHub;
    in {
      vesktop = versionOverride prev.vesktop "1.5.3";
      # alacritty = flakePkgs.niqspkgs.alacritty-sixel;
    })
  ];
}
