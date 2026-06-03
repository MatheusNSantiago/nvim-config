local M = {}

---@see https://docs.astral.sh/ruff/editors/settings/

-- Mesma raiz do pyright: força root no monorepo, evita 1 instância por sub-pacote.
M.root_markers = { 'pyrightconfig.json', '.git' }

M.init_options = {
	settings = {
		logLevel = 'warn',
		configuration = vim.g.vim_dir .. '/lua/lsp/linter-config/ruff.toml',
		configurationPreference = 'filesystemFirst',
	},
}

return M
