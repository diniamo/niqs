{ pkgs, lib, ... }: let
  inherit (lib) mkForce getExe;
  inherit (pkgs) moor symlinkJoin makeBinaryWrapper;
  inherit (builtins) concatStringsSep;

  flags = [
    "--mousemode=select" # Scrolling still works
    "--no-linenumbers"
    "--statusbar=bold"
    "--style=catppuccin-macchiato"
    "--quit-if-one-screen"
  ];

  wrapped = symlinkJoin {
    pname = "moor-wrapped";
    inherit (moor) version meta;

    paths = [ moor ];

    nativeBuildInputs = [ makeBinaryWrapper ];
    postBuild = ''
      wrapProgram $out/bin/moor \
        --set MOOR '${concatStringsSep " " flags}'
    '';
  };
in {
  programs.less.enable = mkForce false;

  environment = {
    systemPackages = [ wrapped ];
    sessionVariables.PAGER = getExe wrapped;
  };
}
