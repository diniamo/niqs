{ lib, lib', ... }: let
  inherit (lib) mapAttrsToList concatMapAttrsStringSep;
  inherit (lib') attrsToLines toYesNoKV;
  inherit (builtins) isBool isList isString concatStringsSep concatLists;

  yesNoValue = value:
    if isBool value then
      if value then "yes" else "no"
    else toString value;
  
  concatColon = concatStringsSep ",";
in {
  attrsToLines = concatMapAttrsStringSep "\n";
  
  toYesNoKV = attrsToLines (name: value: if value == null then "" else "${name}=${yesNoValue value}");
  toYesNoINI = attrsToLines (profile: config: "[${profile}]\n${toYesNoKV config}");
  toSpaceKV = attrsToLines (name: command: "${name} ${command}");
  toFlagKV = attrsToLines (flag: value:
    if isBool value then
      if value then flag else ""
    else "${flag}=${toString value}"
  );

  toMpvScriptOpts = scriptOpts: let
    opts = concatLists (mapAttrsToList (namespace: opts:
      mapAttrsToList (name: value: "${namespace}-${name}=${yesNoValue value}") opts
    ) scriptOpts);
  in concatColon opts;
  
  toFzfColorFlagValue = colors: concatColon (mapAttrsToList (name: value: "${name}:${value}") colors);

  toMangohudConf = attrsToLines (name: value:
    if isBool value then
      if value then name else "${name}=0"
    else if isList value then
      "${name}=${concatColon (map toString value)}"
    else "${name}=${value}"
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
