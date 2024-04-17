{lib', ...}: let
  overlay = final: prev: let
    inherit (lib') overrideError;
    inherit (prev) fetchFromGitHub;
  in {
    wezterm = final.callPackage ./wezterm {};
  };
in {
  nixpkgs.overlays = [overlay];
}
