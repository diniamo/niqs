{
  lib,
  pkgs,
  ...
}: {
  programs.fish.interactiveShellInit = lib.throwIf (lib.versionOlder "3.8" pkgs.fish.version) "Fish 3.8 has been released, change to using `accept-autosuggestion and execute`, then remove this error" ''
    fish_vi_key_bindings

    bind -M insert \cu kill-whole-line

    bind -M insert \b backward-kill-word
    bind -M insert \e\[3\;5~ kill-word

    bind -M insert -k nul accept-autosuggestion execute

    bind -M insert \n history-prefix-search-forward
    bind -M insert \ck history-prefix-search-backward

    bind -M insert \ej history-token-search-forward
    bind -M insert \ek history-token-search-backward

    bind -M insert \e\[B history-search-forward
    bind -M insert \e\[A history-search-backward

    bind -M insert \t complete-and-search
  '';
}
