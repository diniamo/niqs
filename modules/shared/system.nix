{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "hu";
  networking.nameservers = ["1.1.1.1" "1.0.0.1"];
  boot = {
    tmp.useTmpfs = mkDefault true;
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    kernelParams = ["quiet"];
  };
}
