local M = {}

---@see https://github.com/mfussenegger/nvim-lint
function M.setup()
	return {
		'mfussenegger/nvim-lint',
		config = M.config,
		event = 'LspAttach',
	}
end

function M.config()
	local lint = require('lint')
	-- local configs = vim.g.vim_dir .. '/lua/lsp/linter-config/'

	lint.linters_by_ft = {
		javascript = { 'eslint_d' },
		typescript = { 'eslint_d' },
		javascriptreact = { 'eslint_d' },
		typescriptreact = { 'eslint_d' },
		html = { 'htmlhint', 'eslint_d' },
		json = { 'jsonlint' },
	}
	-- local add_args = function(linter, args) vim.list_extend(lint.linters[linter].args, args) end
	-- add_args('ruff', { '--config', configs .. '/ruff.toml' })

	-- ---@see https://github.com/mfussenegger/nvim-lint/issues/462#issuecomment-2288048568
	-- lint.linters['eslint_d'] = require('lint.util').wrap(lint.linters['eslint_d'], function(diagnostic)
	-- 	---@diagnostic disable-next-line: return-type-mismatch, undefined-field
	-- 	if diagnostic.message:find('Error: Could not find config file') then return nil end
	-- 	return diagnostic
	-- end)

	utils.api.augroup('nvim-lint-augroup', {
		event = { 'BufEnter', 'LspAttach', 'BufReadPost', 'BufWritePost', 'InsertLeave', 'CursorHold', 'TextChanged' },
		command = function() vim.schedule(lint.try_lint) end,
	})
end

return M
