{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  browser = ["Schizofox.desktop"];
  documentViewer = ["org.pwmt.zathura.desktop.desktop"];
  fileManager = ["thunar.desktop"];
  editor = ["neovide.desktop"];
  imageViewer = ["imv.desktop"];
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

    "application/json" = browser;
    "application/pdf" = documentViewer;
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/discord" = ["webcord.desktop"];
  };
  globAssociations = {
    "audio/*" = mediaPlayer;
    "video/*" = mediaPlayer;
    "image/*" = imageViewer;
    "text/*" = editor;
  };

  inherit (lib.attrsets) mapAttrsToList genAttrs;
  inherit (lib.strings) splitString hasPrefix removeSuffix;
  inherit (lib) mergeAttrsList;
  commonTypes = splitString "\n" (builtins.readFile "${pkgs.shared-mime-info}/share/mime/types");
  # Glob expansion that only works if the * is at the end, I do NOT want to touch this line ever again
  expandedAssociations = mergeAttrsList (mapAttrsToList (name: value: genAttrs (builtins.filter (type: hasPrefix (removeSuffix "*" name) type) commonTypes) (_: value)) globAssociations);
in {
  xdg = {
    enable = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;

      download =
        if osConfig.tmpDownloadsDirectory
        then "/tmp/Downloads"
        else "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";

      publicShare = "${config.home.homeDirectory}/.local/share/public";
      templates = "${config.home.homeDirectory}/.local/share/templates";

      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };

    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = expandedAssociations // associations;
    };
  };

  home.packages = [pkgs.xdg-utils];
}
