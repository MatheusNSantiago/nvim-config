local M = {}

function M.setup()
	M.set_keymaps()

	return {
		'phaazon/hop.nvim',
		commit = 'caaccee',
		config = M.config,
	}
end

function M.set_keymaps()
	local is_installed, hop = pcall(require, 'hop')
	if not is_installed then return end

	local keymap = utils.api.keymap
	local directions = require('hop.hint').HintDirection
	local position = require('hop.hint').HintPosition

	-- Same Line Moviments
	keymap(
		'n',
		'<leader><leader>f',
		function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end
	)
	keymap(
		'n',
		'<leader><leader>F',
		function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end
	)

	keymap(
		'n',
		'<leader><leader>t',
		function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end
	)

	keymap(
		'n',
		'<leader><leader>T',
		function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end
	)

	-- Vertical Moviments
	keymap({ 'n', 'v' }, '<Leader><Leader>k', '<cmd>HopVerticalAC<CR>')
	keymap({ 'n', 'v' }, '<Leader><Leader>l', '<cmd>HopVerticalBC<CR>')

	-- Word Moviments
	keymap({ 'n', 'v' }, '<Leader><Leader>b', '<cmd>HopWordBC<CR>')
	keymap({ 'n', 'v' }, '<Leader><Leader>w', '<cmd>HopWordAC<CR>')
	keymap(
		{ 'n', 'v' },
		'<leader><leader>e',
		function() hop.hint_words({ direction = directions.AFTER_CURSOR, hint_position = position.END }) end
	)
	keymap(
		{ 'n', 'v' },
		'<leader><leader>ge',
		function() hop.hint_words({ direction = directions.BEFORE_CURSOR, hint_position = position.END }) end
	)

	-- Sneak
	keymap({ 'n', 'v' }, '<Leader><Leader>s', '<cmd>HopChar2AC<CR>')
	keymap({ 'n', 'v' }, '<Leader><Leader>S', '<cmd>HopChar2BC<CR>')

	-- Pattern
	keymap({ 'n', 'v' }, '<leader><leader>/', hop.hint_patterns)
end

M.highlights = {
	-- Highlight used for the mono-sequence keys (i.e. sequence of 1).
	HopNextKey = { fg = '#ff0000', bold = true, ctermfg = 198 }, -- cterm = "bold" },
	-- Highlight used for the first key in a sequence.
	HopNextKey1 = { fg = '#ffb400', bold = true, ctermfg = 45 }, -- cterm = "bold" },
	-- Highlight used for the second and remaining keys in a sequence.
	HopNextKey2 = { fg = '#b98300', ctermfg = 33 },
	-- Highlight used for the unmatched part of the buffer.
	-- ctermbg=bg is omitted because it errors if Normal does not have ctermbg set
	-- Luckily guibg=bg does not seem to error even if Normal does not have guibg set so it can be used
	-- HopUnmatched = { fg = "#666666", bg = "bg", sp = "#666666", ctermfg = 242 },
	-- Highlight used for the fake cursor visible when hopping.
	HopCursor = { link = 'Cursor' },
	-- Highlight used for preview pattern
	HopPreview = { link = 'IncSearch' },
}

function M.config()
	require('hop').setup({
		keys = 'çalskdjfwoeicmvn',
		-- create_hl_autocmd = true,
	})
end

return M
