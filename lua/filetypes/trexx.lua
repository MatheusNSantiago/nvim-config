local M = {}

-- Setup treesitter
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config['trexx'] = {
	install_info = {
		url = '~/dev/trexx/tree-sitter-trexx',
		files = { 'src/parser.c' },
	},
	filetype = { 'trexx' },
}

---@type FiletypeSettings
M.settings = {
	mappings = {
		{
			'n',
			'<leader>r', -- Atalho para transpilar
			function()
				vim.cmd('w')
				local current_file = vim.fn.expand('%:p')
				-- Ajuste o caminho para o transpiler
				local transpiler_cmd = 'bun ~/dev/trexx/trexx-tool/src/cmd/transpiler-cli.ts ' .. current_file

				-- Executa em um terminal flutuante ou mensagem
				local output = vim.fn.system(transpiler_cmd)
				print(output)

				-- Opcional: Abrir o arquivo gerado
				vim.cmd('edit ' .. current_file:gsub('%.trexx$', '.teste'))
			end,
			desc = 'Trexx: [R]un Transpiler',
		},
	},
	bo = {
		commentstring = '// %s',
	},
}

return M.settings
