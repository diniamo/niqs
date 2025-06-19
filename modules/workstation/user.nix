{ inputs, ... }: let
  username = "diniamo";
in {
  imports = with inputs.nix-home.nixosModules; [
    base
    alias
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  
  home = {
    enable = true;
    user = username;
  };
}
