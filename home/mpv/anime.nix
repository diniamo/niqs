{
  pkgs,
  inputs,
  ...
}: {
  programs.mpv.profiles.anime = {
    sub-visibility = true;

    profile = "high-quality";
    vo = "gpu-next";
    gpu-api = "vulkan";

    glsl-shader = "${inputs.artcnn}/GLSL/ArtCNN_C4F32.glsl";
    scale = "ewa_lanczos";
    scale-blur = 0.981251;

    # Luma down
    dscale = "catmull_rom";

    # Dithering
    dither = "error-diffusion";
    dither-depth = "auto";
    error-diffusion = "sierra-lite";

    # Antiring
    scale-antiring = 0.5;
    dscale-antiring = 0.5;
    cscale-antiring = 0.5;

    # Debanding
    deband = true;
    deband-iterations = 4;
    deband-threshold = 35;
    deband-range = 16;
    deband-grain = 4;
  };
}
