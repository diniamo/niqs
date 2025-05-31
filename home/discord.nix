{lib, config, pkgs, ...}: let
  inherit (lib) mkEnableOption mkIf replaceString;
  
  package = pkgs.discord.override {
    withOpenASAR = true;
    withTTS = false;
    disableUpdates = false;
  };

  inherit (config.stylix) fonts;
  font = "\"${fonts.sansSerif.name}\", \"${fonts.emoji.name}\"";

  settings = {
    SKIP_HOST_UPDATE = true;
    MINIMIZE_TO_TRAY = false;
    OPEN_ON_STARTUP = false;
    DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;

    openasar = {
      setup = true;
      quickstart = false; # Breaks Discord sometimes, and doesn't even seem faster
      themeSync = false;
      css = ''
        /* Hide nitro ads */
        @import url("https://allpurposem.at/disblock/DisblockOrigin.theme.css");
        /* Hide titlebar */
        @import url("https://surgedevs.github.io/visual-refresh-compact-title-bar/browser.css");
        
        /* System fonts */
        :root {
          --font-primary: ${font} !important;
          --font-display: ${font} !important;
          --font-headline: ${font} !important;
          --font-code: "${fonts.monospace.name}" !important;
          /* Make the sidebar line up correctly with disabled title bar */
          --vr-header-snippet-server-padding: 8px !important;
        }

        /* Align chatbox */
        form div[class^="channelBottomBarArea_"] {
          --custom-chat-input-margin-bottom: 8px;
          --custom-channel-textarea-text-area-height: 56px;
        }

        /* Hide "Now Playing" section on friends list */
        div[class^="nowPlayingColumn_"] {
          display: none !important;
        }
      '';
    };
  };
in {
  options = {
    programs.discord.enable = mkEnableOption "discord";
  };

  config = mkIf config.programs.discord.enable {
    home.packages = [package];
    xdg.configFile."discord/settings.json".text = builtins.toJSON settings;
  };
}
