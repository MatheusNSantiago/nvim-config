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

	local source_mapping = require("utils.icons").lspkind
	cmp.setup({
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
		}),
		-- You should specify your *installed* sources.
		sources = cmp.config.sources({
			{ name = "path", priority = 2000, max_item_count = 4 },
			{ name = "nvim_lsp", priority = 950, max_item_count = 15 },
			{ name = "cmp_tabnine", priority = 950 },
			{ name = "copilot", priority = 950 },
			{ name = "npm", priority = 900 },
			{ name = "luasnip", priority = 700, max_item_count = 5 },
			-- { name = "nvim_lua",   priority = 600 },
			-- { name = "treesitter", max_item_count = 600 },
			{ name = "buffer", priority = 500, keyword_length = 5, max_item_count = 5 },
		}),
		sorting = {
			priority_weight = 2,
			comparators = {
				require("copilot_cmp.comparators").prioritize,
				require("cmp_tabnine.compare"),
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.locality,
				cmp.config.compare.order,
			},
		},
		-- duplicates = {
		-- 	nvim_lsp = 1,
		-- 	luasnip = 1,
		-- 	cmp_tabnine = 1,
		-- 	buffer = 1,
		-- 	path = 1,
		-- },
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = lspkind.cmp_format({
				mode = "symbol",
				max_width = 80,
				symbol_map = source_mapping,
			}),
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

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "conventionalcommits" },
		}, { { name = "buffer" }}),
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
	--
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                      tabnine setup                       │
	--  ╰──────────────────────────────────────────────────────────╯

	local tabnine = require("cmp_tabnine.config")

	tabnine:setup({
		max_lines = 1000,
		max_num_results = 20,
		sort = true,
		run_on_every_keystroke = true,
		snippet_placeholder = "..",
		ignored_file_types = {
			-- default is not to ignore
			-- uncomment to ignore in lua:
			-- lua = true
		},
		show_prediction_strength = false,
	})

	local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })

	vim.api.nvim_create_autocmd("BufRead", {
		group = prefetch,
		pattern = "*.{js,ts,jsx,tsx,py,dart,java,c,cpp,html,css}",
		callback = function()
			require("cmp_tabnine"):prefetch(vim.fn.expand("%:p"))
		end,
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
