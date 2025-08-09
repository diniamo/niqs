{ pkgs, config, ... }: {
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
    silent = true;

    settings.global.flat_search_dirs = [ "${config.user.home}/documents/dev/envs" ];
  };
}
