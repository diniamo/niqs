{
  # Make ctrl-tab cycle recents
  "browser.ctrlTab.sortByRecentlyUsed" = true;
  # Use xdg-desktop-portal for file pickers
  "widget.use-xdg-desktop-portal.file-picker" = 1;
  # Restore previous session
  "browser.startup.page" = 3;
  # Remove window control buttons
  "browser.tabs.inTitlebar" = 0;
  # Hide bookmarks toolbar
  "browser.toolbars.bookmarks.visibility" = "never";
  # Don't clear cookies and history
  "privacy.clearOnShutdown_v2.cache" = false;
  "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
  "privacy.sanitize.sanitizeOnShutdown" = false;
  # Everything is saved anyway, not a huge deal if I misclick
  "browser.warnOnQuit" = false;
  "browser.warnOnQuitShortcut" = false;
  # Don't suggest engines in the search bar
  "browser.urlbar.suggest.engines" = false;
  # Don't focus the 3 dots when tabbing through search bar suggestions
  "browser.urlbar.resultMenu.keyboardAccessible" = false;
  # Don't offer to translate every single website
  "browser.translations.automaticallyPopup" = false;
  # Devtools on the bottom is annoying, put it on the right
  "devtools.toolbox.host" = "right";
  # Download to tmp
  "browser.download.dir" = "/tmp/downloads";
  "browser.download.useDownloadDir" = true;
  "browser.download.start_downloads_in_tmp_dir" = false;
  # Use the GPU, that's what it's there for
  "gfx.webrender.all" = true;
  "layers.gpu-process.enabled" = true;
  "dom.webgpu.enabled" = true;
  "media.gpu-process-decoder" = true;
  "widget.dmabuf.force-enabled" = true;
}
