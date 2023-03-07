local lspkind = require("lspkind")
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()

-- ╭──────────────────────────────────────────────────────────╮
-- │ Utils                                                    │
-- ╰──────────────────────────────────────────────────────────╯
local types = require("cmp.types")

local function deprioritize_snippet(entry1, entry2)
	if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return false
	end
	if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return true
	end
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup                                                    │
-- ╰──────────────────────────────────────────────────────────╯

local icons = require("utils.icons")

local source_mapping = {
	npm = icons.terminal .. "NPM",
	cmp_tabnine = icons.light,
	Copilot = icons.copilot,
	nvim_lsp = icons.paragraph .. "LSP",
	buffer = icons.buffer .. "BUF",
	nvim_lua = icons.bomb,
	luasnip = icons.snippet .. "SNP",
	calc = icons.calculator,
	path = icons.folderOpen2,
	treesitter = icons.tree,
	zsh = icons.terminal .. "ZSH",
}

-- local buffer_option = {
-- 	-- Complete from all visible buffers (splits)
-- 	get_bufnrs = function()
-- 		local bufs = {}
-- 		for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 			bufs[vim.api.nvim_win_get_buf(win)] = true
-- 		end
-- 		return vim.tbl_keys(bufs)
-- 	end,
-- }

-- vim.opt.completeopt = "menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-l>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-k>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.abort()
			else
				cmp.complete()
			end
		end, { "i", "c" }),
		["<ESC>"] = cmp.mapping({
			i = function(_)
				cmp.abort()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
			end,
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-e>"] = function() end,
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			max_width = 50,
			symbol_map = source_mapping,
			before = function(entry, vim_item)
				vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })

				local menu = source_mapping[entry.source.name]
				local maxwidth = 50

				vim_item.menu = menu
				vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
				return vim_item
			end,
		}),
	},
	-- You should specify your *installed* sources.
	sources = {
		{ name = "nvim_lsp", priority = 9 },
		{ name = "npm", priority = 9 },
		{ name = "copilot", priority = 8 },
		{ name = "cmp_tabnine", priority = 8, max_num_results = 3 },
		-- { name = "luasnip",     priority = 7, max_item_count = 8 },
		-- { name = "buffer",      priority = 7, keyword_length = 5, option = buffer_option, max_item_count = 8 },
		{ name = "nvim_lua", priority = 5 },
		{ name = "path", priority = 4 },
	},
	sorting = {
		comparators = {
			deprioritize_snippet,
			cmp.config.compare.exact,
			cmp.config.compare.locality,
			cmp.config.compare.recently_used,
			cmp.config.compare.score,
			cmp.config.compare.offset,
			cmp.config.compare.sort_text,
			cmp.config.compare.order,
		},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	},
	window = {
		completion = cmp.config.window.bordered({
			-- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			winhighlight = "Normal:CmpNormal,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			border = "rounded",
		}),
		documentation = cmp.config.window.bordered({
			winhighlight = "Normal:CmpDocNormal,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
		}),
	},
	experimental = {
		ghost_text = true,
		native_menu = false,
	},
	preselect = cmp.PreselectMode.Item,
})

-- ╭──────────────────────────────────────────────────────────╮
-- │ Cmdline Setup                                            │
-- ╰──────────────────────────────────────────────────────────╯

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

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
require("copilot_cmp").setup()
