{
  programs.yazi.settings.yazi = {
    tasks = {
      image_alloc = 1024 * 1024 * 1024;
    };

    plugin = {
      prepend_preloaders = [
        { mime = "{audio,video,image}/*"; run = "mediainfo"; }
        { mime = "application/subrip"; run = "mediainfo"; }
        { mime = "application/postscript"; run = "mediainfo"; }
      ];
      prepend_previewers = [
        { mime = "{audio,video,image}/*"; run = "mediainfo"; }
        { mime = "application/subrip"; run = "mediainfo"; }
        { mime = "application/postscript"; run = "mediainfo"; }
      ];
    };
  };
}
