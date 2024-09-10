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

	utils.api.augroup('nvim-lint-augroup', {
		event = { 'BufWritePost', 'InsertLeave' },
		command = function() lint.try_lint() end,
	})

	lint.linters_by_ft = {
		fish = { 'fish' },
		python = { 'ruff' },
	}

	lint.linters.ruff.args = {
		'--config',
		vim.fn.expand(vim.g.vim_dir .. '/lua/lsp/linter-config/ruff.toml'),
	}
end

return M
