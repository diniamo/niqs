{flakePkgs, lib, ...}: let
  inherit (builtins) isList concatStringsSep;
  inherit (lib.generators) toKeyValue mkKeyValueDefault mkValueStringDefault;

  package = flakePkgs.niqspkgs.curd.override { withMpv = false; };

  settings = {
    AddMissingOptions = false;

    MpvArgs = ["--profile=anime"];
    MenuOrder = "CONTINUE_LAST,CURRENT,UPDATE,UNTRACKED,ALL";
    NextEpisodePrompt = true;
    SkipOp = false;
    SkipEd = false;
    SkipRecap = false;
    SaveMpvSpeed = false;
    DiscordPresence = false;
  };
in {
  home.packages = [package];
  xdg.configFile."curd/curd.conf".text = toKeyValue {
    mkKeyValue = mkKeyValueDefault {
      mkValueString = v: let
        default = mkValueStringDefault {};
      in
        if isList v then "[${concatStringsSep "," (map (e: "\"${default e}\"") v)}]"
        else default v;
    } "=";
  } settings;
}
