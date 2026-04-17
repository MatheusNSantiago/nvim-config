local M = {}

-- Setup treesitter
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config['trexx'] = {
	install_info = {
		url = '~/dev/trexx/tree-sitter-trexx',
		files = { 'src/parser.c', 'src/scanner.c' },
	},
	filetype = { 'trexx' },
}

---@type FiletypeSettings
M.settings = {
  bo = {
    commentstring = "-- %s"
  },
	mappings = {
		{
			'n',
			'<leader>r', -- Atalho para transpilar
			function()
				vim.cmd('w')
				local current_file = vim.fn.expand('%:p')
				local module_name = vim.fn.fnamemodify(current_file, ':h:t')
				local file_stem = vim.fn.fnamemodify(current_file, ':t:r')
				local scratch_dir = '/tmp/trexx-scratch/' .. module_name .. '/' .. file_stem

				local transpiler_cmd = 'bun ~/dev/trexx/trexx-tool/src/cli/main.ts '
					.. current_file
					.. ' --outdir '
					.. scratch_dir

				local output = vim.fn.system(transpiler_cmd)
				if vim.v.shell_error ~= 0 then
					vim.notify(output, vim.log.levels.ERROR)
					return
				end

				local files = vim.split(vim.trim(output), '\n', { trimempty = true })
				if #files == 0 then
					return
				end

				local main_file = scratch_dir .. '/' .. files[1]

				-- Se o buffer já está aberto, só recarrega o conteúdo do disco
				local existing_buf = vim.fn.bufnr(main_file)
				if existing_buf ~= -1 then
					vim.fn.bufload(existing_buf)
					vim.api.nvim_buf_call(existing_buf, function()
						vim.cmd('edit!')
					end)
					return
				end

				vim.cmd('vsplit ' .. vim.fn.fnameescape(main_file))
			end,
			desc = 'Trexx: [R]un Transpiler',
		},
	},
}

return M.settings
