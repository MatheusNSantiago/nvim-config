; --- Keywords & Controle ---
(metadata_statement "test" @function.macro) ; 'test' parece uma macro/função global
(import_statement "import" @keyword.import "from" @keyword.import)
(setup_block "setup" @keyword.function)
(mocks_block "mocks" @keyword.function)
(execute_block "execute" @keyword.function)


[
 "const"
 "let"
 "var"
] @keyword

[
  "for"
  "if"
  "else"
] @keyword.control

(identifier) @variable

; --- Funções ---
(function_declaration
  "function" @keyword.function
  name: (identifier) @function)

(call_expression
  function: (identifier) @function.call)

(call_expression
  function: (member_expression
    property: (identifier) @method.call))

; --- Variáveis e Propriedades ---
(pair
  key: (identifier) @property)

(member_expression
  property: (identifier) @property)

; --- Literais ---
(string) @string
(number) @number
(boolean) @boolean
(null) @constant.builtin
(template_string) @string

; Exceção para SQL - Tenta usar @nospell ou @none
((tagged_template_expression
    tag: (identifier) @tag_name
    template: (template_string) @embedded_sql)
 (#eq? @tag_name "sql")
 (#set! "priority" 105))


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

(template_substitution
  "${" @punctuation.special
  "}" @punctuation.special) @embedded

(comment) @comment @spell

; --- SQL Tag ---
(tagged_template_expression
  tag: (identifier) @function.macro) ; Pinta 'sql' como macro


; --- Operadores Matemáticos e Lógicos ---

; Operadores Binários (+ - * / < > == && ||)
(binary_expression
  operator: _ @operator)

; Atribuição (=)
(assignment_expression
  "=" @operator)
(variable_declaration
  "=" @operator)

; Incremento/Decremento (++ --)
(update_expression
  [
    "++"
    "--"
  ] @operator)

; Seta de Função (=>)
(arrow_function
  "=>" @operator)

