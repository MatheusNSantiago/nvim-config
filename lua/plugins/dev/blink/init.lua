local M = {}

function M.setup()
	return {
		'saghen/blink.cmp',
		config = M.config,
		event = 'InsertEnter',
		version = '*',
	}
end

function M.config()
	local kind_icons = U.icons.lspkind

	U.api.augroup('blink_cmp_multi_cursor_fix', {
		desc = 'Conserta o problema das mappings sumirem após sair do multicursor mode',
		event = 'User',
		pattern = 'BlinkCmpMenuOpen',
		command = function(_)
			-- O blink checa se ele já setou mappings para não dar retrabalho

			-- Deleta as keymaps existentes do blink
			local curr_buf_keymaps = vim.api.nvim_buf_get_keymap(0, 'i')
			for _, map in ipairs(curr_buf_keymaps) do
				if map.desc == 'blink.cmp' then --
					vim.api.nvim_buf_del_keymap(0, 'i', map['lhs'])
				end
			end

			-- Aplica mappings
			local mappings = require('plugins.dev.blink.mappings')
			require('blink.cmp.keymap.apply').keymap_to_current_buffer(mappings)
		end,
	})

	require('blink.cmp').setup({
		keymap = require('plugins.dev.blink.mappings'),
		enabled = function()
			local blacklist = { 'DressingInput', 'sagarename' }
			return not vim.tbl_contains(blacklist, vim.bo.filetype)
				and vim.bo.buftype ~= 'prompt'
				and vim.b['completion'] ~= false
		end,

		snippets = {
			-- -- Function to use when expanding LSP provided snippets
			-- expand = function(snippet) vim.snippet.expand(snippet) end,
			expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
			-- -- Function to use when checking if a snippet is active
			-- active = function(filter) return vim.snippet.active(filter) end,
			active = function(filter)
				if filter and filter.direction then return require('luasnip').jumpable(filter.direction) end
				return require('luasnip').in_snippet()
			end,
			-- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
			-- jump = function(direction) vim.snippet.jump(direction) end,
			jump = function(direction) require('luasnip').jump(direction) end,
		},

		completion = {
			-- keyword = {
			-- 	-- 'prefix' will fuzzy match on the text before the cursor
			-- 	-- 'full' will fuzzy match on the text before *and* after the cursor
			-- 	-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			-- 	range = 'prefix',
			-- 	-- Regex used to get the text when fuzzy matching
			-- 	regex = '[-_]\\|\\k',
			-- 	-- After matching with regex, any characters matching this regex at the prefix will be excluded
			-- 	exclude_from_prefix_regex = '[\\-]',
			-- },

			trigger = {
				-- When true, will prefetch the completion items when entering insert mode
				prefetch_on_insert = false,
				-- When false, will not show the completion window automatically when in a snippet
				show_in_snippet = true,
				-- When true, will show the completion window after typing a character that matches the `keyword.regex`
				show_on_keyword = true,
				-- When true, will show the completion window after typing a trigger character
				show_on_trigger_character = true,
				-- LSPs can indicate when to show the completion window via trigger characters
				-- however, some LSPs (i.e. tsserver) return characters that would essentially
				-- always show the window. We block these by default.
				show_on_blocked_trigger_characters = function()
					if vim.api.nvim_get_mode().mode == 'c' then return {} end

					-- you can also block per filetype, for example:
					-- if vim.bo.filetype == 'markdown' then
					--   return { ' ', '\n', '\t', '.', '/', '(', '[' }
					-- end

					return { ' ', '\n', '\t' }
				end,
				-- When both this and show_on_trigger_character are true, will show the completion window
				-- when the cursor comes after a trigger character after accepting an item
				show_on_accept_on_trigger_character = true,
				-- When both this and show_on_trigger_character are true, will show the completion window
				-- when the cursor comes after a trigger character when entering insert mode
				show_on_insert_on_trigger_character = true,
				-- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
				-- the completion window when the cursor comes after a trigger character when
				-- entering insert mode/accepting an item
				show_on_x_blocked_trigger_characters = { "'", '"', '(', '{' },
				-- or a function, similar to show_on_blocked_trigger_character
			},

			list = {
				-- Maximum number of items to display
				max_items = 200,
				-- Controls if completion items will be selected automatically,
				-- and whether selection automatically inserts
				selection = {
					preselect = true,
					auto_insert = true,
				},
				cycle = {
					-- When `true`, calling `select_next` at the *bottom* of the completion list
					-- will select the *first* completion item.
					from_bottom = true,
					-- When `true`, calling `select_prev` at the *top* of the completion list
					-- will select the *last* completion item.
					from_top = true,
				},
			},

			accept = {
				-- Create an undo point when accepting a completion item
				create_undo_point = true,
				-- Experimental auto-brackets support
				auto_brackets = {
					-- Whether to auto-insert brackets for functions
					enabled = true,
					-- Default brackets to use for unknown languages
					default_brackets = { '(', ')' },
					-- Overrides the default blocked filetypes
					override_brackets_for_filetypes = {},
					-- Synchronously use the kind of the item to determine if brackets should be added
					kind_resolution = {
						enabled = true,
						blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue', 'cobol' },
					},
					-- Asynchronously use semantic token to determine if brackets should be added
					semantic_token_resolution = {
						enabled = true,
						blocked_filetypes = {},
						-- How long to wait for semantic tokens to return before assuming no brackets should be added
						timeout_ms = 400,
					},
				},
			},

			menu = {
				enabled = true,
				min_width = 15,
				max_height = 10,
				border = 'rounded',
				winblend = 0,
				winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
				-- Keep the cursor X lines away from the top/bottom of the window
				scrolloff = 2,
				-- Note that the gutter will be disabled when border ~= 'none'
				scrollbar = true,
				-- Which directions to show the window,
				-- falling back to the next direction when there's not enough space
				direction_priority = { 's', 'n' },

				-- Whether to automatically show the window when new completion items are available
				auto_show = true,

				-- Screen coordinates of the command line
				cmdline_position = function()
					if vim.g.ui_cmdline_pos ~= nil then
						local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
						return { pos[1] - 1, pos[2] }
					end
					local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
					return { vim.o.lines - height, 0 }
				end,

				-- Controls how the completion items are rendered on the popup window
				draw = {
					-- Aligns the keyword you've typed to a component in the menu
					-- align_to_component = 'label', -- or 'none' to disable
					-- Left and right padding, optionally { left, right } for different padding on each side
					padding = 1,
					-- Gap between columns
					gap = 1,
					-- Use treesitter to highlight the label text of completions from these sources
					-- treesitter = {},
					-- Recommended to enable it just for the LSP source
					treesitter = { 'lsp' },

					-- Components to render, grouped by column
					columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
					-- for a setup similar to nvim-cmp: https://github.com/Saghen/blink.cmp/pull/245#issuecomment-2463659508
					-- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },

					-- Definitions for possible components to render. Each component defines:
					--   ellipsis: whether to add an ellipsis when truncating the text
					--   width: control the min, max and fill behavior of the component
					--   text function: will be called for each item
					--   highlight function: will be called only when the line appears on screen
					components = {

						kind_icon = {
							ellipsis = false,
							text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
							highlight = function(ctx)
								return (require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx) or 'BlinkCmpKind')
									.. ctx.kind
							end,
						},
						kind = {
							ellipsis = false,
							width = { fill = true },
							text = function(ctx) return ctx.kind end,
							highlight = function(ctx)
								return (require('blink.cmp.completion.windows.render.tailwind').get_hl(ctx) or 'BlinkCmpKind')
									.. ctx.kind
							end,
						},

						label = {
							width = { fill = true, max = 60 },
							text = function(ctx) return ctx.label .. ctx.label_detail end,
							highlight = function(ctx)
								-- label and label details
								local highlights = {
									{ 0, #ctx.label, group = ctx.deprecated and 'BlinkCmpLabelDeprecated' or 'BlinkCmpLabel' },
								}
								if ctx.label_detail then
									table.insert(
										highlights,
										{ #ctx.label, #ctx.label + #ctx.label_detail, group = 'BlinkCmpLabelDetail' }
									)
								end

								-- characters matched on the label by the fuzzy matcher
								for _, idx in ipairs(ctx.label_matched_indices) do
									table.insert(highlights, { idx, idx + 1, group = 'BlinkCmpLabelMatch' })
								end

								return highlights
							end,
						},

						label_description = {
							width = { max = 30 },
							text = function(ctx) return ctx.label_description end,
							highlight = 'BlinkCmpLabelDescription',
						},

						source_name = {
							width = { max = 30 },
							text = function(ctx) return ctx.source_name end,
							highlight = 'BlinkCmpSource',
						},
					},
				},
			},

			documentation = {
				-- Controls whether the documentation window will automatically show when selecting a completion item
				auto_show = true,
				-- Delay before showing the documentation window
				auto_show_delay_ms = 50,
				-- Delay before updating the documentation window when selecting a new item,
				-- while an existing item is still visible
				update_delay_ms = 50,
				-- Whether to use treesitter highlighting, disable if you run into performance issues
				treesitter_highlighting = true,
				window = {
					min_width = 10,
					max_width = 60,
					max_height = 20,
					border = 'rounded',
					winblend = 0,
					winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
					-- Note that the gutter will be disabled when border ~= 'none'
					scrollbar = true,
					-- Which directions to show the documentation window,
					-- for each of the possible menu window directions,
					-- falling back to the next direction when there's not enough space
					direction_priority = {
						menu_north = { 'e', 'w', 'n', 's' },
						menu_south = { 'e', 'w', 's', 'n' },
					},
				},
			},
			-- Displays a preview of the selected item on the current line
			ghost_text = { enabled = false },
		},

		-- Experimental signature help support
		signature = { enabled = false },

		fuzzy = {
			max_typos = function(keyword) return math.floor(#keyword / 4) end,
			use_frecency = true,
			use_proximity = true,
			use_unsafe_no_lock = false,
			sorts = { 'score', 'sort_text' },
			prebuilt_binaries = {
				download = true,
				ignore_version_mismatch = false,
				force_version = nil,
				force_system_triple = nil,
				extra_curl_args = {},
				proxy = { from_env = true, url = nil },
			},
		},

		sources = {
			-- Static list of providers to enable, or a function to dynamically enable/disable providers based on the context
			default = {
				'lsp',
				'path',
				'snippets',
				-- 'luasnip',
				'buffer',
				'lazydev',
			},
			-- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
			providers = {
				lsp = {
					name = 'LSP',
					module = 'blink.cmp.sources.lsp',
					-- Filter out text items from the LSP provider, since we have the buffer provider for that
					-- transform_items = function(_, items)
					-- 	return vim.tbl_filter(
					-- 		function(item) return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text end,
					-- 		items
					-- 	)
					-- end,
					--- *All* providers have the following options available
					--- NOTE- All of these options may be functions to get dynamic behavior
					--- See the type definitions for more information.
					enabled = true, -- Whether or not to enable the provider
					async = false, -- Whether we should wait for the provider to return before showing the completions
					timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
					transform_items = nil, -- Function to transform the items before they're returned
					should_show_items = true, -- Whether or not to show the items
					max_items = nil, -- Maximum number of items to display in the menu
					min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
					-- If this provider returns 0 items, it will fallback to these providers.
					-- If multiple providers falback to the same provider, all of the providers must return 0 items for it to fallback
					fallbacks = { 'buffer' },
					score_offset = 0, -- Boost/penalize the score of the items
					override = nil, -- Override the source's functions
				},
				path = {
					name = 'Path',
					module = 'blink.cmp.sources.path',
					score_offset = 3,
					fallbacks = { 'buffer' },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					name = 'Snippets',
					module = 'blink.cmp.sources.snippets',
					opts = {
						friendly_snippets = true,
						search_paths = { vim.fn.stdpath('config') .. '/snippets' },
						global_snippets = { 'all' },
						extended_filetypes = {},
						ignored_filetypes = {},
						-- get_filetype = function(context) return vim.bo.filetype end,
					},
					--- Example usage for disabling the snippet provider after pressing trigger characters (i.e. ".")
					-- enabled = function(ctx)
					--   return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter
					-- end,
				},
				-- luasnip = {
				-- 	name = 'Luasnip',
				-- 	module = 'blink.cmp.sources.luasnip',
				-- 	opts = {
				-- 		use_show_condition = true, -- Whether to use show_condition for filtering snippets
				-- 		show_autosnippets = true, -- Whether to show autosnippets in the completion list
				-- 	},
				-- },
				buffer = {
					name = 'Buffer',
					module = 'blink.cmp.sources.buffer',
					opts = {
						-- default to all visible buffers
						get_bufnrs = function()
							return vim
								.iter(vim.api.nvim_list_wins())
								:map(function(win) return vim.api.nvim_win_get_buf(win) end)
								:filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
								:totable()
						end,
					},
				},
				lazydev = {
					name = 'LazyDev',
					module = 'lazydev.integrations.blink',
					score_offset = 100, -- show at a higher priority than lsp
				},
			},
			-- Example dynamically picking providers based on the filetype and treesitter node:
			-- providers = function(_)
			-- local node = vim.treesitter.get_node()
			-- if vim.bo.filetype == 'lua' then
			--   return { 'lsp', 'path' }
			-- elseif node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
			--   return { 'buffer' }
			-- else
			--   return { 'lsp', 'path', 'snippets', 'buffer' }
			-- end
			-- end,

			-- You may also define providers per filetype
			per_filetype = {
				-- lua = { 'lsp', 'path' },
			},

			-- By default, we choose providers for the cmdline based on the current cmdtype
			-- You may disable cmdline completions by replacing this with an empty table
			cmdline = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == '/' or type == '?' then return { 'buffer' } end
				-- Commands
				if type == ':' then return { 'cmdline' } end
				return {}
			end,

			-- Function to use when transforming the items before they're returned for all providers
			-- The default will lower the score for snippets to sort them lower in the list
			transform_items = function(_, items)
				for _, item in ipairs(items) do
					if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
						item.score_offset = item.score_offset - 3
					end
				end
				return items
			end,
			-- Minimum number of characters in the keyword to trigger all providers
			-- May also be `function(ctx: blink.cmp.Context): number`
			min_keyword_length = 0,
			-- Example for setting a minimum keyword length for markdown files
			-- min_keyword_length = function()
			--   return vim.bo.filetype == 'markdown' and 2 or 0
			-- end,
		},

		appearance = {
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono',
			kind_icons = {
				Text = kind_icons.Text, -- '󰉿',
				Method = kind_icons.Method, -- '󰊕',
				Function = kind_icons.Function, -- '󰊕',
				Constructor = kind_icons.Constructor, -- '󰒓',

				Field = kind_icons.Field, -- '󰜢',
				Variable = kind_icons.Variable, -- '󰆦',
				Property = kind_icons.Property, -- '󰖷',

				Class = kind_icons.Class, -- '󱡠',
				Interface = kind_icons.Interface, -- '󱡠',
				Struct = kind_icons.Struct, -- '󱡠',
				Module = kind_icons.Module, -- '󰅩',

				Unit = kind_icons.Unit, -- '󰪚',
				Value = kind_icons.Value, -- '󰦨',
				Enum = kind_icons.Enum, -- '󰦨',
				EnumMember = kind_icons.EnumMember, -- '󰦨',

				Keyword = kind_icons.Keyword, -- '󰻾',
				Constant = kind_icons.Constant, -- '󰏿',

				Snippet = kind_icons.Snippet, -- '󱄽',
				Color = kind_icons.Color, -- '󰏘',
				File = kind_icons.File, -- '󰈔',
				Reference = kind_icons.Reference, -- '󰬲',
				Folder = kind_icons.Folder, -- '󰉋',
				Event = kind_icons.Event, -- '󱐋',
				Operator = kind_icons.Operator, -- '󰪚',
				TypeParameter = kind_icons.TypeParameter, -- '󰬛',
			},
		},
	})
end

M.highlights = {
	['BlinkCmpMenu'] = { fg = '#C792EA', bg = 'NONE' }, -- The completion menu window
	['BlinkCmpMenuBorder'] = { fg = '#488dff' }, -- The completion menu window border
	['BlinkCmpMenuSelection'] = { link = 'PmenuSel' }, -- The completion menu window selected item
	['BlinkCmpScrollBarThumb'] = { link = 'NormalFloat' }, -- The scrollbar thumb
	['BlinkCmpScrollBarGutter'] = { link = 'NormalFloat' }, -- The scrollbar gutter
	['BlinkCmpLabel'] = { bg = 'NONE', fg = c.white }, -- Label of the completion item
	['BlinkCmpLabelDeprecated'] = { link = 'Comment' }, -- Deprecated label of the completion item
	['BlinkCmpLabelMatch'] = { fg = c.secondary, bg = 'NONE' }, -- (Currently unused) Label of the completion item when it matches the query
	['BlinkCmpLabelDetail'] = { link = 'NonText' }, -- Label description of the completion item
	['BlinkCmpLabelDescription'] = { fg = '#C792EA', bg = 'NONE' }, -- Label description of the completion item
	['BlinkCmpKind'] = { link = 'Special' }, -- Kind icon/text of the completion item
	['BlinkCmpSource'] = { link = 'NonText' }, -- Source of the completion item
	['BlinkCmpGhostText'] = { link = 'NonText' }, -- Preview item with ghost text
	['BlinkCmpDoc'] = { link = 'NormalFloat' }, -- The documentation window
	['BlinkCmpDocBorder'] = { fg = '#488dff' }, -- The documentation window border
	['BlinkCmpDocSeparator'] = { link = 'NormalFloat' }, -- The documentation separator between doc and detail
	['BlinkCmpDocCursorLine'] = { link = 'Visual' }, -- The documentation window cursor line
}
return M
