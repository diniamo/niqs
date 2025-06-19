{lib, pkgs, ...}: let
  inherit (lib) splitString hasPrefix genAttrs mapAttrsToList mergeAttrsList;
  inherit (builtins) readFile filter;

  browser = ["librewolf.desktop"];
  documentViewer = ["org.pwmt.zathura.desktop"];
  fileManager = ["thunar.desktop"];
  archiver = ["org.gnome.FileRoller.desktop"];
  editor = ["emacs.desktop"];
  imageViewer = ["swayimg.desktop"];
  mediaPlayer = ["mpv.desktop"];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "inode/directory" = fileManager;
    "application/zip" = archiver;

    "application/json" = editor;
    "application/pdf" = documentViewer;

    "image/gif" = mediaPlayer;

    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/steam" = ["steam.desktop"];
  };

  groups = {
    "audio" = mediaPlayer;
    "video" = mediaPlayer;
    "image" = imageViewer;
    "text" = editor;
  };

  mimeTypes = splitString "\n" (readFile "${pkgs.shared-mime-info}/share/mime/types");
  withPrefix = prefix: filter (type: hasPrefix prefix type) mimeTypes;
  expanded = mergeAttrsList (mapAttrsToList (group: assocation: genAttrs (withPrefix group) (_: assocation)) groups);
in {
  xdg = {
    mime.defaultApplications = expanded // associations;
    menus.enable = false;
    autostart.enable = false;
    sounds.enable = false;
  };
}
