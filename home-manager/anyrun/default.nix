{
  inputs,
  osConfig,
  flakePkgs,
  ...
}: let
  inherit (inputs) anyrun;
  packages = flakePkgs.anyrun;
in {
  imports = [anyrun.homeManagerModules.default];

  # For scripts
  home.packages = [packages.stdin];

  programs.anyrun = {
    enable = true;

    config = {
      # x.fraction = 0.5;
      y.fraction = 0.2;
      # width.absolute = 400;
      # height.absolute = 232;

      hideIcons = false;
      # maxImageWidth = 150;
      # maxImageHeight = 100;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = false;
      maxEntries = 10;

      plugins = with packages; [
        applications
        rink
        symbols
        websearch
        shell
        dictionary
        translate
      ];
    };
    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          // Also shows desktop actions
          desktop_actions: true,
          max_entries: 10,
          // For terminal entries
          terminal: Some("${osConfig.modules.values.terminal}"),
        )
      '';
      "shell.ron".text = ''
        Config(
          prefix: "$",
          shell: None
        )
      '';
      "symbols.ron".text = ''
        Config(
          prefix: "%",
          symbols: {
            "shrug": "¯\\_(ツ)_/¯",
          },
          max_entries: 5,
        )
      '';
      "dictionary.ron".text = ''
        Config(
          prefix: ":",
          max_entries: 5
        )
      '';
      "translate.ron".text = ''
        Config(
          prefix: ";",
          language_delimiter: ">",
          max_entries: 3
        )
      '';
      "websearch.ron".text = ''
        Config(
          prefix: "?",
          engines: [Custom(name: "Startpage", url: "startpage.com/do/search?query={}")]
        )
      '';
    };
    extraCss = builtins.readFile ./style.css;
  };
}
