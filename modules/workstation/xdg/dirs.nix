{ config, ... }: let
  inherit (config.user) home;
in {
  environment.sessionVariables = {
    XDG_DESKTOP_DIR = "${home}/desktop";
    XDG_DOCUMENTS_DIR = "${home}/documents";
    XDG_DOWNLOAD_DIR = "/tmp/downloads";
    XDG_MUSIC_DIR = "${home}/music";
    XDG_PICTURES_DIR = "${home}/pictures";
    XDG_PUBLICSHARE_DIR = "${home}/public";
    XDG_TEMPLATES_DIR = "${home}/templates";
    XDG_VIDEOS_DIR = "${home}/videos";

    GOPATH = "${home}/.local/share/go";
    CUDA_CACHE_PATH = "${home}/.cache/nv";
  };
}
