{config, ...}: let
  iconsPath = "${config.programs.wlogout.package}/share/wlogout/icons";
in {
  programs.wlogout = {
    enable = true;
    style = with config.lib.stylix.colors.withHashtag; ''
      * {
        box-shadow: none;
      }

      window {
        background-color: ${base00};
      }

      button {
        text-decoration-color: ${base05};
        color: ${base05};
        background-color: ${base02};
        border-color: ${base02};
        border-width: 2px;
        border-radius: 10px;
        border-style: solid;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
      }

      button:hover {
        background-color: ${base03};
        border-color: ${base0D};
        outline-style: none;
      }

      #lock { background-image: image(url("${iconsPath}/lock.png")); }
      #logout { background-image: image(url("${iconsPath}/logout.png")); }
      #suspend { background-image: image(url("${iconsPath}/suspend.png")); }
      #hibernate { background-image: image(url("${iconsPath}/hibernate.png")); }
      #shutdown { background-image: image(url("${iconsPath}/shutdown.png")); }
      #reboot { background-image: image(url("${iconsPath}/reboot.png")); }
    '';
  };
}
