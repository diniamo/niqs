{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix

    ./options

    ./qt.nix
    ./cursor.nix
    ./fonts.nix
    ./icons.nix
  ];

  config = {
    stylix = {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
      polarity = "dark";
      image = ./wallpapers/miles.png;
    };
  };
}
