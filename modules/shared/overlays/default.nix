{
  lib',
  ...
}: let
  overlay = final: prev: let
    inherit (lib') overrideError;
    inherit (prev) fetchFromGitHub;
  in {
    # gamescope = overrideError prev.gamescope "3.14.2" ((prev.gamescope.override {wlroots = null;}).overrideAttrs (finalAttrs: previousAttrs: {
    #   version = "3.14.3";
    #   src = fetchFromGitHub {
    #     owner = "ValveSoftware";
    #     repo = "gamescope";
    #     rev = "refs/tags/${finalAttrs.version}";
    #     fetchSubmodules = true;
    #     hash = "sha256-+6RyrdHRDk9aeM52wcgLo966jP70EAiXSMR3sffNeZM=";
    #   };
    #
    #   nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [final.patchelfUnstable];
    #   buildInputs = previousAttrs.buildInputs ++ final.wlroots.buildInputs ++ [final.libdecor];
    #
    #   postInstall = lib.optionalString (previousAttrs.postInstall != "") (''
    #       patchelf $out/bin/gamescope --add-rpath ${final.vulkan-loader}/lib --add-needed libvulkan.so.1
    #     ''
    #     + previousAttrs.postInstall);
    # }));
    gamescope = overrideError prev.gamescope "3.14.2" (prev.gamescope.overrideAttrs (drv: {
      src = fetchFromGitHub {
        owner = "ValveSoftware";
        repo = "gamescope";
        rev = "44c16c20c332f441ffd903adbc5380ee85d693e5";
        fetchSubmodules = true;
        hash = "sha256-NesmakUhbYUJ6StvtUMPv0d6Y1yJoql3spyOzgeoiUA=";
      };

      buildInputs = drv.buildInputs ++ [final.libdecor];
    }));

    wezterm = final.callPackage ./wezterm {};
  };
in {
  nixpkgs.overlays = [overlay];
}
