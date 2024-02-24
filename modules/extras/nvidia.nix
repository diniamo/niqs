{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_VRR_ALLOWED = "1";
    __GL_GSYNC_ALLOWED = "1";
  };

  # environment.systemPackages = with pkgs; [
  #   vulkan-loader
  #   vulkan-validation-layers
  #   vulkan-tools
  # ];

  hardware = {
    opengl = {
      # extraPackages = with pkgs; [ nvidia-vaapi-driver ];

      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  # boot.kernelParams = ["nvidia_drm.modeset=1"];
  # boot.extraModprobeConfig = "options nvidia-drm modeset=1";

  # This is required for Wayland too
  services.xserver.videoDrivers = ["nvidia"];

  modules.values.nvidia = true;
}
