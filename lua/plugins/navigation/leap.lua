local M = {}

function M.setup()
	return {
		'ggandor/leap.nvim',
		config = M.config,
	}
end

function M.config()
	local leap = require('leap')

	leap.add_default_mappings()
	leap.setup({
		max_highlighted_traversal_targets = 10,
		case_sensitive = false,
		safe_labels = {},
		labels = { 'a', 's', 'd', 'f', 'n', 'j', 'k', 'l', 'ç' },
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

local c = require('utils.colors')
M.highlights = {
	LeapMatch = { fg = c.red, bold = true, underline = true, nocombine = true },
	LeapLabel = { fg = c.red, bold = true, underline = true, nocombine = true },
	LeapLabelPrimary = { fg = c.red, bold = true, nocombine = true },
	LeapLabelSecondary = { fg = 'Yellow', bold = true, nocombine = true },
}

return M
