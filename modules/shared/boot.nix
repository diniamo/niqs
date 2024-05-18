{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkDefault;

  cfg = config.modules.boot;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  options = {
    modules.boot = {
      secure = mkEnableOption "secure boot";
      windowsEntry = mkEnableOption "a windows entry in the boot menu";
    };
  };

  config = {
    boot = {
      loader = {
        timeout = 0;
        systemd-boot = {
          enable = !cfg.secure;
          consoleMode = "auto";
          editor = false;
          configurationLimit = 4;
          # extraInstallCommands = mkIf cfg.windowsEntry "printf 'auto-entries false' >> /boot/loader/loader.conf";
          # extraEntries = mkIf cfg.windowsEntry {
          #   "windows.conf" = ''
          #     title Windows
          #     efi /EFI/Microsoft/Boot/bootmgfw.efi
          #   '';
          # };
        };
      };

      lanzaboote = {
        enable = cfg.secure;
        # That --yes-this-might-brick-my-machine flag is scary
        # do it manually with the --microsoft flag (not only when dual booting windows)
        enrollKeys = false;
        pkiBundle = "/etc/secureboot";
      };

      tmp.useTmpfs = mkDefault true;
      kernelPackages = mkDefault pkgs.linuxPackages_latest;
      kernelParams = ["quiet" "splash"];
    };
  };
}
