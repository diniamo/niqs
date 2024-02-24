let
  inputsToPackages = inputs: system: builtins.mapAttrs (name: value: value.packages.${system} or null) inputs;
in {
  inherit inputsToPackages;
}
