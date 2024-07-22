{
  config,
  lib,
  wrappedPkgs,
  pkgs,
  ...
}: let
  cfg = config.modules.nvidia;
in {
  options = {
    modules.nvidia = {
      enable = lib.mkEnableOption "Enable the Nvidia module";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;

      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
    };

    # This is required for Wayland too
    services.xserver.videoDrivers = ["nvidia"];

    # Optimizations taken from https://github.com/ventureoo/nvidia-tweaks
    services.udev.extraRules = ''
      ACTION=="bind", SUBSYSTEM=="pci", DRIVERS=="nvidia", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", TEST=="power/control", ATTR{power/control}="auto"
      ACTION=="unbind", SUBSYSTEM=="pci", DRIVERS=="nvidia", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", TEST=="power/control", ATTR{power/control}="on"
    '';
    boot.kernelParams = [
      "nvidia.NVreg_UsePageAttributeTable=1"
      "nvidia.NVreg_InitializeSystemMemoryAllocations=0"
      "nvidia.NVreg_EnableStreamMemOPs=1"
      "nvidia.NVreg_RegistryDwords=__REGISTRYDWORDS"
    ];
    environment.variables = {
      __GL_YIELD = "USLEEP";
      __GL_MaxFramesAllowed = "1";

      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __GL_VRR_ALLOWED = "1";
      __GL_GSYNC_ALLOWED = "1";
    };

    environment.systemPackages = [pkgs.nvtopPackages.nvidia];

    nixpkgs.overlays = [
      (
        _: _:
          with wrappedPkgs; {
            obsidian = obsidian-nvidia;
            vesktop = vesktop-nvidia;
            webcord = webcord-nvidia;
            spotify = spotify-nvidia;
          }
      )
    ];
  };
}
