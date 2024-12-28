local M = {}

function M.setup()
	return {
		'phaazon/hop.nvim',
		commit = 'caaccee',
		config = M.config,
		keys = {
			-- Vertical Moviments
			{ '<Leader><Leader>k', ':HopVerticalAC<CR>', mode = { 'n', 'v' } },
			{ '<Leader><Leader>l', ':HopVerticalBC<CR>', mode = { 'n', 'v' } },
			-- Word Moviments
			{ '<Leader><Leader>b', ':HopWordBC<CR>', mode = { 'n', 'v' } },
			{ '<Leader><Leader>w', ':HopWordAC<CR>', mode = { 'n', 'v' } },
			{
				'<leader><leader>e',
				function()
					local directions = require('hop.hint').HintDirection
					local position = require('hop.hint').HintPosition
					require('hop').hint_words({ direction = directions.AFTER_CURSOR, hint_position = position.END })
				end,
				mode = { 'n', 'v' },
			},
			{
				'<leader><leader>ge',
				function()
					local directions = require('hop.hint').HintDirection
					local position = require('hop.hint').HintPosition

					require('hop').hint_words({ direction = directions.BEFORE_CURSOR, hint_position = position.END })
				end,
				mode = { 'n', 'v' },
			},
			-- Pattern
			{ '<leader><leader>/', function() require('hop').hint_patterns() end, mode = { 'n', 'v' } },
		},
	}
end

function M.keys()
	local hop_ok, hop = pcall(require, 'hop')
	if not hop_ok then return {} end

	local directions = require('hop.hint').HintDirection
	local position = require('hop.hint').HintPosition

	return {
		-- Vertical Moviments
		{ '<Leader><Leader>k', ':HopVerticalAC<CR>', mode = { 'n', 'v' } },
		{ '<Leader><Leader>l', ':HopVerticalBC<CR>', mode = { 'n', 'v' } },
		-- Word Moviments
		{ '<Leader><Leader>b', ':HopWordBC<CR>', mode = { 'n', 'v' } },
		{ '<Leader><Leader>w', ':HopWordAC<CR>', mode = { 'n', 'v' } },
		{
			'<leader><leader>e',
			function() hop.hint_words({ direction = directions.AFTER_CURSOR, hint_position = position.END }) end,
			mode = { 'n', 'v' },
		},
		{
			'<leader><leader>ge',
			function() hop.hint_words({ direction = directions.BEFORE_CURSOR, hint_position = position.END }) end,
			mode = { 'n', 'v' },
		},
		-- Pattern
		{ '<leader><leader>/', hop.hint_patterns, mode = { 'n', 'v' } },
	}
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
