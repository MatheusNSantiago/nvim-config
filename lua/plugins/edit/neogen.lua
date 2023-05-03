local M = {}

function M.setup()
	return {
		'danymat/neogen',
		requires = 'nvim-treesitter/nvim-treesitter',
		config = M.config,
	}
end

function M.config()
	require('neogen').setup({
		enabled = true,
		snippet_engine = 'luasnip',
		languages = {
			lua = {
				template = {
					annotation_convention = 'emmylua',
				},
			},
			python = {
				template = {
					annotation_convention = 'google_docstrings',
				},
			},
			rust = {
				template = {
					annotation_convention = 'rustdoc',
				},
			},
			javascript = {
				template = {
					annotation_convention = 'jsdoc',
				},
			},
			typescript = {
				template = {
					annotation_convention = 'tsdoc',
				},
			},
			typescriptreact = {
				template = {
					annotation_convention = 'tsdoc',
				},
			},
		},
	})
end

return M
