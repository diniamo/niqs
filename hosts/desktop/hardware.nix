# Don't change this
{ config, lib, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [];
    blacklistedKernelModules = [ "i2c_nvidia_gpu" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/57e169d1-9acc-42c3-b4ea-fd4080bc6a25";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/CE24-5E95";
      fsType = "vfat";
    };
    "/hdd" = {
      device = "/dev/disk/by-label/hdd";
      fsType = "ext4";
    };
    "/torrent" = {
      device = "/dev/disk/by-label/torrent";
      fsType = "ntfs-3g";
    };
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
