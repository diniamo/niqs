{pkgs, ...}: let
  mkElectronWrapper = pkg: {
    basePackage = pkg;
    flags = ["--disable-gpu-compositing"];
  };
in {
  wrappers = with pkgs; {
    obsidian-nvidia = mkElectronWrapper obsidian;
    webcord-nvidia = mkElectronWrapper webcord;
    vesktop-nvidia = mkElectronWrapper vesktop;
    spotify-nvidia = mkElectronWrapper spotify;
  };
}
