{pkgs, ...}: let
  inherit (builtins) path;
in {
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
      (path {
        name = "${tide.pname}-patched-${tide.version}";
        path = pkgs.applyPatches {
          inherit (tide) src;
          patches = [
            ./patches/tide-no-newline-bind.patch
            ./patches/tide-nix3-shell.patch
          ];
        };
      })

      (path {
        inherit (autopair) name;
        path = autopair.src;
      })

      (path {
        inherit (sponge) name;
        path = sponge.src;
      })
    ];
  };
}
