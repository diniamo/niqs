{ pkgs, lib, ... }: let
  inherit (lib) getExe';

  xdg-open = getExe' pkgs.xdg-utils "xdg-open";
in {
  programs.lazygit = {
    enable = true;

    settings = {
      gui = {
        scrollHeight = 1;
        expandFocusedSidePanel = true;
        language = "en";
        timeFormat = "2015/02/25";
        shortTimeFormat = "15:04";
        nerdFontsVersion = 3;
        showDivergenceFromBaseBranch = "arrowAndNumber";
        filterMode = "fuzzy";
      };
      git = {
        autoFetch = false;
        autoRefresh = false;
        autoForwardBranches = "none";
      };
      update.method = "never";
      os = {
        editPreset = "helix (hx)";
        open = "${xdg-open} '{{filename}}'";
        openLink = "${xdg-open} '{{link}}'";
        copyToClipboardCmd = "${getExe' pkgs.coreutils "echo"} -n '{{text}}' | ${getExe' pkgs.wl-clipboard "wl-copy"}";
        readFromClipboardCmd = getExe' pkgs.wl-clipboard "wl-paste";
      };
      promptToReturnFromSubprocess = false;
    };
  };
}
