{ pkgs, lib, ... }: let
  inherit (lib) mkForce getExe;
  inherit (pkgs) moar symlinkJoin makeBinaryWrapper;
  inherit (builtins) concatStringsSep;

  flags = [
    "--mousemode=select" # Scrolling still works
    "--no-linenumbers"
    "--statusbar=bold"
    "--style=catppuccin-macchiato"
  ];

  wrapped = symlinkJoin {
    pname = "moar-wrapped";
    inherit (moar) version meta;

    paths = [ moar ];

    nativeBuildInputs = [ makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/moar \
        --set MOAR '${concatStringsSep " " flags}'
    '';
  };
in {
  programs.less.enable = mkForce false;

  environment = {
    systemPackages = [ wrapped ];
    sessionVariables.PAGER = getExe wrapped;
  };
}
