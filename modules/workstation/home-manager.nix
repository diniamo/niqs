{
  inputs,
  system,
  lib',
  config,
  flakePkgs,
  customPkgs,
  wrappedPkgs,
  ...
}: let
  username = config.values.mainUser;
in {
  imports = [inputs.home-manager.nixosModules.home-manager];

  config = {
    home-manager = {
      verbose = true;
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "old";
      extraSpecialArgs = {inherit inputs system flakePkgs customPkgs wrappedPkgs lib';};
      users.${username} = ../../home;
    };
  };
}
