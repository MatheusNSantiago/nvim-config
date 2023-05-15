local cmp = require('cmp')
local luasnip = require('luasnip')
local types = require('cmp.types.cmp')
local neogen = require('neogen')

local function shift_tab(fallback)
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	elseif neogen.jumpable(-1) then
		neogen.jump_prev()
	else
		fallback()
	end
end

local function tab(fallback)
	if luasnip.jumpable() then
		luasnip.jump(1)
	elseif neogen.jumpable() then
		neogen.jump_next()
	else
		fallback()
	end
end

return cmp.mapping.preset.insert({
	['<C-l>'] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
	['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
	--
	['<C-k>'] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
	['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
	--
	['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
	['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
	--
	['<C-Space>'] = cmp.mapping(function()
		if cmp.visible() then
			cmp.abort()
		else
			cmp.complete()
		end
	end, { 'i', 'c' }),
	['<Tab>'] = cmp.mapping(tab, { 'i', 's' }),
	['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 's' }),
	['<CR>'] = cmp.mapping(function(fallback)
		local copilot_ok, suggestion = pcall(require, 'copilot.suggestion')
		if copilot_ok and suggestion.is_visible() then
			suggestion.accept()
		elseif luasnip.expandable() then
			luasnip.expand()
		elseif cmp.visible() then
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
		else
			fallback()
		end
	end),
	['<ESC>'] = cmp.mapping({
		i = function(_)
			cmp.abort()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, true, true), 'n', true)
		end,
		c = cmp.mapping.close(),
	}),
})
