{
  programs.mpv.profiles = {
    svp = {
      input-ipc-server = "/tmp/mpvsocket";
      hr-seek-framedrop = false;
    };
    anime = {
      profile = "gpu-hq";
      gpu-api = "auto";
      fbo-format = "rgba16hf";

      # Might make colors look wrong
      # gamut-clipping = false;
      # gamut-mapping-mode = "clip";
      # hdr-compute-peak = false;

      # TODO: shaders
      glsl-shader = [
        "~~/shaders/FSRCNNX_x2_8-0-4-1_LineArt.glsl"
        "~~/shaders/SSimDownscaler.glsl"
        "~~/shaders/KrigBilateral.glsl"
      ];
      scale = "ewa_lanczossharp";
      dscale = "mitchell";
      linear-downscaling = false;
      correct-downscaling = true;
      cscale = "mitchell";

      scale-antiring = 0.7;
      dscale-antiring = 0.7;
      cscale-antiring = 0.7;

      deband = true;
      deband-iterations = 4;
      deband-threshold = 35;
      deband-range = 16;
      deband-grain = 4;
    };
  };
}
