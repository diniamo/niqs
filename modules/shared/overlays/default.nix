{lib', ...}: let
  overlay = final: prev: let
    inherit (lib') overrideError;
    inherit (prev) fetchFromGitHub;
  in {
    gamescope = let
      inherit (prev) gamescope;
    in
      overrideError gamescope "3.14.2" (gamescope.overrideAttrs (_: oldAttrs: {
        src = fetchFromGitHub {
          owner = "ValveSoftware";
          repo = "gamescope";
          rev = "44c16c20c332f441ffd903adbc5380ee85d693e5";
          fetchSubmodules = true;
          hash = "sha256-NesmakUhbYUJ6StvtUMPv0d6Y1yJoql3spyOzgeoiUA=";
        };

        buildInputs = oldAttrs.buildInputs ++ [final.libdecor];
      }));

    wezterm = prev.callPackage ./wezterm {};
  };
in {
  nixpkgs.overlays = [overlay];
}
