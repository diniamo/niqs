{pkgs, ...}: {
  imports = [
    ./init.nix
    ./binds.nix
    ./functions.nix
    ./aliases.nix
    ./abbreviations.nix
  ];

  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      (pkgs.applyPatches {
        inherit (tide) src;
        patches = [
          ./patches/tide-no-newline-bind.patch
          ./patches/tide-nix3-shell.patch
        ];
      })

      autopair.src
      sponge.src
    ];
  };
}
