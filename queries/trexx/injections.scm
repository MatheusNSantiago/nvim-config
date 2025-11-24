; Injeta SQL dentro de template strings taggeadas com 'sql'
(tagged_template_expression
  tag: (identifier) @injection.language
  (#eq? @injection.language "sql")
  template: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1))

