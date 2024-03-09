{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    # Use fzf-tab instead
    enableCompletion = false;
    enableAutosuggestions = true;
    # Use fast-syntax-highlighting instead
    syntaxHighlighting.enable = false;

    history = {
      share = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      extended = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    initExtraFirst = ''
      # This is needed because otherwise, keybinds (from other plugins too) are overwritten, and it's hard to get around that
      ZVM_INIT_MODE=sourcing
    '';

    initExtra = ''
      ${import ./opts.nix {inherit lib;}}

      source ${./hooks.zsh}
      source ${./funcs.zsh}
    '';

    shellAliases = {
      # Needed for aliases
      sudo = "sudo ";
    };

    plugins = with pkgs; [
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-fzf-history-search";
        src = zsh-fzf-history-search;
        file = "share/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh";
      }
    ];
  };
}
