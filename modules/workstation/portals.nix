{ lib, pkgs, config, flakePkgs, ... }: let
  inherit (lib) getExe;
  inherit (pkgs.writers) writeDash writeText writeBash;

  foot = getExe config.custom.foot.finalPackage;
  yazi = getExe config.custom.yazi.finalPackage;

  xdptCommand = "${foot} --title='File Picker' --window-size-pixels=1600x900 ${yazi}";
  xdptWrapper = writeDash "xdpt-wrapper.sh" ''
    set -e
    [ $6 -gt 4 ] && set -x

    directory=$2
    path="$4"
    out="$5"

    if [ $directory = 1 ]; then
      ${xdptCommand} --cwd-file="$out" "$path"
    else
      ${xdptCommand} --chooser-file="$out" "$path"
    fi
  '';
  xdptConfig = writeText "xdpt-config" ''
    [filechooser]
    cmd=${xdptWrapper}
    open_mode=last
    save_mode=last
  '';

  ft = flakePkgs.niqspkgs.filemanager1-terminal;
  ftWrapper = writeBash "ft-wrapper" ''
    # Don't need the method
    shift

    items=()
    for arg in "$@"; do
      items+=("$(printf '%b' "''${arg//%/\\x}")")
    done

    ${foot} ${yazi} ''${items[@]}
  '';
in {
  xdg.portal = {
    enable = true;

    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      ft
    ];

    config.common = {
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
      "org.freedesktop.impl.portal.Screenshot.PickColor" = getExe pkgs.hyprpicker;
    };
  };

  systemd.user.services = {
    xdg-desktop-portal-termfilechooser.serviceConfig.ExecStart = [
      ""
      "${pkgs.xdg-desktop-portal-termfilechooser}/libexec/xdg-desktop-portal-termfilechooser --config=${xdptConfig}"
    ];

    filemanager1-terminal = {
      description = "D-Bus wrapper for opening directories in the terminal";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.FileManager1";
        ExecStart = "${ft}/libexec/file_manager_dbus ${ftWrapper}";
        Restart = "on-failure";
      };
    };

    unified-inhibit = {
      description = "unify wakelock portals";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = getExe flakePkgs.niqspkgs.unified-inhibit;
        Restart = "on-failure";
        NoNewPrivileges = false;
      };
    };
  };
}
