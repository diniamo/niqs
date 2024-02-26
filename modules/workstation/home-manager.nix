{
  inputs,
  system,
  lib,
  packages,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "old";
    extraSpecialArgs = {
      inherit inputs system packages;
      lib' = lib;
    };
    users = {
      diniamo = ../../home-manager;
    };
  };
}
