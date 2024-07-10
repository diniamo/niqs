{
  lib,
  pkgs,
  ...
}: {
  programs.fish.interactiveShellInit = lib.throwIf (lib.versionOlder "3.8" pkgs.fish.version) "Fish 3.8 has been released, change to using `accept-autosuggestion and execute`, then remove this error" ''
    bind \cu kill-whole-line

    bind \b backward-kill-word
    bind \e\[3\;5~ kill-word
    # \ch = \cb so I can't do this
    # bind \ch backward-word
    # bind \cl forward-word

    bind -k nul accept-autosuggestion execute

    bind \cj history-prefix-search-forward
    bind \ck history-prefix-search-backward

    bind \ej history-token-search-forward
    bind \ek history-token-search-backward

    bind \e\[B history-search-forward
    bind \e\[A history-search-backward

    bind \t complete-and-search
  '';
}
