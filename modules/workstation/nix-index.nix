{ inputs, ... }: {
  imports = [ inputs.nix-index-database.nixosModules.nix-index ];

  programs = {
    command-not-found.enable = false;

    nix-index = {
      enable = true;

      enableZshIntegration = false;
      enableFishIntegration = false;
      enableBashIntegration = false;
    };

    nix-index-database.comma.enable = true;
  };
}
