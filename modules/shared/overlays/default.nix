{lib', ...}: {
  nixpkgs.overlays = [
    (final: prev: let
      inherit (lib') overrideError versionOverride;
      inherit (prev) fetchFromGitHub;
    in {
      wezterm = final.callPackage ./wezterm {};

      vesktop = versionOverride prev.vesktop "1.5.3";
    })
  ];
}
