local cmp = require("cmp")
local luasnip = require("luasnip")
local types = require("cmp.types.cmp")

local function check_backspace()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local function has_words_before()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

return cmp.mapping.preset.insert({
	["<C-l>"] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
	["<C-p>"] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
	--
	["<C-k>"] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
	["<C-n>"] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
	--
	["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
	["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	-- 	--
	["<C-Space>"] = cmp.mapping(function()
		if cmp.visible() then
			cmp.abort()
		else
			cmp.complete()
		end
	end, { "i", "c" }),
	-- ["<Tab>"] = cmp.mapping(function(fallback)
	-- 	if cmp.visible() then
	-- 		cmp.select_next_item()
	-- 	elseif cmp.visible() and has_words_before() then
	-- 		cmp.select_next_item({ behavior = types.SelectBehavior.Select })
	-- elseif luasnip.expandable() then
	-- 	luasnip.expand()
	-- elseif luasnip.expand_or_jumpable() then
	-- 	luasnip.expand_or_jump()
	-- 	elseif check_backspace() then
	-- 		fallback()
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
	["<ESC>"] = cmp.mapping({
		i = function(_)
			cmp.abort()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
		end,
		c = cmp.mapping.close(),
	}),
	["<CR>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	}),
	-- ["<CR>"] = cmp.mapping(function(fallback)
	-- 	if cmp.visible() then
	-- 		-- confirm_opts é a mesma que está no init
	-- 		local confirm_opts = {
	-- 			behavior = types.ConfirmBehavior.Replace,
	-- 			select = false,
	-- 		}

			-- local is_insert_mode = function()
			-- 	return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
			-- end
			-- if is_insert_mode() then -- prevent overwriting brackets
			-- 	confirm_opts.behavior = types.ConfirmBehavior.Insert
			-- end
			-- local entry = cmp.get_selected_entry()
			-- local is_copilot = entry and entry.source.name == "copilot"
			-- if is_copilot then
			-- 	confirm_opts.behavior = types.ConfirmBehavior.Replace
			-- 	confirm_opts.select = true
			-- end
	-- 		if cmp.confirm(confirm_opts) then
	-- 			return -- success, exit early
	-- 		end
	-- 	end
	-- 	fallback() -- if not exited early, always fallback
	-- end),
})
