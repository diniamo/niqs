{ pkgs, ... }: {
  services.udisks2.enable = true;

  custom.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      extraPackages = with pkgs; [
        mediainfo
        util-linux
        udisks
        wl-clipboard
        gtrash
        dragon-drop
      ];
    };

    plugins = {
      inherit (pkgs.yaziPlugins)
        chmod
        jump-to-char
        mediainfo
        mount
        smart-paste
        toggle-pane
        wl-clipboard;
    };

    settings.yazi = {
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
  };
}
