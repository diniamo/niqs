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
        efi.canTouchEfiVariables = true;
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
        pkiBundle = "/var/lib/sbctl";
      };
    };
  };
}
