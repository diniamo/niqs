{lib}: let
  nameToSlug = name: lib.strings.toLower (builtins.replaceStrings [" "] ["-"] name);
  boolToNum = bool:
    if bool
    then 1
    else 0;
in {
  inherit nameToSlug boolToNum;
}
