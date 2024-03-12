{pkgs}: let
  # This dynamic solution works, but I don't think it's the preferred way in nix
  # Lists the name of each file in the derivations folder
  # packageFileNames = builtins.attrNames (builtins.readDir ./derivations);
  # Maps said names to paths
  # packagePaths = map (fileName: ./derivations/${fileName}) packageFileNames;
  # packagePaths = [
  #   ./derivations/bencode-pretty.nix
  # ];
  # Calls said paths
  # called = map (path: pkgs.callPackage path {}) packagePaths;
  # Maps the called packages to a set where the key is the name of the package, and the value is the package itself
  # mapped = builtins.listToAttrs (map (c: {
  #     name = c.pname;
  #     value = c;
  #   })
  #   called);
  mkPackage = path: pkgs.callPackage path {};
  mkMpvPackage = path: pkgs.mpvScripts.callPackage path {};
in {
  bencode-pretty = mkPackage ./derivations/bencode-pretty.nix;

  mpvScripts = {
    SimpleUndo = mkMpvPackage ./derivations/mpvScripts/SimpleUndo.nix;
  };
}
