{
  programs.wezterm = {
    enable = true;

    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;

    extraConfig = ''
      return {
        enable_wayland = true;
      }
    '';
  };
}
