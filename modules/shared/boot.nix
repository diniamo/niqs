{ config, lib, inputs, ... }: let
  inherit (lib) mkEnableOption;

  cfg = config.custom.boot;
in {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options = {
    custom.boot.secure = mkEnableOption "secure boot";
  };

  config = {
    boot = {
      loader = {
        timeout = 0;
        systemd-boot = {
          enable = !cfg.secure;
          consoleMode = "auto";
          editor = false;
          configurationLimit = 9;
        };
      };

      lanzaboote = {
        enable = cfg.secure;
        # That --yes-this-might-brick-my-machine flag is scary
        # do it manually with the --microsoft flag (not only when dual booting windows)
        enrollKeys = false;
        pkiBundle = "/etc/secureboot";
      };
    };
  };
}
