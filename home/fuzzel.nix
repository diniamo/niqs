{config, lib, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "${config.stylix.fonts.sansSerif.name}:size=20";
        icon-theme = config.stylix.icons.name;
        prompt = "'   '";
        inner-pad = 20;
        horizontal-pad = 8;
        show-actions = true;
      };

      key-bindings = {
        execute-or-next = "none";
        cursor-left = "Left Control+h";
        cursor-left-word = "Control+Left Mod1+h";
        cursor-right = "Right Control+l";
        cursor-right-word = "Control+Right Mod1+l";
        delete-line-forward = "none";
        prev = "none";
        prev-with-wrap = "Up Control+k ISO_Left_Tab";
        next = "none";
        next-with-wrap = "Down Control+j Tab";
        cancel = "Escape Control+c";
        cursor-home = "Control+a";
        cursor-end = "Control+e";
        first = "Home Control+g";
        last = "End Control+Shift+g";
      };
    };
  };
}
