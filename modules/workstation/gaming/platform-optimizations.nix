# Credit: https://github.com/fufexan/nix-gaming/blob/master/modules/platformOptimizations.nix
# MIT license
{
  config,
  lib,
  ...
}: lib.mkIf config.custom.gaming.enable {
  # last checked with https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/steamos-customizations-jupiter-20250117.1-1-any.pkg.tar.zst
  boot.kernel.sysctl = {
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "net.ipv4.tcp_fin_timeout" = 5;
    "kernel.split_lock_mitigate" = 0;
    "vm.max_map_count" = 2147483642;
  };
}
