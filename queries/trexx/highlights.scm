; --- Keywords ---
(config_block "config" @keyword)
(include_statement "include" @keyword.import)
(routine_definition "routine" @keyword.function)
(test_block "test" @keyword.function)
(mock_block [ "mock" "iib" "program" ] @keyword)
(input_block "input" @keyword)
(mock_when_clause "when" @keyword.control) ; Corrigido

[
  (keyword_setup)
  (keyword_cleanup)
] @keyword.function

[
  (keyword_assert)

  (keyword_select)
  (keyword_insert)
  (keyword_update)
  (keyword_delete)
  (keyword_from)
  (keyword_where)
  (keyword_into)
  (keyword_values)
  (keyword_set)
  (keyword_and)
  (keyword_or)
  ; (keyword_in)
  ; (keyword_like)
  ; (keyword_order)
  ; (keyword_group)
  ; (keyword_by)
  ; (keyword_limit)
  ; (keyword_join)
  ; (keyword_on)
  (keyword_as)
  ; (keyword_distinct)
  (keyword_null)
] @keyword


; Controle de Fluxo
[
  "for"
  "in"
  "if"
  "else"
] @keyword.control

; --- Identificadores e Definições ---

(identifier) @variable

(routine_definition
  name: (identifier) @function)

(test_block
  name: (_) @string.special)

(constant_definition
  name: (constant_identifier) @constant)

(parameter
  (identifier) @variable.parameter)

(config_pair
  key: (identifier) @property)

(object_field
  (identifier) @property)

; --- Chamadas (Unificadas como Invocation) ---
(invocation name: (identifier) @function.call)


; --- SQL Objects (Usando nomes reais da gramática) ---
; (object_reference
;   schema: (identifier) @constant
;   name: (identifier) @constant) ; Tabela

; --- Literais (Usando nós internos do SQL) ---
[
  (literal_string)
  ; (single_quote_string)
  ; (double_quote_string)
] @string

[
  (integer)
  (decimal_number)
] @number

[
  (keyword_true)
  (keyword_false)
] @boolean

(keyword_null) @constant.builtin

(constant_identifier) @constant

; --- Mock Attributes ---
(attribute
  (identifier) @property)


(mock_block
  target: (_) @string.special)

; --- Operadores ---
(binary_expression
  operator: _ @operator)

(unary_expression
  operator: _ @operator)


[
  "="
  ":"
] @operator

; --- Pontuação ---
[
  "(" ")"
  "[" "]"
  "{" "}"
] @punctuation.bracket

[
  ","
  ";"
  "."
] @punctuation.delimiter

(comment) @comment @spell
