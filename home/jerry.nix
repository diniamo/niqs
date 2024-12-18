{
  inputs,
  flakePkgs,
  config,
  ...
}: {
  imports = [inputs.jerry.homeManagerModules.default];

  programs.jerry = {
    enable = true;
    package = flakePkgs.jerry.default.override {
      mpv = config.programs.mpv.package;
      imagePreviewSupport = true;
      infoSupport = true;
    };

    config = {
      player_arguments = "--profile=anime";
      provider = "allanime";
      manga_opener = "swayimg";
      score_on_completion = "true";
      image_preview = "true";
    };
  };
}
