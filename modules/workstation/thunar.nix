{ pkgs, lib, config, ... }: let
  inherit (lib) getExe;
in {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  environment.systemPackages = [ pkgs.file-roller ];

  home.files.".config/xfce4/helpers.rc" = {
    name = "xfce4-helpers.rc";
    text = ''
      TerminalEmulator=${getExe config.custom.foot.finalPackage}
    '';
  };
}
