{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  environment.systemPackages = [pkgs.libsForQt5.ark];

  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
