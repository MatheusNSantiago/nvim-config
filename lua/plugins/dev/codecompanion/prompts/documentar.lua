---@param ... string Lista de padrões de tipo para corresponder aos tipos do node.
---@return TSNode|nil node primeiro nó que corresponde a qualquer um dos padrões fornecidos, ou nil se nenhuma correspondência for encontrada.
local function find_parent_node_with_type(...)
	local node = vim.treesitter.get_node()
	local patterns = { ... } -- Captura todos os argumentos em uma tabela

	while node do
		local node_type = node:type()
		for _, pattern in ipairs(patterns) do
			if node_type:match(pattern) then return node end
		end
		node = node:parent()
	end

	return nil
end

local function get_code_from_node(node)
	local start_line, _, end_line, _ = node:range()
	local code = require('codecompanion.helpers.actions').get_code(start_line, end_line + 1)
	return code
end

return {
	strategy = 'chat',
	description = 'Criar documentação para dada função/classe',
	opts = {
		index = 4,
		is_default = false,
		is_slash_cmd = false,
		user_prompt = false,
		auto_submit = true,
		short_name = 'documentar',
	},
	prompts = {
		{
			role = 'system',
			content = function(context)
				local doc_format
				if context.filetype == 'python' then
					doc_format = 'docstring'
				elseif context.filetype == 'lua' then
					doc_format = 'emmylua'
				else
					doc_format = 'markdown'
				end

				return string.format(
					[[
Aja como um desenvolvedor senior especialista em %s. Ao receber uma classe ou uma função, você deve retornar sua documentação em formato %s.
Siga as seguinets diretrizes:
  - Reponda apenas com a documentação
  - Caso for uma classe, não inclua a documentação dos métodos]],
					context.filetype,
					doc_format
				)
			end,
			opts = { visible = false, tag = 'system_tag' },
		},
		{
			role = 'user',
			content = function(context)
				local node = find_parent_node_with_type('function', 'class')
				local code = get_code_from_node(node)
				return string.format(
					[[
```%s
%s
```
]],
					context.filetype,
					code
				)
			end,
			opts = { contains_code = true, visible = false },
		},
	},
}
