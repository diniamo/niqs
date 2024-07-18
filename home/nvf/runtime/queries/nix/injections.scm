; extends

; home-manager:
; - programs.fish.{interactiveShellInit,loginShellInit,shellInitLast,shellInit}
; - programs.fish.functions.*.body
((binding
  attrpath: (attrpath
    (identifier) @attribute .)
  expression: [
    (string_expression
      (string_fragment) @injection.content)
    (indented_string_expression
      (string_fragment) @injection.content)
  ])
  (#any-of? @attribute
    "interactiveShellInit"
    "loginShellInit"
    "shellInitLast"
    "shellInit"

    "body")
  (#set! injection.language "fish"))

((apply_expression
  function: (variable_expression
    name: (identifier) @function)
  argument: [
    (string_expression
      (string_fragment) @injection.content)
    (indented_string_expression
      (string_fragment) @injection.content)
  ])
  (#eq? @function "mkLuaInline")
  (#set! injection.language "lua"))
