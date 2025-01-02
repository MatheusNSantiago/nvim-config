local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'kevinhwang91/nvim-ufo',
		config = M.config,
		keys = {
			{
				'za',
				function()
					vim.defer_fn(function() U.api.feedkeys('za') end, M.started and 0 or 200)
				end,
				desc = 'Toggle fold',
			},
			{ 'zA', desc = 'Toggle fold recursively' },
			{ 'zR', function() require('ufo').openAllFolds() end, desc = 'Open all folds' },
			{ 'zM', function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },
		},
		init = function()
			vim.o.foldcolumn = '0' -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
	}
end

function M.config()
	require('ufo').setup({
		open_fold_hl_timeout = 400,
		close_fold_kinds_for_ft = { default = {} },
		fold_virt_text_handler = M.custom_handler,
		enable_get_fold_virt_text = false,
		provider_selector = function(_, _, _) return { 'treesitter', 'indent' } end,
	})

	vim.schedule(function() M.started = true end)
end

M.custom_handler = function(virt_text, start_line, end_line, width, truncate)
	local new_virt_text = {}
	local suffix = ('  %d '):format(end_line - start_line)
	local suf_width = vim.fn.strdisplaywidth(suffix)
	local target_width = width - suf_width
	local cur_width = 0

	for _, chunk in ipairs(virt_text) do
		local chunk_text = chunk[1]
		local chunk_width = vim.fn.strdisplaywidth(chunk_text)
		if target_width > cur_width + chunk_width then
			table.insert(new_virt_text, chunk)
		else
			chunk_text = truncate(chunk_text, target_width - cur_width)
			local hl_group = chunk[2]
			table.insert(new_virt_text, { chunk_text, hl_group })
			chunk_width = vim.fn.strdisplaywidth(chunk_text)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if cur_width + chunk_width < target_width then
				suffix = suffix .. (' '):rep(target_width - cur_width - chunk_width)
			end
			break
		end
		cur_width = cur_width + chunk_width
	end

	table.insert(new_virt_text, { suffix, 'MoreMsg' })

	return new_virt_text
end

return M
