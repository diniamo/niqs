{
  inputs,
  system,
  lib',
  flakePkgs,
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
      inherit inputs system flakePkgs wrappedPkgs lib';
    };
    users = {
      diniamo = ../../home-manager;
    };
  };
}
