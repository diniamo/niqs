{lib', ...}: let
  overlay = final: prev: let
    inherit (lib') overrideError;
    inherit (prev) fetchFromGitHub;
  in {
    wezterm = final.callPackage ./wezterm {};

    gamescope = overrideError prev.gamescope "3.14.4" (prev.gamescope.overrideAttrs (drv: {
      version = "44c16c20c332f441ffd903adbc5380ee85d693e5";
      src = fetchFromGitHub {
        owner = "ValveSoftware";
        repo = "gamescope";
        rev = "44c16c20c332f441ffd903adbc5380ee85d693e5";
        fetchSubmodules = true;
        hash = "sha256-NesmakUhbYUJ6StvtUMPv0d6Y1yJoql3spyOzgeoiUA=";
      };
      buildInputs = drv.buildInputs ++ [final.wlroots];
    }));
  };
in {
  nixpkgs.overlays = [overlay];
}
