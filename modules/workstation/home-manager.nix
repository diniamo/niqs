{
  inputs,
  system,
  lib',
  config,
  flakePkgs,
  customPkgs,
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
      extraSpecialArgs = {inherit inputs system flakePkgs customPkgs lib';};
      users.${username} = ../../home;
    };
  };
}
