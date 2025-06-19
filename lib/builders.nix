{ lib, lib', inputs, ... }: let
  inherit (lib) nixosSystem escapeShellArgs;
  inherit (builtins) mapAttrs;
in {
  nixosSystem' = { system, ... }@args: nixosSystem {
    system = null;

    # Infinite recursion if I don't put this here
    specialArgs = { inherit inputs; };

    modules = [{
      _module.args = {
        inherit system lib';
        flakePkgs = mapAttrs (_: input: input.legacyPackages.${system} or {} // input.packages.${system} or {}) inputs;
      };

      nixpkgs = {
        inherit system;
        config.allowUnfree = true;
      };
    }] ++ args.modules or [];
  };

  wrapProgram = pkgs: {
    package,
    executable ? package.meta.mainProgram,
    args
  }: pkgs.symlinkJoin {
    pname = "${package.pname}-wrapped";
    inherit (package) version meta;

    paths = [ package ];
    
    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    postBuild = "wrapProgram $out/bin/${executable} ${escapeShellArgs args}";
  };
}
