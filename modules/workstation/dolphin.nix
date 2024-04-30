{pkgs, ...}: {
  environment.systemPackages = with pkgs.libsForQt5; [
    dolphin
    # dolphin-plugins
    kio-extras
    ark
  ];
  services.udisks2.enable = true;
}
