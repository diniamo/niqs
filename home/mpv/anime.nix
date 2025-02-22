{pkgs, ...}: let
  inherit (pkgs) anime4k;

  # Use writeText instead of writeLua, so luacheck can't cry about the long lines
  autoAnime4k = pkgs.writeText "auto-anime4k-switcher.lua" ''
    local function get_nearest(x, numbers)
      local min_index = nil
      local min_dist = math.huge

      for i, n in ipairs(numbers) do
        local d = math.abs(n - x)
        if d < min_dist then
          min_index = i
          min_dist = d
        end
      end

      return numbers[min_index]
    end

    -- Fast
    -- local shader_map = {
    --     [1080] = "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl",
    --     [720]  = "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl",
    --     [480]  = "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"
    -- }
    -- HQ
    local shader_map = {
      [1080] = "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl",
      [720]  = "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Restore_CNN_Soft_VL.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl",
      [480]  = "${anime4k}/Anime4K_Clamp_Highlights.glsl:${anime4k}/Anime4K_Upscale_Denoise_CNN_x2_VL.glsl:${anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${anime4k}/Anime4K_Upscale_CNN_x2_M.glsl"
    }

    local resolutions = { 1080, 720, 480 }

    mp.register_event("file-loaded", function()
      local height = mp.get_property_number("video-params/h")

      local shaders = shader_map[height]
      if not shaders then
        height = get_nearest(height, resolutions)
        shaders = shader_map[height]
      end

      mp.osd_message("Using " .. height .. "p Anime4K shaders")
      mp.commandv("change-list", "glsl-shaders", "set", shaders)
    end)
  '';
in {
  programs.mpv.profiles.anime = {
    profile = [
      "best"
      "gpu-hq"
    ];

    sub-visibility = true;

    gpu-api = "auto";
    # fbo-format = "rgba16hf";

    script = autoAnime4k.outPath;

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
}
