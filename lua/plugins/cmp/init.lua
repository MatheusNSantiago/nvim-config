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
	local get_mappings = require('plugins.cmp.mappings')
	local lspkind = require('lspkind')
	local lspkind_icons = utils.icons.lspkind
	local luasnip = require('luasnip')
	local web_devicons = require('nvim-web-devicons')
	local lsp_entry_filter = require('plugins.cmp.lsp-entry-filter')

	local default_config = {
		snippet = {
			expand = function(args)
				local body = args.body

				local is_already_instanced = utils.current_line_matches('█%s*%(')
				-- Imagem que a função é: func(arg1, arg2, arg3)
				if is_already_instanced then
					-- - Default: `func█(a1, a2, a3)` =Complete=> `doSomething( , , )(a1, a2, a3)`
					-- - Meu: `dosomethi█(a1, a2, a3)` =Complete=> `dosomething(a1, a2, a3)`
					body = args.body:gsub('%b()', '') -- remove tudo entre os parenteses
				else
					-- Default: func( █, , )
					-- Meu: func(█)
					body = args.body:gsub('%b()', '(${1})')
				end

				luasnip.lsp_expand(body)
			end,
		},
		mapping = get_mappings(),
		sources = cmp.config.sources({
			{
				name = 'nvim_lsp',
				priority = 1000,
				entry_filter = lsp_entry_filter(),
				-- group_index = 1,
			},
			{
				name = 'luasnip',
				priority = 750,
				max_item_count = 5,
				keyword_length = 2,
				-- group_index = 1,
			},
			{
				name = 'buffer',
				priority = 500,
				keyword_length = 4,
				max_item_count = 5,
				-- group_index = 2,
			},
			{
				name = 'path',
				priority = 250,
				-- group_index = 1,
			},
		}),
		-- duplicates = {
		-- 	buffer = 1,
		-- 	path = 1,
		-- 	nvim_lsp = 0,
		-- 	luasnip = 0,
		-- },
		sorting = {
			priority_weight = 2,
			comparators = {
				-- require('copilot_cmp.comparators').prioritize or nil,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require('plugins.cmp.comparators').buff_variables,
				require('plugins.cmp.comparators').buff_properties,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.order,
			},
		},
		formatting = {
			fields = { 'kind', 'abbr', 'menu' },
			format = lspkind.cmp_format({
				mode = 'symbol_text',
				max_width = 50,
				symbol_map = lspkind_icons,
				before = function(entry, vim_item)
					-- vim_item.dup = ({ nvim_lsp = 0, path = 0 })[entry.source.name] or 0
					vim_item.kind = lspkind_icons[vim_item.kind]

					if vim.tbl_contains({ 'path' }, entry.source.name) then
						local icon, hl_group = web_devicons.get_icon(entry:get_completion_item().label)
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
				side_padding = 0,
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = 'Normal:TelescopeNormal,FloatBorder:TelescopeBorder',
			}),
		},
		experimental = { ghost_text = {} },
		preselect = cmp.PreselectMode.Item,
		view = { entries = 'custom' }, -- can be "custom", "wildmenu" or "native"
	}

	cmp.setup(default_config)

	---@param filetype string | string[]
	---@param mod_cmp fun(cfg: cmp.ConfigSchema)
	local setup_cmp_filetype = function(filetype, mod_cmp)
		local config = vim.deepcopy(default_config)
		mod_cmp(config)
		cmp.setup.filetype(filetype, config)
	end

	setup_cmp_filetype('gitcommit', function(config) --
		config.sources = cmp.config.sources({
			{ name = 'conventionalcommits' },
			{ name = 'buffer' },
		})
	end)

	setup_cmp_filetype({ 'html', 'css', 'sass', 'less' }, function(config)
		config.sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'html-css' },
		})
		config.formatting.format = function(entry, vim_item)
			vim_item = default_config.formatting.format(entry, vim_item)

			-- Customiza entrada para as completions de html/css
			if entry.source.name == 'html-css' then
				---@diagnostic disable-next-line: undefined-field
				vim_item.menu = entry.completion_item.menu -- onde está vindo (bootstrap, angular, etc)
				vim_item.kind = lspkind_icons.Constant -- Deixa o icone igual a do tailwind
				vim_item.kind_hl_group = 'Constant' -- Deixa a cor igual a do tailwind
			end

			return vim_item
		end
	end)

	setup_cmp_filetype('python', function(config)
		table.insert(config.sorting.comparators, 2, require('plugins.cmp.comparators').nerf_dunder_python)

		local _, idx = Array(default_config.sources):find_first(function(e) return e.name == 'nvim_lsp' end)

		config.sources[idx].entry_filter = lsp_entry_filter(function(ctx)
			-- def function():█
			if ctx.cur_line:match(':█$') then return false end

			-- from X import █
			if ctx.cur_line:match('import%s█') then return (ctx.kind ~= 'Snippet') end

			return true
		end)
	end)

	require('plugins.cmp.cmdline').setup()
end

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
