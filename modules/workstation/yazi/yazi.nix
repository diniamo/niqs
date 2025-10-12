{ pkgs, ... }: {
  services.udisks2.enable = true;

  programs.yazi = {
    enable = true;
    package = pkgs.yazi.override {
      extraPackages = with pkgs; [
        mediainfo
        util-linux
        udisks
        wl-clipboard
        gtrash
        dragon-drop
      ];
    };

    plugins = {
      inherit (pkgs.yaziPlugins)
        chmod
        jump-to-char
        mediainfo
        mount
        smart-enter
        smart-paste
        toggle-pane
        wl-clipboard;

      # mount = (pkgs.yaziPlugins.mount.overrideAttrs {
      #   src = pkgs.fetchFromGitHub {
      #     owner = "diniamo";
      #     repo = "yazi-plugins";
      #     rev = "mount-more-keys";
      #     hash = "sha256-YM53SsE10wtMqI1JGa4CqZbAgr7h62MZ5skEdAavOVA=";
      #   };
      # });
    };
  };
}
