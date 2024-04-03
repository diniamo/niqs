{lib}: let
  inherit (lib) throwIf versionOlder;
  inherit (lib.strings) toLower;

  nameToSlug = name: toLower (builtins.replaceStrings [" "] ["-"] name);
  boolToNum = bool:
    if bool
    then 1
    else 0;
  overrideError = pkg: version: value: throwIf (versionOlder version pkg.version) "A new version of ${pkg.pname} has been released, remove its overlay/override" value;
in {
  inherit nameToSlug boolToNum overrideError;
}
