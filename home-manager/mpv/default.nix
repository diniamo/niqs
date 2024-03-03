{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./config.nix
    ./binds.nix
    ./profiles.nix
    ./uosc.nix
  ];

  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      # Missing: UndoRedo, skip-intro, clipshot, autosubsync
      reload
      thumbfast
      mpris
      mpv-webm
      seekTo
      sponsorblock-minimal
    ];
    # scriptOpts = {};
  };

  home.file."${config.xdg.configHome}/mpv/shaders".source = ./shaders;
}
