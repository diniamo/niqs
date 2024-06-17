{
  inputs,
  pkgs,
  config,
  ...
}: {
  # Avoid using the module system
  nixpkgs.overlays = [inputs.chaotic.overlays.default];
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  users.users.${config.values.mainUser} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  fonts.fontconfig.subpixel.rgba = "rgb";
}
