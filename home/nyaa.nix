{inputs, ...}: {
  imports = [inputs.nyaa.homeManagerModule];

  programs.nyaa = {
    enable = true;

    # Nyaa or TorrentGalaxy, depends on what I watch more of
    default_source = "Nyaa";
    download_client = "DefaultApp";
    date_format = "%Y-%m-%d";
    hot_reload_config = false;

    notifications.position = "BottomLeft";
    clipboard.cmd = "wl-copy";

    client.default_app.use_magnet = true;
    source = {
      nyaa = {
        default_sort = "Seeders";
        default_filter = "TrustedOnly";
        default_category = "AnimeEnglishTranslated";
      };

      torrentgalaxy = {
        default_sort = "Seeders";
        default_filter = "ExcludeXXX";
      };
    };
  };
}
