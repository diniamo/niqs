{pkgs}: let
  # Lists the name of each file in the derivations folder
  # packageFileNames = builtins.attrNames (builtins.readDir ./derivations);
  # Maps said names to paths
  # packagePaths = map (fileName: ./derivations/${fileName}) packageFileNames;
  packagePaths = [
    ./derivations/bencode-pretty.nix
  ];
  # Calls said paths
  called = map (path: (builtins.trace pkgs pkgs).callPackage path) packagePaths;
in
  # Maps the called packages to a set where the key is the name of the package, and the value is the package itself
  builtins.listToAttrs (map (c: {
      name = c.pname;
      value = c;
    })
    called)
