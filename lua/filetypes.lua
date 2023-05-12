local settings = utils.ft_helpers.filetype_settings
local cmd, fn = vim.cmd, vim.fn

settings({
	chatgpt = {
		function() vim.treesitter.language.register('markdown', 'chatgpt') end,
	},
	checkhealth = { opt = { spell = false } },
	[{ 'gitcommit', 'gitrebase' }] = {
		bo = { bufhidden = 'delete' },
		opt = {
			list = false,
			spell = true,
			spelllang = 'en_gb',
		},
	},
	c = {
		bo = {
			tabstop = 2, -- number of columns occupied by a tab character
			shiftwidth = 2, -- width for autoindents
			softtabstop = 2, -- see multiple spaces as tabstops
		},
	},
	NeogitCommitMessage = {
		opt = {
			spell = true,
			spelllang = 'en_us',
			list = false,
		},
		plugins = {
			cmp = function(cmp)
				cmp.setup.filetype('NeogitCommitMessage', {
					sources = {
						{ name = 'git',        group_index = 1 },
						{ name = 'luasnip',    group_index = 1 },
						{ name = 'dictionary', group_index = 1 },
						{ name = 'spell',      group_index = 1 },
						{ name = 'buffer',     group_index = 2 },
					},
				})
			end,
		},
		function()
			vim.schedule(function()
				-- Schedule this call as highlights are not set correctly if there is not a delay
				-- highlight.set_winhl('gitcommit', 0, { { VirtColumn = { fg = { from = 'Variable' } } } })
			end)
			vim.treesitter.language.register('gitcommit', 'NeogitCommitMessage')
		end,
	},
	netrw = {
		g = {
			netrw_liststyle = 3,
			netrw_banner = 0,
			netrw_browse_split = 0,
			netrw_winsize = 25,
			netrw_altv = 1,
			netrw_fastbrowse = 0,
		},
		bo = { bufhidden = 'wipe' },
		mappings = {
			{ 'n', 'q',  '<Cmd>q<CR>' },
			{ 'n', 'ç', '<CR>' },
			{ 'n', 'j',  '<CR>' },
			{ 'n', 'o',  '<CR>' },
		},
	},
})
