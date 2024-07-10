{pkgs, ...}: {
  imports = [
    ./theme.nix
    ./binds.nix
    ./functions.nix
    ./aliases.nix
    ./abbreviations.nix
    ./hooks.nix
  ];

  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        inherit (tide) src;
      }
      {
        name = "autopair";
        inherit (autopair) src;
      }
    ];
  };
}
