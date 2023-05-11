local M = {}
function M.setup()
	return {
		'hrsh7th/nvim-cmp',
		config = M.config,
	}
end

function M.config()
	local cmp = require('cmp')
	local types = require('cmp.types.cmp')

	local lspkind = require('lspkind')
	local luasnip = require('luasnip')

	cmp.setup({
		snippet = {
			expand = function(args)
				local body = args.body:gsub('%b()', '(${1})') -- remove tudo entre os parenteses
				luasnip.lsp_expand(body)
			end,
		},
		mapping = require('plugins.cmp.mappings'),
		sources = cmp.config.sources({
			{
				name = 'nvim_lsp',
				priority = 1000,
				-- max_item_count = 10,
				entry_filter = require('plugins.cmp.utils.limit_lsp_types'),
				group_index = 1,
			},
			{
				name = 'copilot',
				priority = 1000,
				keyword_length = 0,
				group_index = 1,
			},
			{
				name = 'luasnip',
				priority = 750,
				max_item_count = 5,
				keyword_length = 2,
				group_index = 1,
			},
			{
				name = 'buffer',
				priority = 500,
				keyword_length = 4,
				max_item_count = 5,
				group_index = 2,
			},
			{
				name = 'path',
				priority = 250,
				max_item_count = 4,
				group_index = 1,
			},
		}),
		duplicates = {
			buffer = 1,
			path = 1,
			nvim_lsp = 0,
			luasnip = 0,
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				require('copilot_cmp.comparators').prioritize,
				-- require('plugins.cmp.utils.comparators').deprioritize_snippet,
				require('cmp-under-comparator').under,
				-- cmp.config.compare.kind,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.offset,
				cmp.config.compare.sort_text,
				cmp.config.compare.order,
			},
		},
		formatting = {
			fields = { 'kind', 'abbr', 'menu' },
			format = lspkind.cmp_format({
				mode = 'symbol',
				max_width = 50,
				symbol_map = require('utils.icons').lspkind,
				before = function(entry, vim_item)
					vim_item.dup = ({ nvim_lsp = 0, path = 0 })[entry.source.name] or 0

					if vim_item.kind == 'Color' and entry.completion_item.documentation then
						vim_item = require('plugins.cmp.utils.custom_formats').format_tailwind(entry, vim_item) -- for tailwind css autocomplete
					end

					if vim.tbl_contains({ 'path' }, entry.source.name) then
						local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
						if icon then
							vim_item.kind = icon
							vim_item.kind_hl_group = hl_group
							return vim_item
						end
					end
					return vim_item
				end,
			}),
		},
		confirm_opts = {
			behavior = types.ConfirmBehavior.Replace,
			select = true, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = 'Normal:TelescopeNormal,FloatBorder:TelescopeBorder',
				border = 'rounded',
				col_offset = -3,
				side_padding = 1,
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = 'Normal:TelescopeNormal,FloatBorder:TelescopeBorder',
			}),
		},
		preselect = cmp.PreselectMode.Item,
		view = { entries = 'custom' }, -- can be "custom", "wildmenu" or "native"
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'conventionalcommits' },
		}, { { name = 'buffer' } }),
	})

	require('plugins.cmp.copilot').setup()
	require('plugins.cmp.cmdline').setup()
end

local c = require('utils.colors')
M.highlights = {
	CmpItemAbbrDeprecated = { fg = '#7E8294', bg = 'NONE', strikethrough = true },
	CmpItemAbbrMatch = { fg = c.secondary, bg = 'NONE', bold = true },
	CmpItemAbbrMatchFuzzy = { fg = c.secondary, bg = 'NONE', bold = true },
	CmpItemMenu = { fg = '#C792EA', bg = 'NONE', italic = true },
	CmpItemKindColor = { fg = '#D8EEEB', bg = 'None' },
	CmpItemKindTypeParameter = { fg = '#D8EEEB', bg = 'None' },
	CmpItemAbbr = { fg = 'White', bg = 'NONE' },
	CmpItemKindText = { fg = 'LightGrey' },
	CmpItemKindFunction = { fg = '#C586C0' },
	CmpItemKindClass = { fg = 'Orange' },
	CmpItemKindKeyword = { fg = '#f90c71' },
	CmpItemKindSnippet = { fg = '#565c64' },
	CmpItemKindConstructor = { fg = '#ae43f0' },
	CmpItemKindVariable = { fg = '#9CDCFE', bg = 'NONE' },
	CmpItemKindInterface = { fg = '#f90c71', bg = 'NONE' },
	CmpItemKindFolder = { fg = '#2986cc' },
	CmpItemKindReference = { fg = '#922b21' },
	CmpItemKindMethod = { fg = '#C586C0' },
	CmpItemKindCopilot = { fg = '#6CC644' },
}

return M
