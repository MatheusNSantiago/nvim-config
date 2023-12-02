; ╾───────────────────────────────────────────────────────────────────────────────────╼
( _ division_header: (_) @division )
( _ section_header: (_) @section )
( _ paragraph_header: (_) @paragraph )
; ╾───────────────────────────────────────────────────────────────────────────────────╼

; ╾───────────────────────────────────────────────────────────────────────────────────╼
((WORD) @identifier
  (#not-any-of? @identifier
   "FILLER" "TRUE" "FALSE" "RUN" "RETURN-CODE"))

((WORD) @constant
  (#match? @constant "^CTE-.*"))
((WORD) @boolean
  (#match? @boolean "^CND-.*"))
; ╾───────────────────────────────────────────────────────────────────────────────────╼

(call_statement x: (qualified_word (_) @Function) )

(data_description (level_number) @level_number)
