{
  inputs,
  system,
  lib',
  flakePkgs,
  customPkgs,
  wrappedPkgs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "old";
    extraSpecialArgs = {
      inherit inputs system flakePkgs customPkgs wrappedPkgs lib';
    };
    users = {
      diniamo = ../../home-manager;
    };
  };
}
