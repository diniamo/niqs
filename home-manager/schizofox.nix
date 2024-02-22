{ inputs, osConfig, lib, ... }:
let
  cfg = osConfig.modules.style;

  colors = cfg.colorScheme.colors;
  fontName = cfg.font.name;
in {
  imports = [ inputs.schizofox.homeManagerModule ];

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

    security = {
      sanitizeOnShutdown = false;
      sandbox = true;
      noSessionRestore = false;
      userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };
  
    misc = {
      drmFix = true;
      disableWebgl = false;
    };

    settings = {
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "gfx.webrender.all" = true;
      # This makes websites prefer a dark theme
      "layout.css.prefers-color-scheme.content-override" = 0;
    };

    extensions = {
      darkreader.enable = true;
      simplefox.enable = false;
      extraExtensions = let
          mkUrl = name: "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
	in {
          # Todo: tab groups, switch to vimium-c

          "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".install_url = mkUrl "auto-tab-discard";
          "sponsorBlocker@ajay.app".install_url = mkUrl "sponsorblock";
          "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = mkUrl "bitwarden-password-manager";
          "{c84d89d9-a826-4015-957b-affebd9eb603}".install_url = mkUrl "mal-sync";
          "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}".install_url = mkUrl "traduzir-paginas-web";
          "idcac-pub@guus.ninja".install_url = mkUrl "istilldontcareaboutcookies";
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}".install_url = mkUrl "vimium-ff";
          "{96ef5869-e3ba-4d21-b86e-21b163096400}".install_url = mkUrl "font-fingerprint-defender";
          "{e90f5de4-8510-4515-9f67-3b6654e1e8c2}".install_url = mkUrl "dictionary-anywhere";
          "@hideyoutubecontrolls".install_url = mkUrl "hide-youtube-controls";
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".install_url = mkUrl "return-youtube-dislikes";
	};
    };
  };
}
