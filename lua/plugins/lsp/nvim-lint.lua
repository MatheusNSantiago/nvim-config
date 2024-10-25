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

	local ft = lint.linters_by_ft

	ft.python = { 'ruff' }
	vim.list_extend(lint.linters.ruff.args, { '--config', configs .. '/ruff.toml' })

	ft.javascript = { 'eslint_d' }
	ft.typescript = { 'eslint_d' }
	ft.javascriptreact = { 'eslint_d' }
	ft.typescriptreact = { 'eslint_d' }
	ft.html = { 'eslint_d' }

	---@see https://github.com/mfussenegger/nvim-lint/issues/462#issuecomment-2288048568
	lint.linters.eslint_d = require('lint.util').wrap(lint.linters.eslint_d, function(diagnostic)
		---@diagnostic disable-next-line: return-type-mismatch
		if diagnostic.message:find('Error: Could not find config file') then return nil end
		return diagnostic
	end)

	--  ╾───────────────────────────────────────────────────────────────────────────────────╼
	utils.api.augroup('nvim-lint-augroup', {
		event = { 'BufEnter', 'LspAttach', 'BufReadPost', 'BufWritePost', 'InsertLeave', 'CursorHold' },
		command = function() lint.try_lint() end,
	})
end

return M
