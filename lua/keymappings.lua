local keymap = utils.api.keymap

keymap('n', '<leader>it', ':InspectTree<CR>:vertical resize 50<CR><c-w>w')
keymap('n', '<leader>tsu', ':TSUpdate copybook<CR>')

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Geral                           │
--  ╰──────────────────────────────────────────────────────────╯
keymap({ 'n', 'v' }, '<Space>', '<Nul>') -- Tira a movimentação no space

keymap({ 'n', 'x' }, 'gx', ":silent execute '!open ' . shellescape('<cWORD>')<CR>", { desc = 'Abrir no Browser' })
keymap({ 'n' }, '<leader><leader>q', ':quitall!<CR>', { desc = 'Forçar a sair do Neovim' })

--  ╭──────────────────────────────────────────────────────────╮
--  │                       Movimentação                       │
--  ╰──────────────────────────────────────────────────────────╯

------- Mover no texto

keymap({ 'n', 'v' }, 'ç', 'l')
keymap({ 'n', 'v' }, 'l', 'k')
keymap({ 'n', 'v' }, 'k', 'j')
keymap({ 'n', 'v' }, 'j', 'h')

-- Mover direito mesmo quando a linha da wrap
keymap('n', 'l', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'k', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

------- Mover entre Tabs

keymap({ 'n', 'v', 'i' }, '<A-j>', ':tabprevious<CR>')
keymap({ 'n', 'v', 'i' }, '<A-ç>', ':tabnext<CR>')
keymap({ 'n', 'v', 'i' }, '<A-1>', '1gt')
keymap({ 'n', 'v', 'i' }, '<A-2>', '2gt')
keymap({ 'n', 'v', 'i' }, '<A-3>', '3gt')
keymap({ 'n', 'v', 'i' }, '<A-4>', '4gt')
keymap({ 'n', 'v', 'i' }, '<A-5>', '5gt')
keymap({ 'n', 'v', 'i' }, '<A-6>', '6gt')
keymap({ 'n', 'v', 'i' }, '<A-7>', '7gt')
keymap({ 'n', 'v', 'i' }, '<A-8>', '8gt')
keymap({ 'n', 'v', 'i' }, '<A-9>', '9gt')

-- Mover a tab
keymap('n', '<A-->', ':tabm -1<CR>')
keymap('n', '<A-=>', ':tabm +1<CR>')

-- restaurar tab fechada recentemente
keymap('n', '<leader>ut', '<Cmd>Undoquit<CR>') -- [U]ndo [T]ab

-- Movimentação no command mode
keymap('c', '<C-k>', '<Right>')
keymap('c', '<C-l>', '<Left>')

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Edição                          │
--  ╰──────────────────────────────────────────────────────────╯

keymap({ 'n', 'v' }, '<leader>q', ':q<CR>')  -- [Q]uit
keymap({ 'n', 'v' }, '<leader>w', ':wa<CR>') -- [W]rite

-- Copiar a linha horizontalmente
keymap({ 'n', 'i', 'v' }, '<S-M-l>', ':t-1<CR>')
keymap({ 'n', 'i', 'v' }, '<S-M-k>', ':t.<CR>')
keymap('v', '<S-M-l>', "yPgv:'<,'>m '.-1<CR>gv")
keymap('v', '<S-M-k>', 'yPgv')

keymap('x', '<leader>p', '"_dp')         -- preservar buffer
keymap({ 'n', 'v' }, '<leader>y', '"+y') -- copiar para o system clipboard
keymap('n', '<leader>p', '"+p')          -- colar do system clipboard
keymap({ 'n', 'v' }, '<leader>d', '"_d') -- deletar pro void

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Macros                          │
--  ╰──────────────────────────────────────────────────────────╯

-- Enter key should repeat the last macro recorded or just act as enter
keymap('n', '<leader><CR>', [[empty(&buftype) ? '@@' : '<CR>']], { expr = true })

-- REF: stoeffel/.dotfiles
-- Deixa repetir o macro em uma visual range
vim.cmd([[
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]])

keymap('x', '@', ':<C-u>call ExecuteMacroOverVisualRange()<CR>')
