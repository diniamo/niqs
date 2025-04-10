{
  inputs,
  config,
  pkgs,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  imports = [inputs.schizofox.homeManagerModule];

  # Avoid sandboxing libva decoder
  home.sessionVariables.MOZ_DISABLE_RDD_SANDBOX = 1;

  programs.schizofox = {
    enable = true;
    package = pkgs.firefox-esr-128-unwrapped;

    theme = {
      colors = {
        background-darker = colors.base01;
        background = colors.base00;
        foreground = colors.base05;
      };
      font = config.stylix.fonts.sansSerif.name;
    };

    search = {
      defaultSearchEngine = "Searx";
      searxUrl = "https://search.notashelf.dev";
      searxQuery = "https://search.notashelf.dev/search?q={searchTerms}";
      addEngines = [
        {
          Name = "Startpage";
          Description = "Uses Google's indexer without its logging";
          Method = "GET";
          URLTemplate = "https://startpage.com/sp/search?query={searchTerms}";
        }
      ];
    };

    security = {
      sandbox = false;
      noSessionRestore = false;
    };

    misc = {
      drm.enable = true;
      contextMenu.enable = true;
    };

    settings = {
      "gfx.webrender.all" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "media.rdd-ffmpeg.enabled" = true;
      "media.av1.enabled" = true;
      "gfx.x11-egl.force-enabled" = true;
      "widget.dmabuf.force-enabled" = true;

      "browser.ctrlTab.sortByRecentlyUsed" = true;
      # This makes websites prefer dark theme (in theory)
      "layout.css.prefers-color-scheme.content-override" = 0;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      # Leaving this on breaks a lot
      "privacy.resistFingerprinting" = false;
      "permissions.fullscreen.allowed" = true;
      "dom.webnotifications.enabled" = true;
      # Restore previous session
      "browser.startup.page" = 3;
      "dom.event.clipboardevents.enabled" = true;
      # Remove window control buttons
      "browser.tabs.inTitlebar" = 0;
    };

    extensions = {
      darkreader.enable = true;
      simplefox.enable = false;
      extraExtensions = let
        mkUrl = name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
      in {
        # "simple-tab-groups@drive4ik".install_url = mkUrl "simple-tab-groups";
        "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".install_url = mkUrl "auto-tab-discard";
        "sponsorBlocker@ajay.app".install_url = mkUrl "sponsorblock";
        "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = mkUrl "bitwarden-password-manager";
        "{c84d89d9-a826-4015-957b-affebd9eb603}".install_url = mkUrl "mal-sync";
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}".install_url = mkUrl "traduzir-paginas-web";
        "idcac-pub@guus.ninja".install_url = mkUrl "istilldontcareaboutcookies";
        "{96ef5869-e3ba-4d21-b86e-21b163096400}".install_url = mkUrl "font-fingerprint-defender";
        "{e90f5de4-8510-4515-9f67-3b6654e1e8c2}".install_url = mkUrl "dictionary-anywhere";
        "@hideyoutubecontrolls".install_url = mkUrl "hide-youtube-controls";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".install_url = mkUrl "return-youtube-dislikes";
        # "addons@wakatime.com".install_url = mkUrl "wakatimes";
        "firefox@tampermonkey.net".install_url = mkUrl "tampermonkey";

        # Disable
        "{c607c8df-14a7-4f28-894f-29e8722976af}" = null; # Temporary containers
        "7esoorv3@alefvanoon.anonaddy.me" = null; # LibRedirect
      };
    };
  };
}
