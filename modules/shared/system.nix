{ lib, pkgs, ... }: let
  inherit (lib) mkDefault;
in {
  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "hu";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  # Disables cursor blinking in the TTY
  systemd.tmpfiles.rules = [ "w /sys/class/graphics/fbcon/cursor_blink - - - - 0" ];
  boot = {
    tmp.useTmpfs = mkDefault true;
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" ];
  };
}
