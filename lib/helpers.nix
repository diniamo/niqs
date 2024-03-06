{
  inputs,
  lib,
}: let
  nameToSlug = name: lib.strings.toLower (builtins.replaceStrings [" "] ["-"] name);
  boolToNum = bool:
    if bool
    then 1
    else 0;
  wrapPackages = pkgs: wrappers:
    inputs.wrapper-manager.lib.build {
      inherit pkgs;
      modules = [{inherit wrappers;}];
    };
in {
  inherit nameToSlug boolToNum wrapPackages;
}
