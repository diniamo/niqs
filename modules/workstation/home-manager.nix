{
  inputs,
  system,
  lib',
  flakePkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "old";
    extraSpecialArgs = {
      inherit inputs system flakePkgs lib';
    };
    users = {
      diniamo = ../../home-manager;
    };
  };
}
