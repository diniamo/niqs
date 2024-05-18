{pkgs, ...}: let
  mkElectronWrapper = pkg: {
    basePackage = pkg;
    flags = ["--disable-gpu"];
  };
in {
  wrappers = {
    obsidian-nvidia = mkElectronWrapper pkgs.obsidian;
    webcord-nvidia = mkElectronWrapper pkgs.webcord;
    vesktop-nvidia = mkElectronWrapper pkgs.vesktop;
  };
}
