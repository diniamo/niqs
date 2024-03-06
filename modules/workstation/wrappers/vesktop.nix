{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  wrappers.vesktop = {
    basePackage = pkgs.vesktop;
    flags = lib.mkIf osConfig.modules.values.nvidia ["--disable-gpu"];
  };
}
