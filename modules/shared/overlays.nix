{lib', ...}: let
  inherit (lib') overrideError;

  overlay = final: prev: {
    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (
          _python-final: python-prev: {
            catppuccin = overrideError prev.catppuccin-gtk "0.7.1" python-prev.catppuccin.overridePythonAttrs (_oldAttrs: rec {
              version = "1.3.2";
              src = prev.fetchFromGitHub {
                owner = "catppuccin";
                repo = "python";
                rev = "refs/tags/v${version}";
                hash = "sha256-spPZdQ+x3isyeBXZ/J2QE6zNhyHRfyRQGiHreuXzzik=";
              };

              # can be removed next version
              disabledTestPaths = [
                "tests/test_flavour.py" # would download a json to check correctness of flavours
              ];
            });
          }
        )
      ];

    gamescope = let
      inherit (prev) fetchFromGitHub gamescope;
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
  };
in {
  nixpkgs.overlays = [overlay];
}
