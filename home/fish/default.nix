{pkgs, ...}: {
  imports = [
    ./theme.nix
    ./binds.nix
    ./functions.nix
    ./aliases.nix
    ./abbreviations.nix
  ];

  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      {
        name = "tide";
        src = pkgs.applyPatches {
          inherit (tide) src;
          patches = [
            ./tide-no-newline-bind.patch
            ./tide-nix3-shell.patch
          ];
        };
      }
      {
        name = "autopair";
        inherit (autopair) src;
      }
    ];
  };
}
