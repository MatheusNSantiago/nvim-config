; ╾───────────────────────────────────────────────────────────────────────────────────╼
( _ division_header: (_) @division )
( _ section_header: (_) @section )
( _ paragraph_header: (_) @paragraph )
; ╾───────────────────────────────────────────────────────────────────────────────────╼

(comment) @comment


; ╾───────────────────────────────────────────────────────────────────────────────────╼
(entry_name (WORD) @identifier
  (#not-any-of? @identifier
    "FILLER"
   ))
(qualified_word (WORD) @identifier
  (#not-any-of? @identifier
   "TRUE" "FALSE"
   ))

( (WORD) @constant
  (#match? @constant "^CTE-.*"))
( (WORD) @boolean
  (#match? @boolean "^CND-.*"))
; ╾───────────────────────────────────────────────────────────────────────────────────╼

(call_statement x: (qualified_word (_) @Function) )

(data_description (level_number) @level_number)
