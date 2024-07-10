{
  programs.fish.functions = {
    _reset_cursor_shape = {
      onEvent = "fish_prompt";
      body = "echo -e '\e[5 q'";
    };
  };
}
