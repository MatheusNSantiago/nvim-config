local M = {}

function M.setup()
	return {
		'mfussenegger/nvim-lint',
		config = M.config,
		event = 'LspAttach',
	}
end

function M.config()
	local lint = require('lint')
	local configs = vim.g.vim_dir .. '/lua/lsp/linter-config/'

	lint.linters_by_ft = {
		python = { 'ruff' },
	}

	vim.list_extend(lint.linters.ruff.args, { '--config', configs .. '/ruff.toml' })

	utils.api.augroup('nvim-lint-augroup', {
		event = { 'BufEnter', 'LspAttach', 'BufReadPost', 'BufWritePost', 'InsertLeave', 'CursorHold' },
		command = function() lint.try_lint() end,
	})
end

return M
