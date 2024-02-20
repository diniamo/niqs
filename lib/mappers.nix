let
  inputsToPackages = inputs: system: builtins.mapAttrs (name: value: value.packages.${system}.${name} or null) inputs;
in {
  inherit inputsToPackages;
}
