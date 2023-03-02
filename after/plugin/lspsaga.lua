local status, saga = pcall(require, "lspsaga")

if (not status) then return end

saga.setup({
  -- server_filetype_map = {
  --   typescript = 'typescript'
  -- },
  move_in_saga = { prev = { '<C-l>', 'l', '<C-n>' }, next = { '<C-k>', 'k', '<C-p>' } },

})


local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<A-q>', '<Cmd>Lspsaga hover_doc<CR>', opts) -- Hover Doc
-- keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)

-- Rename F2
keymap('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
-- Diagnostic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Peek Definition - You can edit the definition file in this flaotwindow
-- keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Show line diagnostics
keymap("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
