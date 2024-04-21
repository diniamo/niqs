{
  programs.wezterm = {
    enable = true;
    # Temporary until I disable foot
    enableZshIntegration = false;
    extraConfig = ''
      return {
        enable_wayland = true;
      }
    '';
  };
}
