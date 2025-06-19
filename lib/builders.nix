{lib, lib', inputs, ...}: let
  inherit (lib) nixosSystem escapeShellArgs;
  inherit (builtins) mapAttrs;
in {
  nixosSystem' = { system, ... }@args: nixosSystem {
    system = null;

    # Infinite recursion if I don't put this here
    specialArgs = {inherit inputs;};

    modules = [{
      _module.args = {
        inherit system lib';
        flakePkgs = mapAttrs (_: input: (input.legacyPackages or input.packages).${system}) inputs;
      };

      nixpkgs = {
        inherit system;
        config.allowUnfree = true;
      };
    }] ++ args.modules or [];
  };

  wrapProgram = {
    wrapper,
    wrapperArgs,
    symlinkJoin,
    ...
  }@args: package: let
    file = args.executable or package.meta.mainProgram;
  in symlinkJoin {
    pname = "${package.pname}-wrapped";
    inherit (package) version;

    paths = [package];
    nativeBuildInputs = [wrapper];
    postBuild = "wrapProgram $out/bin/${file} ${escapeShellArgs wrapperArgs}";

    inherit (package.meta) mainProgram;
  };
}
