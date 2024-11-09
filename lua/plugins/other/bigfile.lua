local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'LunarVim/bigfile.nvim',
		config = M.config,
	}
end

function M.config()
	require('bigfile').setup({
		filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
		pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
		features = { -- features to disable
			'indent_blankline',
			'illuminate',
			'lsp',
			'treesitter',
			'syntax',
			'matchparen',
			'vimopts',
			'filetype',
		},
	})
end

return M
