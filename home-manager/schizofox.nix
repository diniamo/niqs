{ inputs, osConfig, ... }:
let
  cfg = osConfig.modules.style;

  colors = cfg.colorScheme.colors;
  fontName = cfg.font.name;
in {
  imports = [ inputs.schizofox.homeManagerModule ];

  # home.packages = with osConfig.nur.repos.rycee.firefox-addons; [
  #   bitwarden
  #   ublock-origin
  #   mal-sync
  #   sponsorblock
  #   translate-web-pages
  #   i-dont-care-about-cookies
  #   vimium
  #   return-youtube-dislikes
  # ];

  programs.schizofox = {
    enable = true;

    theme = {
      colors = {
        background-darker = colors.base01;
        background = colors.base00;
        foreground = colors.base05;
      };
      font = fontName;
    };

    search = {
      defaultSearchEngine = "Startpage";
      addEngines = [
        {
	  Name = "Startpage";
	  Description = "Uses Google's indexer without its logging";
	  Method = "GET";
	  URLTemplate = "https://startpage.com/do/search?query={searchTerms}";
	}
      ];
    };

    extensions = {
      darkreader.enable = true;
      simplefox.enable = false;
      extraExtensions = {
        "webextension@bitwarden.com".install_url = "https://addons.mozilla.org/firefox/downloads/bitwarden-password-manager/latest.xpi";
        # "Auto Tab Discard".install_url = "https://addons.mozilla.org/firefox/downloads/auto-tab-discard/latest.xpi";
        "webextension@ublockorigin.com".install_url = "https://addons.mozilla.org/firefox/downloads/ublock-origin/latest.xpi";
        "webextension@malsync.moe".install_url = "https://addons.mozilla.org/firefox/downloads/mal-sync/latest.xpi";
        "webextension@sponsor.ajay.app".install_url = "https://addons.mozilla.org/firefox/downloads/sponsorblock/latest.xpi";
        "webextension@TWP".install_url = "https://addons.mozilla.org/firefox/downloads/traduzir-paginas-web/latest.xpi";
        # "FastForward".install_url = "https://addons.mozilla.org/firefox/downloads/fastforwardteam/latest.xpi";
        "webextension@i-still-dont-care-about-cookies".install_url = "https://addons.mozilla.org/firefox/downloads/istilldontcareaboutcookies/latest.xpi";
        "webextension@vimium.github.io".install_url = "https://addons.mozilla.org/firefox/downloads/vimium-ff/latest.xpi";
        "webextension@font-fingerprint-defender".install_url = "https://addons.mozilla.org/firefox/downloads/font-fingerprint-defender/latest.xpi";
        "webextension@dictionary-anywhere".install_url = "https://addons.mozilla.org/firefox/downloads/dictionary-anyvhere/latest.xpi";
        "webextension@hide-youtube-controls".install_url = "https://addons.mozilla.org/firefox/downloads/hide-youtube-controls/latest.xpi";
        "webextension@returnyoutubedislike.com".install_url = "https://addons.mozilla.org/firefox/downloads/return-youtube-dislikes/latest.xpi";
      };
    };
  };
}
