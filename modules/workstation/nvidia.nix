{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.modules.nvidia;
in {
  options = {
    modules.nvidia = {
      enable = mkEnableOption "Enable the Nvidia module";
    };
  };

  config = mkIf cfg.enable {
    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      # WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_VRR_ALLOWED = "1";
      __GL_GSYNC_ALLOWED = "1";
    };

    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
      nvidia = {
        # package = config.boot.kernelPackages.nvidiaPackages.production;
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        open = false;
        modesetting.enable = true;
        powerManagement.enable = true;
      };
    };

    # This is required for Wayland too
    services.xserver.videoDrivers = ["nvidia"];
  };
}
