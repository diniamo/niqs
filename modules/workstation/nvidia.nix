{
  config,
  lib,
  pkgs,
  lib',
  ...
}: let
  cfg = config.custom.nvidia;
in {
  options = {
    custom.nvidia.enable = lib.mkEnableOption "Enable the Nvidia module";
  };

  config = lib.mkIf cfg.enable {
    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      # 16 series cards do not support the open driver
      open = false;

      modesetting.enable = true;
      powerManagement.enable = true;

      nvidiaSettings = false;
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
    environment.sessionVariables = {
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

    nixpkgs.config.cudaSupport = true;
    nixpkgs.overlays = [(
      final: prev: let
        wrapChromium = lib'.wrapProgram {
          inherit (final) symlinkJoin;
          wrapper = final.makeBinaryWrapper;
          wrapperArgs = ["--add-flags" "--disable-gpu-compositing"];
        };
      in {
        obsidian = wrapChromium prev.obsidian;
        spotify = wrapChromium prev.spotify;
        discord-canary = wrapChromium (prev.discord-canary.override { withOpenASAR = true; });
      }
    )];
  };
}
