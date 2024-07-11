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

; home-manager: programs.fish.functions.*.body
; ((binding
;   attrpath: (attrpath
;     (identifier) @expression-attribute .)
;   expression: (attrset_expression
;     (binding_set
;       [
;         (binding
;           (attrpath
;             (identifier) @body-attribute .)
;           expression: [
;             (string_expression
;               (string_fragment) @injection.content)
;             (indented_string_expression
;               (string_fragment) @injection.content)
;           ])
;         (binding
;           (attrset_expression
;             (binding_set
;               (binding
;                 (attrpath
;                   (identifier) @body-attribute)
;                 expression: [
;                   (string_expression
;                     (string_fragment) @injection.content)
;                   (indented_string_expression
;                     (string_fragment) @injection.content)
;                 ]))))
;       ])))
;   (#eq? @expression-attribute "functions")
;   (#eq? @body-attribute "body")
;   (#set! injection.language "fish"))
