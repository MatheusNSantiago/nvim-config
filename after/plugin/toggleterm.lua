require("toggleterm").setup({
  open_mapping = "<leader>t",
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  close_on_exit = false, -- close the terminal window when the process exits
  start_in_insert = false,

  on_open = function(t)
    vim.cmd("NvimTreeClose")
    vim.cmd("NvimTreeOpen")
    vim.cmd("wincmd l")
    vim.cmd("wincmd k")
  end, -- function to run when the terminal opens
})



function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], opts)

  -- foco
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<C-\><C-n>:wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-ç>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
