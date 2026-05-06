local M = {}

function M.setup()
	return {
		'nvim-treesitter/nvim-treesitter',
		tag = 'v0.9.3',
		build = ':TSUpdate',
		event = { 'BufReadPost', 'BufNewFile' },
		config = M.config,
	}
end

function M.config()
	local ts = require('nvim-treesitter.configs')

	local disable = { 'cobol', 'foo' }

	ts.setup({
		ensure_installed = {
			'vim',
			'vimdoc',
			'bash',
			'regex',
			'javascript',
			'typescript',
			'prisma',
			'ruby',
			'tsx',
			'python',
			'dart',
			'json',
			'html',
			'lua',
			'css',
			'scss',
			'toml',
			'fish',
			'jsdoc',
			'yaml',
		},
		auto_install = true,
		refactor = {
			highlight_definitions = { enable = true, disable = disable },
			highlight_current_scope = { enable = true, disable = disable },
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<C-space>',
				node_incremental = '<C-space>',
				scope_incremental = false,
				node_decremental = '<BS>',
			},
		},
		highlight = {
			enable = true,
			disable = function(lang, buf)
				local max_filesize = (1 * 1024) * 1024 -- 1 MB
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then return true end
			end,
			additional_vim_regex_highlighting = disable,
		},
		textobjects = {
			select = {
				enable = true,
				disable = { 'cobol', 'javascript' },
				lookahead = true,
				keymaps = {
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
					['iB'] = '@block.inner',
					['aB'] = '@block.outer',
				},
				include_surrounding_whitespace = false,
			},
			move = {
				enable = true,
				disable = disable,
				set_jumps = true,
				goto_next_start = {
					[']f'] = '@function.outer',
					[']c'] = '@class.outer',
				},
				goto_previous_start = {
					['[f'] = '@function.outer',
					['[c'] = '@class.outer',
				},
				goto_next_end = {
					[']F'] = '@function.outer',
					[']C'] = '@class.outer',
				},
				goto_previous_end = {
					['[F'] = '@function.outer',
					['[C'] = '@class.outer',
				},
			},
			swap = { enable = false, swap_next = {} },
		},
		matchup = { enable = true, disable_virtual_text = true, disable = { 'python', 'cobol', 'foo' } },
		endwise = { enable = true, disable = disable },
	})
end

return M
