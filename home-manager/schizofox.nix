{ inputs, ... }: {
  imports = [ inputs.schizofox.homeManagerModule ];

  programs.schizofox = {
    enable = true;

    theme = {
      # Todo: firefox theme
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

    misc = {
      startPageURL = "https://startpage.com";
    };

    extensions = {
      darkreader.enable = true;
      extraExtensions = {
        "Bitwarden".install_url = "https://addons.mozilla.org/firefox/downloads/bitwarden-password-manager/latest.xpi";
        # "Auto Tab Discard".install_url = "https://addons.mozilla.org/firefox/downloads/auto-tab-discard/latest.xpi";
        "uBlock Origin".install_url = "https://addons.mozilla.org/firefox/downloads/ublock-origin/latest.xpi";
        "MAL-Sync".install_url = "https://addons.mozilla.org/firefox/downloads/mal-sync/latest.xpi";
        "SponsorBlock".install_url = "https://addons.mozilla.org/firefox/downloads/sponsorblock/latest.xpi";
        "Translate this page".install_url = "https://addons.mozilla.org/firefox/downloads/traduzir-paginas-web/latest.xpi";
        # "FastForward".install_url = "https://addons.mozilla.org/firefox/downloads/fastforwardteam/latest.xpi";
        "I still don't care about cookies".install_url = "https://addons.mozilla.org/firefox/downloads/i-dont-care-about-cookies/latest.xpi";
        "Vimium".install_url = "https://addons.mozilla.org/firefox/downloads/vimium-ff/latest.xpi";
        "Font Fingerprint Defender".install_url = "https://addons.mozilla.org/firefox/downloads/font-fingerprint-defender/latest.xpi";
        "Dictionary Anywhere".install_url = "https://addons.mozilla.org/firefox/downloads/dictionary-anyvhere/latest.xpi";
        "Hide YouTube Fullscreen Controls".install_url = "https://addons.mozilla.org/firefox/downloads/hide-youtube-controls/latest.xpi";
      };
    };
  };
}
