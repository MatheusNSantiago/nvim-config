local M = {}

function M.setup()
	return {
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = M.config,
	}
end

local c = require("utils.colors")
M.highlights = {
	-- PmenuSel = { fg = "NONE", bg = "#282C34" },
	-- Pmenu = { fg = "#C5CDD9", bg = "#22252A" },
	CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
	CmpItemAbbrMatch = { fg = c.secondary, bg = "NONE", bold = true },
	CmpItemAbbrMatchFuzzy = { fg = c.secondary, bg = "NONE", bold = true },
	CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },
	CmpItemKindColor = { fg = "#D8EEEB", bg = "None" },
	CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "None" },
	-- CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
	-- CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
	CmpItemAbbr = { fg = "White", bg = "NONE" },
	-- cmp item kinds
	CmpItemKindText = { fg = "LightGrey" },
	CmpItemKindFunction = { fg = "#C586C0" },
	CmpItemKindClass = { fg = "Orange" },
	CmpItemKindKeyword = { fg = "#f90c71" },
	CmpItemKindSnippet = { fg = "#565c64" },
	CmpItemKindConstructor = { fg = "#ae43f0" },
	CmpItemKindVariable = { fg = "#9CDCFE", bg = "NONE" },
	CmpItemKindInterface = { fg = "#f90c71", bg = "NONE" },
	CmpItemKindFolder = { fg = "#2986cc" },
	CmpItemKindReference = { fg = "#922b21" },
	CmpItemKindMethod = { fg = "#C586C0" },
	CmpItemKindCopilot = { fg = "#6CC644" },
}

function M.config()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local luasnip = require("luasnip")

	require("luasnip/loaders/from_vscode").lazy_load()

	local function border(hl_name)
		return {
			{ "╭", hl_name },
			{ "─", hl_name },
			{ "╮", hl_name },
			{ "│", hl_name },
			{ "╯", hl_name },
			{ "─", hl_name },
			{ "╰", hl_name },
			{ "│", hl_name },
		}
	end

	-- local function has_words_before()
	-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- end

	local source_mapping = require("utils.icons").lspkind
	cmp.setup({
		-- completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-l>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
			--
			["<C-k>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
			--
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			--
			["<C-Space>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.abort()
				else
					cmp.complete()
				end
			end, { "i", "c" }),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<ESC>"] = cmp.mapping({
				i = function(_)
					cmp.abort()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
				end,
				c = cmp.mapping.close(),
			}),
			-- ["<Tab>"] = cmp.mapping(function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.select_next_item()
			-- 	elseif luasnip.expand_or_jumpable() then
			-- 		luasnip.expand_or_jump()
			-- 	elseif has_words_before() then
			-- 		cmp.complete()
			-- 		-- elseif luasnip.expandable() then
			-- 		-- 	luasnip.expand()
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, { "i", "s" }),
			-- ["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 	if cmp.visible() then
			-- 		cmp.select_prev_item()
			-- 	elseif luasnip.jumpable(-1) then
			-- 		luasnip.jump(-1)
			-- 	else
			-- 		fallback()
			-- 	end
			-- end, { "i", "s" }),
			-- ["<C-e>"] = function() end,
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = lspkind.cmp_format({
				-- mode = "symbol_text",
				mode = "symbol",
				max_width = 40,
				symbol_map = source_mapping,
				-- ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
				-- before = function(entry, vim_item)
				-- 	vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
				-- 	-- vim_item.kind = lspkind.presets.default[vim_item.kind]
				--
				-- 	local menu = source_mapping[entry.source.name]
				-- 	-- local maxwidth = 50
				-- 	-- vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
				--
				-- 	vim_item.menu = menu
				-- 	return vim_item
				-- end,
			}),
		},
		-- You should specify your *installed* sources.
		sources = cmp.config.sources({
			{ name = "path", priority = 2000, max_item_count = 4 },
			{ name = "nvim_lsp", priority = 950, max_item_count = 15 },
			{ name = "copilot", priority = 900 },
			{ name = "npm", priority = 900 },
			{ name = "luasnip", priority = 700, max_item_count = 5 },
			{ name = "nvim_lua", priority = 600 },
			{ name = "treesitter", max_item_count = 600 },
			{ name = "buffer", priority = 500, keyword_length = 5, max_item_count = 5 },
		}),
		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.kind,
				cmp.config.compare.locality,
				cmp.config.compare.sort_text,
				cmp.config.compare.order,
			},
		},
		duplicates = {
			nvim_lsp = 1,
			luasnip = 1,
			cmp_tabnine = 1,
			buffer = 1,
			path = 1,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:CmpNormal,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				border = "rounded",
			}),
			-- documentation = cmp.config.window.bordered({
			-- 	winhighlight = "Normal:CmpDocNormal,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			-- }),
			border = border("CmpDocBorder"),
		},
		experimental = {
			ghost_text = true,
			-- native_menu = true,
		},
		preselect = cmp.PreselectMode.Item,
		view = {
			-- entries = "native",
			entries = "custom",
		},
	})

	-- ╭──────────────────────────────────────────────────────────╮
	-- │ Cmdline Setup                                            │
	-- ╰──────────────────────────────────────────────────────────╯

	-- `:` cmdline setup.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})

	-- ╭──────────────────────────────────────────────────────────╮
	-- │ Copilot Setup                                            │
	-- ╰──────────────────────────────────────────────────────────╯

	require("copilot_cmp").setup({
		formatters = {
			label = require("copilot_cmp.format").format_label_text,
			insert_text = require("copilot_cmp.format").remove_existing,
			preview = require("copilot_cmp.format").deindent,
		},
	})

end

return M
