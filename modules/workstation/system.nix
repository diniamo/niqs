{
  inputs,
  pkgs,
  ...
}: {
  # Avoid using the module system
  # Fix kernel module compilation
  nixpkgs.overlays = [
    inputs.chaotic.overlays.default
    # (final: prev: {
    #   linuxPackages_cachyos-lto-fixed = final.linuxPackages_cachyos-lto.override (linuxPackagesArgs: {
    #     linuxPackagesFor = kernel:
    #       linuxPackagesArgs.linuxPackagesFor (
    #         kernel.overrideAttrs (kernelAttrs: {
    #           makeFlags =
    #             kernelAttrs.makeFlags
    #             ++ [
    #               "KBUILD_LDFLAGS+=--thinlto-cache-dir=/var/cache/clang-thinlto"
    #             ];
    #         })
    #       );
    #   });
    # })
  ];
  # nix.settings.extra-sandbox-paths = [ "/var/cache/clang-thinlto" ];
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
