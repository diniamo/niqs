{ inputs, ... }: let
  username = "diniamo";
in {
  imports = with inputs.nix-home.nixosModules; [
    base
    alias
  ];

  home = {
    enable = true;
    user = username;
  };

  user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
