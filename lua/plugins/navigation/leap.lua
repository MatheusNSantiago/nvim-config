local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'ggandor/leap.nvim',
		config = M.config,
	}
end

function M.config()
	local leap = require('leap')

	-- Return an argument table for `leap()`, tailored for f/t-motions.
	local function as_ft(key_specific_args)
		local common_args = {
			inputlen = 1,
			inclusive = true,
			-- To limit search scope to the current line:
			-- pattern = function (pat) return '\\%.l'..pat end,
			opts = {
				labels = '', -- force autojump
				safe_labels = vim.fn.mode(1):match('[no]') and '' or nil, -- [1]
			},
		}
		return vim.tbl_deep_extend('keep', common_args, key_specific_args)
	end

	local clever = require('leap.user').with_traversal_keys -- [2]
	local clever_f = clever('f', 'F')
	local clever_t = clever('t', 'T')

	for key, key_specific_args in pairs({
		f = { opts = clever_f },
		F = { backward = true, opts = clever_f },
		t = { offset = -1, opts = clever_t },
		T = { backward = true, offset = 1, opts = clever_t },
	}) do
		vim.keymap.set({ 'n', 'x', 'o' }, key, function() leap.leap(as_ft(key_specific_args)) end)
	end

	U.api.keymap({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', { desc = 'leap: Leap forward' })
	U.api.keymap({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', { desc = 'leap: Leap backward' })

	-- leap.add_default_mappings()
	leap.setup({
		max_highlighted_traversal_targets = 10,
		case_sensitive = false,
		safe_labels = {},
		labels = { 'a', 's', 'd', 'f', 'n', 'j', 'k', 'l', 'ç', 'b', 'n', 'm' },
		special_keys = {
			repeat_search = '<enter>',
			next_phase_one_target = '<enter>',
			next_target = { '<enter>', ';' },
			prev_target = { '<tab>', ',' },
			next_group = '<space>',
			prev_group = '<tab>',
			multi_accept = '<enter>',
			multi_revert = '<backspace>',
		},
	})
end

M.highlights = {
	LeapMatch = { fg = c.red, bold = true, underline = true, nocombine = true },
	LeapLabel = { fg = c.red, bold = true, underline = true, nocombine = true },
	LeapLabelPrimary = { fg = c.red, bold = true, nocombine = true },
	LeapLabelSecondary = { fg = 'Yellow', bold = true, nocombine = true },
}

return M
