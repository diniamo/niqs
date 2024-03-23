{
  lib,
  lib',
  ...
}: let
  inherit (lib) throwIf versionOlder;

  overlay = final: prev: {
    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (
          python-final: python-prev: {
            catppuccin = throwIf (versionOlder "0.7.1" prev.catppuccin-gtk.version) (lib'.overrideError "catppuccin-gtk") python-prev.catppuccin.overridePythonAttrs (oldAttrs: rec {
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
      throwIf (versionOlder "3.14.2" gamescope.version) (lib'.overrideError "gamescope") (gamescope.overrideAttrs (_: oldAttrs: {
        src = fetchFromGitHub {
          owner = "ValveSoftware";
          repo = "gamescope";
          rev = "f9386a769765958b35d996d4e25f9238b757e7d0";
          fetchSubmodules = true;
          hash = "sha256-5JIC5zZe6IiZOA82nNum7in/+7LpeRu9I7tnJTOwqWo=";
        };

        buildInputs = oldAttrs.buildInputs ++ [final.libdecor];
      }));
  };
in {
  nixpkgs.overlays = [overlay];
}
