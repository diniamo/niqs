{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./config.nix
    ./binds.nix
    ./profiles.nix
  ];

  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      # Missing: UndoRedo, skip-intro, clipshot, autosubsync
      uosc
      reload
      thumbfast
      mpris
      mpv-webm
      seekTo
      sponsorblock-minimal
    ];
    scriptOpts = {
      uosc = {
        timeline_size_min = 0;
        use_trash = true;
      };
    };
  };

  home.file."${config.xdg.configHome}/mpv/shaders".source = ./shaders;
}
