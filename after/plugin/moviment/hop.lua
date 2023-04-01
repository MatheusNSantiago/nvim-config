local map = require("utils").map
local hop = require("hop")
local directions = require("hop.hint").HintDirection
local position = require("hop.hint").HintPosition

require("hop").setup({
	keys = "çalskdjfwoeicmvn",
	create_hl_autocmd = true,
})

--  ╭──────────────────────────────────────────────────────────╮
--  │                   Same Line Moviments                    │
--  ╰──────────────────────────────────────────────────────────╯

map("n", "<leader><leader>f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end)
map("n", "<leader><leader>F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end)

map("n", "<leader><leader>t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end)

map("n", "<leader><leader>T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end)

--  ╭──────────────────────────────────────────────────────────╮
--  │                    Vertical Moviments                     │
--  ╰──────────────────────────────────────────────────────────╯

map({ "n", "v" }, "<Leader><Leader>k", "<cmd>HopVerticalAC<CR>")
map({ "n", "v" }, "<Leader><Leader>l", "<cmd>HopVerticalBC<CR>")

--  ╭──────────────────────────────────────────────────────────╮
--  │                      Word Moviments                      │
--  ╰──────────────────────────────────────────────────────────╯

map({ "n", "v" }, "<Leader><Leader>b", "<cmd>HopWordBC<CR>")
map({ "n", "v" }, "<Leader><Leader>w", "<cmd>HopWordAC<CR>")

map({ "n", "v" }, "<leader><leader>e", function()
	hop.hint_words({ direction = directions.AFTER_CURSOR, hint_position = position.END })
end)
map({ "n", "v" }, "<leader><leader>ge", function()
	hop.hint_words({ direction = directions.BEFORE_CURSOR, hint_position = position.END })
end)
--  ╭──────────────────────────────────────────────────────────╮
--  │                          Sneak                           │
--  ╰──────────────────────────────────────────────────────────╯

map({ "n", "v" }, "<Leader><Leader>s", "<cmd>HopChar2AC<CR>")
map({ "n", "v" }, "<Leader><Leader>S", "<cmd>HopChar2BC<CR>")

--  ╭──────────────────────────────────────────────────────────╮
--  │                         Pattern                          │
--  ╰──────────────────────────────────────────────────────────╯

map({ "n", "v" }, "<leader><leader>/", function()
	hop.hint_patterns()
end)

--  ╭──────────────────────────────────────────────────────────╮
--  │                        Highlights                        │
--  ╰──────────────────────────────────────────────────────────╯

-- Highlight used for the mono-sequence keys (i.e. sequence of 1).
vim.api.nvim_command("highlight default HopNextKey  guifg=#ff0000 gui=bold ctermfg=198 cterm=bold")

-- Highlight used for the first key in a sequence.
vim.api.nvim_command("highlight HopNextKey1 guifg=#ffb400 gui=bold ctermfg=45 cterm=bold")

-- Highlight used for the second and remaining keys in a sequence.
vim.api.nvim_command("highlight HopNextKey2 guifg=#b98300 ctermfg=33")

-- Highlight used for the unmatched part of the buffer.
-- ctermbg=bg is omitted because it errors if Normal does not have ctermbg set
-- Luckily guibg=bg does not seem to error even if Normal does not have guibg set so it can be used
vim.api.nvim_command("highlight HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242")

-- Highlight used for the fake cursor visible when hopping.
vim.api.nvim_command("highlight link HopCursor Cursor")

-- Highlight used for preview pattern
vim.api.nvim_command("highlight link HopPreview IncSearch")
