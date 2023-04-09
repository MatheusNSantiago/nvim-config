local M = {}

function M.setup()
	return {
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = M.config,
	}
end

function M.config()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local luasnip = require("luasnip")

	require("config.cmp.copilot").setup()
	require("config.cmp.tabnine").setup()
	require("config.cmp.cmdline").setup()
	require("luasnip/loaders/from_vscode").lazy_load() -- load snippets from vscode

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = require("config.cmp.mappings"),
		-- You should specify your *installed* sources.
		sources = cmp.config.sources({
			{
				name = "nvim_lsp",
				priority = 10,
				max_item_count = 10,
				entry_filter = require("config.cmp.utils.limit_completions"),
				keyword_length = 1,
			},
			{ name = "path",        priority = 10, max_item_count = 4 },
			{ name = "copilot",     priority = 9 },
			{ name = "npm",         priority = 9 },
			{ name = "cmp_tabnine", priority = 9,  max_item_count = 3 },
			{ name = "luasnip",     priority = 7,  max_item_count = 5, keyword_length = 2 },
			{
				name = "buffer",
				priority = 7,
				keyword_length = 4,
				-- option = utils.buffer_option,
				max_item_count = 5,
			},
			{ name = "nvim_lua", priority = 5 },
			-- { name = "treesitter", max_item_count = 600 },
		}),
		sorting = {
			-- priority_weight = 2,
			comparators = {
				require("config.cmp.utils.comparators").deprioritize_snippet,
				require("copilot_cmp.comparators").prioritize,
				require("cmp_tabnine.compare"),
				cmp.config.compare.exact,
				cmp.config.compare.locality,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.offset,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.order,
			},
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = lspkind.cmp_format({
				mode = "symbol",
				max_width = 50,
				symbol_map = require("utils.icons").lspkind,
			}),
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			-- select = true,
			select = false,
		},
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:CmpNormal,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				border = "rounded",
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:CmpDocNormal,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			}),
			-- border = utils.border("CmpDocBorder"),
		},
		experimental = { ghost_text = true },
		preselect = cmp.PreselectMode.Item,
		view = { entries = "custom" },
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "conventionalcommits" },
		}, { { name = "buffer" } }),
	})
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

return M
