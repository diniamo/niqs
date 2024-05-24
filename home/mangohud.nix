{osConfig, ...}: {
  programs.mangohud = {
    inherit (osConfig.modules.gaming) enable;
    settings = {
      cpu_temp = true;
      gpu_temp = true;
      vram = true;
      frame_timing = false;
    };
  };
}
