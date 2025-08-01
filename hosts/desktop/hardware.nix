# Don't change this
{ config, lib, modulesPath, ... }: let
  inherit (lib) mkDefault;
in {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    kernelModules = [ "kvm-intel" ];
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/5595-6E85";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
    "/" = {
      device = "/dev/disk/by-uuid/5a6043ab-f673-4390-98b9-0aadabf1b1b5";
      fsType = "ext4";
    };
    "/home/diniamo/mount/hdd" = {
      device = "/dev/disk/by-uuid/afe93474-13ab-4cef-9fe4-7158f735f0fa";
      fsType = "ext4";
    };
  };

  networking.useDHCP = mkDefault true;
  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
}
