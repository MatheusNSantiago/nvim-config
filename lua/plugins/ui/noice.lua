---@diagnostic disable: undefined-doc-name
local M = {}

function M.setup()
	return {
		'folke/noice.nvim', -- messages, cmdline and popupmenu
		dependencies = { 'MunifTanjim/nui.nvim' },
		event = 'VeryLazy',
		config = M.config,
	}
end

function M.config()
	require('noice').setup({
		cmdline = M.cmdline,
		lsp = M.lsp,
		presets = M.presets,
		routes = M.routes,
		messages = M.messages,
		---@type NoiceConfigViews
		views = {
			confirm = {
				backend = 'popup',
				relative = 'editor',
				focusable = false,
				align = 'center',
				enter = false,
				zindex = 210,
				format = { '{confirm}' },
				position = {
					row = 3,
					col = '50%',
				},
				size = 'auto',
				border = {
					style = 'rounded',
					padding = { 0, 1 },
					text = {
						top = ' Confirm ',
					},
				},
				win_options = {
					winhighlight = {
						Normal = 'NoiceConfirm',
						FloatBorder = 'NoiceConfirmBorder',
					},
					winbar = '',
					foldenable = false,
				},
			},
		}, ---@see section on views
	})
	--[[ require('noice').setup({
		popupmenu = {
			enabled = true, -- enables the Noice popupmenu UI
			---@type 'nui'|'cmp'
			backend = 'nui', -- backend to use to show regular cmdline completions
			---@type NoicePopupmenuItemKind|false
			-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
			kind_icons = {}, -- set to `false` to disable icons
		},
		-- default options for require('noice').redirect
		-- see the section on Command Redirection
		---@type NoiceRouteConfig
		redirect = {
			view = 'popup',
			filter = { event = 'msg_show' },
		},
		-- You can add any custom commands below that will be available with `:Noice command`
		---@type table<string, NoiceCommand>
		commands = {
			history = {
				-- options for the message history that you get with `:Noice`
				view = 'split',
				opts = { enter = true, format = 'details' },
				filter = {
					any = {
						{ event = 'notify' },
						{ error = true },
						{ warning = true },
						{ event = 'msg_show', kind = { '' } },
						{ event = 'lsp', kind = 'message' },
					},
				},
			},
			-- :Noice last
			last = {
				view = 'popup',
				opts = { enter = true, format = 'details' },
				filter = {
					any = {
						{ event = 'notify' },
						{ error = true },
						{ warning = true },
						{ event = 'msg_show', kind = { '' } },
						{ event = 'lsp', kind = 'message' },
					},
				},
				filter_opts = { count = 1 },
			},
			-- :Noice errors
			errors = {
				-- options for the message history that you get with `:Noice`
				view = 'popup',
				opts = { enter = true, format = 'details' },
				filter = { error = true },
				filter_opts = { reverse = true },
			},
			all = {
				-- options for the message history that you get with `:Noice`
				view = 'split',
				opts = { enter = true, format = 'details' },
				filter = {},
			},
		},
		notify = {
			-- Noice can be used as `vim.notify` so you can route any notification like other messages
			-- Notification messages have their level and other properties set.
			-- event is always "notify" and kind can be any log level as a string
			-- The default routes will forward notifications to nvim-notify
			-- Benefit of using Noice for this is the routing and consistent history view
			enabled = true,
			view = 'notify',
		},
		markdown = {
			hover = {
				-- ['|(%S-)|'] = vim.cmd.help, -- vim help links
				-- ['%[.-%]%((%S-)%)'] = require('noice.util').open, -- markdown links
			},
			highlights = {
				['|%S-|'] = '@text.reference',
				['@%S+'] = '@parameter',
				['^%s*(Parameters:)'] = '@text.title',
				['^%s*(Return:)'] = '@text.title',
				['^%s*(See also:)'] = '@text.title',
				['{%S-}'] = '@parameter',
			},
		},
		health = { checker = true }, -- Disable if you don't want health checks to run
		---@type NoicePresets
		throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
		---@type NoiceConfigViews
		views = {},
		---@type NoiceRouteConfig[]
		---@type table<string, NoiceFilter>
		status = {}, --- @see section on statusline components
		---@type NoiceFormatOptions
		format = {}, --- @see section on formatting
	}) ]]
end

M.cmdline = {
	enabled = true, -- enables the Noice cmdline UI
	view = 'cmdline', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
	opts = {}, -- global options for the cmdline. See section on views
	format = {
		-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
		-- view: (default is cmdline view)
		-- opts: any options passed to the view
		-- icon_hl_group: optional hl_group for the icon
		-- title: set to anything or empty string to hide
		cmdline = { pattern = '^:', icon = '', lang = 'vim' },
		search_down = { kind = 'search', pattern = '^/', icon = '  ', lang = 'regex' },
		search_up = { kind = 'search', pattern = '^%?', icon = '  ', lang = 'regex' },
		filter = { pattern = '^:%s*!', icon = '', lang = 'bash' },
		lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
		help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
		input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
	},
}

M.lsp = {
	progress = { enabled = false },
	-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	override = {
		['vim.lsp.util.convert_input_to_markdown_lines'] = true, -- override the default lsp markdown formatter with Noice
		['vim.lsp.util.stylize_markdown'] = true, -- override the lsp markdown formatter with Noice
		['cmp.entry.get_documentation'] = true, --       -- override cmp documentation with Noice (needs the other options to work)
	},
	hover = { enabled = true },
	signature = { enabled = false },
	message = { -- Messages shown by lsp servers
		enabled = true,
		view = 'notify',
		opts = {},
	},
}

M.presets = {
	bottom_search = false, -- use a classic bottom cmdline for search
	command_palette = false, -- position the cmdline and popupmenu together
	long_message_to_split = false, -- long messages will be sent to a split
	inc_rename = false, -- enables an input dialog for inc-rename.nvim
	lsp_doc_border = true, -- add a border to hover docs and signature help
}

M.routes = { -- Skip Messages
	{
		opts = { skip = true },
		filter = {
			any = {
				{ event = 'msg_show', find = '%d+L, %d+B written' }, -- ao salvar mudança
				{ event = 'msg_show', find = '%d+ changes?' }, -- undo/redo notifications
				{ event = 'notify', find = 'No information available' }, -- Ao dar hover em algo que não tem informação suficiente
				{ event = 'msg_show', find = 'press letter mark to preview, or press <esc> to quit' }, -- mensagem do marks.nvim para preview
				{ event = 'notify', find = 'ENOENT: no such file or directory' },
				{ event = 'msg_show', find = 'process.processTicksAndRejections' },
			},
		},
	},
	-- Warnings
	-- {
	--   view = 'notify',
	--   filter = {
	--     any = {
	--       { warning = true },
	--       { event = 'msg_show', find = '^Warn' },
	--       { event = 'msg_show', find = '^W%d+:' },
	--       { event = 'msg_show', find = '^No hunks$' },
	--     },
	--   },
	--   opts = { title = 'Warning', level = vim.log.levels.WARN, merge = false, replace = false },
	-- },
	-- Erros
	-- {
	--   view = 'notify',
	--   opts = { title = 'Error', level = vim.log.levels.ERROR, merge = true, replace = false },
	--   filter = {
	--     any = {
	--       { error = true },
	--       { event = 'msg_show', find = '^Error' },
	--       { event = 'msg_show', find = '^E%d+:' },
	--     },
	--   },
	-- },
	-- minimise pattern not found messages
	-- {
	--   view = 'mini',
	--   filter = {
	--     any = {
	--       { event = 'msg_show', find = '^E486:' },
	--       { event = 'notify',   max_height = 1 },
	--     },
	--   },
	-- },
}

M.highlights = {}

M.messages = {
	-- NOTE- If you enable messages, then the cmdline is enabled automatically.
	-- This is a current Neovim limitation.
	enabled = true, -- enables the Noice messages UI
	view = 'notify', -- default view for messages
	view_error = 'notify', -- view for errors
	view_warn = 'notify', -- view for warnings
	view_history = 'messages', -- view for :messages
	view_search = false, -- 'virtualtext' -- view for search count messages. Set to `false` to disable
}

return M
