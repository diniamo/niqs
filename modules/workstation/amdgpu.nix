{ lib, config, pkgs, ... }: let
  inherit (lib) mkEnableOption mkIf;
in {
  options = {
    custom.amdgpu.enable = mkEnableOption "amdgpu";
  };

  config = mkIf config.custom.amdgpu.enable {
    nixpkgs.config.rocmSupport = true;

    environment = {
      systemPackages = with pkgs; [
        lact
        amdgpu_top
      ];

      sessionVariables.LIBVA_DRIVER_NAME = "radeonsi";
    };
  };
}
