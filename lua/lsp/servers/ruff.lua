local M = {}

---@see https://docs.astral.sh/ruff/editors/settings/

M.init_options = {
	settings = {
		configuration = vim.g.vim_dir .. '/lua/lsp/linter-config/ruff.toml',
		configurationPreference = 'editorFirst',
	},
}

return M
