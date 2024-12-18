local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'folke/snacks.nvim',
		priority = 1000,
		lazy = false,
		config = M.config,
		keys = {
			{ '<leader>nd', function() Snacks.notifier.hide() end, desc = 'snacks: Dismiss All Notifications' },
			{
				'<leader><leader>n',
				function() Snacks.notifier.show_history() end,
				desc = 'snacks: Dismiss All Notifications',
			},
			{ '<leader>lg', function() Snacks.lazygit() end, desc = 'snacks: [L]azy[G]it' },
			{ '<leader>gb', function() Snacks.git.blame_line() end, desc = 'snacks: [G]it [B]lame Line' },
			{ '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'snacks: [G]it [F]ile History' },
		},
		init = function()
			vim.api.nvim_create_autocmd('User', {
				pattern = 'VeryLazy',
				callback = function()
					_G.log = function(...) Snacks.debug.inspect(...) end
					_G.bt = function() Snacks.debug.backtrace() end
					vim.print = _G.log -- Override print to use snacks for `:=` command
				end,
			})
		end,
	}
end

function M.config()
	require('snacks').setup({
		bigfile = {
			enabled = true,
			notify = true, -- show notification when big file detected
			size = 300 * 1024, -- 300KB
			setup = function()
				vim.b.minianimate_disable = true
				vim.cmd('IlluminatePause')
			end,
		},
		notifier = { ---@see https://github.com/folke/snacks.nvim/blob/main/docs/notifier.md
			enabled = true,
			timeout = 3000, -- default timeout in ms
			margin = { top = 0, right = 1, bottom = 0 },
			padding = false, -- add 1 cell of left/right padding to the notification window
			icons = { error = ' ', warn = ' ', info = ' ', debug = ' ', trace = ' ' },
		},
		lazygit = {
			-- automatically configure lazygit to use the current colorscheme
			configure = true,
			-- extra configuration for lazygit that will be merged with the default
			-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
			-- you need to double quote it: `"\"test\""`
			config = { os = { editPreset = 'nvim-remote' }, gui = { nerdFontsVersion = '3' } },
			theme_path = vim.fs.normalize(vim.fn.stdpath('cache') .. '/lazygit-theme.yml'),
			theme = {
				[241] = { fg = 'Directory' },
				activeBorderColor = { fg = 'MatchParen', bold = true },
				cherryPickedCommitBgColor = { fg = 'Identifier' },
				cherryPickedCommitFgColor = { fg = 'Function' },
				defaultFgColor = { fg = 'Normal' },
				inactiveBorderColor = { fg = 'FloatBorder' },
				optionsTextColor = { fg = 'Function' },
				searchingActiveBorderColor = { fg = 'MatchParen', bold = true },
				selectedLineBgColor = { bg = 'Visual' }, -- set to `default` to have no background colour
				unstagedChangesColor = { fg = 'DiagnosticError' },
			},
			win = { style = 'lazygit' },
		},
		--  ╾───────────────────────────────────────────────────────────────────────────────────╼
		-- When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins.
		quickfile = { enabled = false },
		dashboard = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
	})
end

return M

-- local M = {}
--
-- function M.setup()
-- 	return { ---@type LazyPluginSpec
-- 		'LunarVim/bigfile.nvim',
-- 		config = M.config,
-- 	}
-- end
--
-- function M.config()
-- 	require('bigfile').setup({
-- 		filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
-- 		pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
-- 		features = { -- features to disable
-- 			'indent_blankline',
-- 			'illuminate',
-- 			'lsp',
-- 			'treesitter',
-- 			'syntax',
-- 			'matchparen',
-- 			'vimopts',
-- 			'filetype',
-- 		},
-- 	})
-- end
--
-- return M
