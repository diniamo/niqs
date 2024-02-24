{
  inputs,
  system,
  lib,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "old";
    extraSpecialArgs = {
      inherit inputs system;
      lib' = lib;
    };
    users = {
      diniamo = ../../home-manager;
    };
  };
}
