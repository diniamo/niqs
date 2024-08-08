{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.modules.boot;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  options = {
    modules.boot = {
      secure = lib.mkEnableOption "secure boot";
      windowsEntry = lib.mkEnableOption "a windows entry in the boot menu";
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
        };
      };

      lanzaboote = {
        enable = cfg.secure;
        # That --yes-this-might-brick-my-machine flag is scary
        # do it manually with the --microsoft flag (not only when dual booting windows)
        enrollKeys = false;
        pkiBundle = "/etc/secureboot";
      };

      tmp.useTmpfs = lib.mkDefault true;
      kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      kernelParams = ["quiet"];
    };
  };
}
