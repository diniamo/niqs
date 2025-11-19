{ lib, ... }: let
  inherit (lib) mkForce hasPrefix genAttrs mapAttrsToList mergeAttrsList;
  inherit (lib.generators) toINI;
  inherit (builtins) filter;

  browser = "helium.desktop";
  documentViewer = "org.pwmt.zathura.desktop";
  fileManager = "yazi.desktop";
  archiver = "org.gnome.FileRoller.desktop";
  editor = "Helix.desktop";
  imageViewer = "imv.desktop";
  mediaPlayer = "mpv.desktop";

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

    "x-scheme-handler/spotify" = "spotify.desktop";
    "x-scheme-handler/steam" = "steam.desktop";
  };

  groups = {
    "audio" = mediaPlayer;
    "video" = mediaPlayer;
    "image" = imageViewer;
    "text" = editor;
  };

  mimeTypes = import ./mime-types.nix;
  withPrefix = prefix: filter (type: hasPrefix prefix type) mimeTypes;
  expanded = mergeAttrsList (mapAttrsToList (group: assocation: genAttrs (withPrefix group) (_: assocation)) groups);

  mimeapps = toINI {} { "Default Applications" = expanded // associations; };
in {
  xdg = {
    mime.defaultApplications = expanded // associations;
    menus.enable = mkForce false;
    autostart.enable = mkForce false;
  };

  home.files.".config/mimeapps.list" = {
    name = "mimeapps.list";
    text = mimeapps;
  };
}
