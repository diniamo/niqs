{ pkgs, config, inputs, ... }: {
  custom.mpv = {
    enable = true;

    package = pkgs.mpv-unwrapped.override {
      ffmpeg = pkgs.ffmpeg-headless;

      alsaSupport = false;
      javascriptSupport = false;
      pulseSupport = false;
      x11Support = false;
    };

    settings = {
      profile = "high-quality";

      cache = true;

      fullscreen = true;
      keepaspect-window = false;
      window-dragging = false;

      audio-device = "pipewire";
      volume-max = 100;

      save-position-on-quit = true;
      watch-later-options-remove = "vf,af";

      osc = false;
      osd-font = config.custom.style.fonts.regular.name;
      osd-duration = 3000;
      osd-status-msg = "Frame: \${estimated-frame-number} / \${estimated-frame-count}";

      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      ytdl-raw-options = "cookies-from-browser=\"firefox:${config.home.directory}/.librewolf\",mark-watched=";

      alang = "ja,de,en,hu";
      slang = "de,en,hu";
      sub-visibility = false;
    };

    profiles.anime = {
      profile = "high-quality";
      sub-visibility = true;

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
  };
}
