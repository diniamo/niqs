{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  wrappers.obsidian = {
    basePackage = pkgs.obsidian;
    flags = lib.mkIf osConfig.modules.values.nvidia ["--disable-gpu"];
  };
}
