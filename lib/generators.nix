{ lib, lib', ... }: let
  inherit (lib) mapAttrsToList concatMapAttrsStringSep;
  inherit (lib.types) attrsOf oneOf str bool int path float;
  inherit (lib') attrsToLines iniAtom iniSection toKV toINI;
  inherit (builtins) isBool isString concatStringsSep concatLists;

  yesNoBool = bool: if bool then "yes" else "no";

  concatColon = concatStringsSep ",";
in {
  attrsToLines = concatMapAttrsStringSep "\n";
  iniAtom = oneOf [ str path bool int float ];
  iniSection = attrsOf iniAtom;
  iniType = attrsOf iniSection;

  toKV = boolValue: attrsToLines (name: value: if value == null then "" else "${name}=${if isBool value then boolValue value else toString value}");
  toYesNoKV = toKV yesNoBool;
  toSpaceKV = attrsToLines (name: command: "${name} ${command}");
  toFlagKV = attrsToLines (flag: value:
    if isBool value then
      if value then flag else ""
    else "${flag}=${toString value}"
  );

  toINI = boolValue: attrsToLines (section: values: "[${section}]\n${toKV boolValue values}");
  toYesNoINI = toINI yesNoBool;

  toMpvScriptOpts = scriptOpts: let
    opts = concatLists (mapAttrsToList (namespace: opts:
      mapAttrsToList (name: value: "${namespace}-${name}=${if isBool value then yesNoBool value else toString value}") opts
    ) scriptOpts);
  in concatColon opts;

  toFzfColorFlagValue = colors: concatColon (mapAttrsToList (name: value: "${name}:${value}") colors);

  toMangohudConf = attrsToLines (name: value:
    if isBool value then
      if value then name else "${name}=0"
    else "${name}=${toString value}"
  );

  toBtopConf = let
    btopValue = value:
      if isBool value then
        if value then "True" else "False"
      else if isString value then
        "\"${value}\""
      else toString value;
  in attrsToLines (name: value: "${name}=${btopValue value}");
}
