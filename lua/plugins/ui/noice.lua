local M = {}

function M.setup()
	return {
		'folke/noice.nvim', -- messages, cmdline and popupmenu
		event = { 'VimEnter' },
		requires = { "MunifTanjim/nui.nvim" },
		config = M.config,
	}
end

function M.config()
	require('noice').setup({
		cmdline = {
			enabled = true, -- enables the Noice cmdline UI
			view = 'cmdline', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
			opts = {}, -- global options for the cmdline. See section on views
			---@type table<string, CmdlineFormat>
			format = {
				-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
				-- view: (default is cmdline view)
				-- opts: any options passed to the view
				-- icon_hl_group: optional hl_group for the icon
				-- title: set to anything or empty string to hide
				cmdline = { pattern = '^:', icon = '', lang = 'vim' },
				search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
				search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
				filter = { pattern = '^:%s*!', icon = '', lang = 'bash' },
				lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
				help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
				input = {}, -- Used by input()
				-- lua = false, -- to disable a format, set to `false`
			},
		},
		messages = {
			enabled = true,     -- enables the Noice messages UI
			view = 'notify',    -- default view for messages
			view_error = 'notify', -- view for errors
			view_warn = 'notify', -- view for warnings
			view_history = 'messages', -- view for :messages
			view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
		},
		popupmenu = {
			enabled = true, -- enables the Noice popupmenu UI
			---@type 'nui'|'cmp'
			backend = 'nui', -- backend to use to show regular cmdline completions
			---@type NoicePopupmenuItemKind|false
			-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
			kind_icons = {}, -- set to `false` to disable icons
		},
		routes = {
			-- Skip Messages
			{
				opts = { skip = true },
				filter = {
					any = {
						{ event = 'msg_show', find = 'written' },
						{ event = 'msg_show', find = '%d+ lines, %d+ bytes' },
						{ event = 'msg_show', kind = 'search_count' },
						{ event = 'msg_show', find = '%d+L, %d+B' },
						{ event = 'msg_show', find = '^Hunk %d+ of %d' },
						{ event = 'msg_show', find = '%d+ change' },
						{ event = 'msg_show', find = '%d+ line' },
						{ event = 'msg_show', find = '%d+ more line' },
						{ event = 'notify',   find = 'No information available' },
						{ event = 'msg_show',   find = 'textDocument/foldingRange' }, -- erro no yaml
					},
				},
			},
			-- Warnings
			{
				view = 'notify',
				filter = {
					any = {
						{ warning = true },
						{ event = 'msg_show', find = '^Warn' },
						{ event = 'msg_show', find = '^W%d+:' },
						{ event = 'msg_show', find = '^No hunks$' },
					},
				},
				opts = { title = 'Warning', level = vim.log.levels.WARN, merge = false, replace = false },
			},
			-- Erros
			{
				view = 'notify',
				opts = { title = 'Error', level = vim.log.levels.ERROR, merge = true, replace = false },
				filter = {
					any = {
						{ error = true },
						{ event = 'msg_show', find = '^Error' },
						{ event = 'msg_show', find = '^E%d+:' },
					},
				},
			},
			-- minimise pattern not found messages
			{
				view = 'mini',
				filter = {
					any = {
						{ event = 'msg_show', find = '^E486:' },
						{ event = 'notify',   max_height = 1 },
					},
				},
			},
		},
		lsp = {
			progress = { enabled = false },
			override = {
				-- override the default lsp markdown formatter with Noice
				['vim.lsp.util.convert_input_to_markdown_lines'] = true,
				-- override the lsp markdown formatter with Noice
				['vim.lsp.util.stylize_markdown'] = true,
				-- override cmp documentation with Noice (needs the other options to work)
				['cmp.entry.get_documentation'] = true,
			},
			hover = {
				enabled = true,
				view = nil, -- when nil, use defaults from documentation
				---@type NoiceViewOptions
				opts = {}, -- merged with defaults from documentation
			},
			signature = {
				enabled = false,
				auto_open = {
					enabled = true,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				---@type NoiceViewOptions
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
			message = {
				-- Messages shown by lsp servers
				enabled = true,
				view = 'notify',
				opts = {},
			},
			-- defaults for hover and signature help
			documentation = {
				view = 'hover',
				---@type NoiceViewOptions
				opts = {
					lang = 'markdown',
					replace = true,
					render = 'plain',
					format = { '{message}' },
					win_options = { concealcursor = 'n', conceallevel = 3 },
				},
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false,  -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	})
end

M.highlights = {
	-- NoiceMini = { inherit = 'MsgArea', bg = { from = 'Normal' } },
	-- NoicePopupBaseGroup = { inherit = 'NormalFloat', fg = { from = 'DiagnosticSignInfo' } },
	-- NoicePopupWarnBaseGroup = { inherit = 'NormalFloat', fg = { from = 'Float' } },
	-- NoicePopupInfoBaseGroup = { inherit = 'NormalFloat', fg = { from = 'Conditional' } },
	-- NoiceCmdlinePopup = { bg = { from = 'NormalFloat' } },
	-- NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
	-- NoiceCmdlinePopupBorderCmdline = { link = 'NoicePopupBaseGroup' },
	-- NoiceCmdlinePopupBorderSearch = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlinePopupBorderFilter = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlinePopupBorderHelp = { link = 'NoicePopupInfoBaseGroup' },
	-- NoiceCmdlinePopupBorderSubstitute = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlinePopupBorderIncRename = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlinePopupBorderInput = { link = 'NoicePopupBaseGroup' },
	-- NoiceCmdlinePopupBorderLua = { link = 'NoicePopupBaseGroup' },
	-- NoiceCmdlineIconCmdline = { link = 'NoicePopupBaseGroup' },
	-- NoiceCmdlineIconSearch = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlineIconFilter = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlineIconHelp = { link = 'NoicePopupInfoBaseGroup' },
	-- NoiceCmdlineIconIncRename = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlineIconSubstitute = { link = 'NoicePopupWarnBaseGroup' },
	-- NoiceCmdlineIconInput = { link = 'NoicePopupBaseGroup' },
	-- NoiceCmdlineIconLua = { link = 'NoicePopupBaseGroup' },
	-- NoiceConfirm = { bg = { from = 'NormalFloat' } },
	-- NoiceConfirmBorder = { link = 'NoicePopupBaseGroup' },
}

return M
