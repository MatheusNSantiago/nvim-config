local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'saghen/blink.cmp',
		config = M.config,
		event = 'InsertEnter',
		version = '*',
	}
end

function M.config()
	local kind_icons = U.icons.lspkind

	-- U.api.augroup('blink_cmp_multi_cursor_fix', {
	-- 	desc = 'Conserta o problema das mappings sumirem após sair do multicursor mode',
	-- 	event = 'User',
	-- 	pattern = 'BlinkCmpMenuOpen',
	-- 	command = function(_)
	-- 		-- O blink checa se ele já setou mappings para não dar retrabalho
	--
	-- 		-- Deleta as keymaps existentes do blink
	-- 		local curr_buf_keymaps = vim.api.nvim_buf_get_keymap(0, 'i')
	-- 		for _, map in ipairs(curr_buf_keymaps) do
	-- 			if map.desc == 'blink.cmp' then --
	-- 				vim.api.nvim_buf_del_keymap(0, 'i', map['lhs'])
	-- 			end
	-- 		end
	--
	-- 		-- Aplica mappings
	-- 		local mappings = require('plugins.dev.blink.mappings')
	-- 		require('blink.cmp.keymap.apply').keymap_to_current_buffer(mappings)
	-- 	end,
	-- })

	require('blink.cmp').setup({
		keymap = require('plugins.dev.blink.mappings'),
		enabled = function()
			local blacklist = { 'DressingInput', 'sagarename' }
			return not vim.tbl_contains(blacklist, vim.bo.filetype)
				and vim.bo.buftype ~= 'prompt'
				and vim.b['completion'] ~= false
		end,

		cmdline = {
			keymap = {
				preset = 'super-tab',
				['<C-l>'] = { 'select_prev', 'fallback' },
				['<C-k>'] = { 'select_next', 'fallback' },
			},
			completion = { menu = { auto_show = true } },
			sources = function()
				local type = vim.fn.getcmdtype()
				if type == '/' or type == '?' then return { 'buffer' } end
				if type == ':' or type == '@' then return { 'cmdline' } end
				return {}
			end,
		},

		snippets = {
			expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
			active = function(filter)
				if filter and filter.direction then return require('luasnip').jumpable(filter.direction) end
				return require('luasnip').in_snippet()
			end,
			jump = function(direction) require('luasnip').jump(direction) end,
		},

		completion = {
			trigger = {
				-- Retorna vazio no cmdline para não conflitar com o preset do cmdline
				show_on_blocked_trigger_characters = function()
					if vim.api.nvim_get_mode().mode == 'c' then return {} end
					return { ' ', '\n', '\t' }
				end,
				-- Default inclui '[', removido intencionalmente
				show_on_x_blocked_trigger_characters = { "'", '"', '(', '{' },
			},
			list = {
				selection = { auto_insert = false }, -- default é true
			},
			accept = {
				auto_brackets = {
					kind_resolution = {
						blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue', 'cobol' },
					},
					semantic_token_resolution = {
						blocked_filetypes = {}, -- default é { 'java' }
					},
				},
			},
			menu = {
				border = 'single', -- default é nil
				draw = {
					treesitter = { 'lsp' }, -- default é {}
				},
			},
			documentation = {
				auto_show = true,        -- default é false
				auto_show_delay_ms = 50, -- default é 500
				window = {
					max_width = 60, -- default é 80
					border = 'single', -- default é nil
					winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
				},
			},
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
			per_filetype = {
				codecompanion = { 'codecompanion' },
			},
			transform_items = function(_, items)
				for _, item in ipairs(items) do
					if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
						item.score_offset = item.score_offset - 3
					end
				end
				return items
			end,
			providers = {
				lsp = {
					transform_items = function(ctx, items)
						return vim.tbl_filter(function(item) --
							-- return lsp_entry_filter(entry, ctx, handler?)
							return true
							-- return item.kind == require('blink.cmp.types').CompletionItemKind.Text
						end, items)
					end,
				},
				path = {
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					opts = {
						friendly_snippets = true,
						search_paths = { vim.fn.stdpath('config') .. '/snippets' },
						global_snippets = { 'all' },
						extended_filetypes = {},
						ignored_filetypes = {},
					},
				},
				buffer = {
					opts = {
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
					score_offset = 100,
				},
			},
		},

		appearance = {
			kind_icons = {
				Text = kind_icons.Text,
				Method = kind_icons.Method,
				Function = kind_icons.Function,
				Constructor = kind_icons.Constructor,

				Field = kind_icons.Field,
				Variable = kind_icons.Variable,
				Property = kind_icons.Property,

				Class = kind_icons.Class,
				Interface = kind_icons.Interface,
				Struct = kind_icons.Struct,
				Module = kind_icons.Module,

				Unit = kind_icons.Unit,
				Value = kind_icons.Value,
				Enum = kind_icons.Enum,
				EnumMember = kind_icons.EnumMember,

				Keyword = kind_icons.Keyword,
				Constant = kind_icons.Constant,

				Snippet = kind_icons.Snippet,
				Color = kind_icons.Color,
				File = kind_icons.File,
				Reference = kind_icons.Reference,
				Folder = kind_icons.Folder,
				Event = kind_icons.Event,
				Operator = kind_icons.Operator,
				TypeParameter = kind_icons.TypeParameter,
			},
		},
	})
end

M.highlights = {
	['BlinkCmpMenu'] = { fg = '#C792EA', bg = c.transparent }, -- The completion menu window
	['BlinkCmpMenuBorder'] = { fg = '#488dff' }, -- The completion menu window border
	['BlinkCmpMenuSelection'] = { link = 'PmenuSel' }, -- The completion menu window selected item
	['BlinkCmpScrollBarThumb'] = { link = 'NormalFloat' }, -- The scrollbar thumb
	['BlinkCmpScrollBarGutter'] = { link = 'NormalFloat' }, -- The scrollbar gutter
	['BlinkCmpLabel'] = { bg = c.transparent, fg = c.white }, -- Label of the completion item
	['BlinkCmpLabelDeprecated'] = { link = 'Comment' }, -- Deprecated label of the completion item
	['BlinkCmpLabelMatch'] = { fg = c.secondary, bg = c.transparent }, -- Label of the completion item when it matches the query
	['BlinkCmpLabelDetail'] = { fg = c.gray }, -- Label description of the completion item
	['BlinkCmpLabelDescription'] = { fg = '#C792EA', bg = c.transparent }, -- Label description of the completion item
	['BlinkCmpKind'] = { link = 'Special' }, -- Kind icon/text of the completion item
	['BlinkCmpSource'] = { fg = c.gray }, -- Source of the completion item
	['BlinkCmpGhostText'] = { fg = c.gray }, -- Preview item with ghost text
	['BlinkCmpDoc'] = { link = 'NormalFloat' }, -- The documentation window
	['BlinkCmpDocBorder'] = { fg = '#488dff' }, -- The documentation window border
	['BlinkCmpDocSeparator'] = { link = 'NormalFloat' }, -- The documentation separator between doc and detail
	['BlinkCmpDocCursorLine'] = { link = 'Visual' }, -- The documentation window cursor line
}
return M
