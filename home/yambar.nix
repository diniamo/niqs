{config, ...}: let
  inherit (config.stylix) fonts;
  inherit (config.lib.stylix) colors;
in {
  programs.yambar = {
    enable = true;
    settings = {
      bar = {
        height = 24;
        location = "bottom";
        background = "181926ff";
        foreground = "cad3f5ff";
        font = "${fonts.sansSerif.name}:pixelsize=14";
  
        left = [
          {
            i3 = {
              sort = "native";
              strip-workspace-numbers = true;
        
              content."".map = let
                common = {
                  text = "{name}";
                  margin = 7;
                  on-click = "swaymsg --quiet workspace {name}";
                };
              in {
                conditions = {
                  "state == focused".string = common // {
                    deco.stack = [
                      { background.color = "ffffff20"; }
                      { underline = { size = 2; color = "cad3f5ff"; }; }
                    ];
                  };
            
                  "state == urgent".string = common // {
                    deco.background.color = "ed879640";
                  };
                };
          
                default.string = common;
              };
            };
          }
        ];
        
        right = [
          {
            clock.content.string = {
              right-margin = 6;
              text = "{time}";
            };
          }
        ];
      };
    };
  };
}
