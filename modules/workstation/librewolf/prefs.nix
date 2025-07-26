{
  # Make ctrl-tab cycle recents
  "browser.ctrlTab.sortByRecentlyUsed" = true;
  # This makes websites prefer dark theme (in theory)
  "layout.css.prefers-color-scheme.content-override" = 0;
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
  # Everything is saved anyway, not a huge deal if I misclick
  "browser.warnOnQuit" = false;
  "browser.warnOnQuitShortcut" = false;
  # Don't suggest engines in the search bar
  "browser.urlbar.suggest.engines" = false;
  # Don't focus the 3 dots when tabbing through search bar suggestions
  "browser.urlbar.resultMenu.keyboardAccessible" = false;
}
