local keymap = utils.api.keymap

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Geral                           │
--  ╰──────────────────────────────────────────────────────────╯
-- map({ "n", "v" }, "<Space>", "<Nul>", silent)                                            -- Tira a movimentação no space

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

--  Mover de linha a linha

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
--
-- Mover a tab
keymap('n', '<A-->', ':tabm -1<CR>')
keymap('n', '<A-=>', ':tabm +1<CR>')

-- restaurar tab fechada recentemente
keymap('n', '<leader>ut', '<Cmd>Undoquit<CR>') -- [U]ndo [T]ab

-- Mover no command mode
keymap('c', '<C-k>', '<Right>')
keymap('c', '<C-l>', '<Left>')

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Edição                          │
--  ╰──────────────────────────────────────────────────────────╯

keymap({ 'n', 'v' }, '<leader>q', ':q<CR>') -- [Q]uit
keymap({ 'n', 'v' }, '<leader>w', ':wa<CR>') -- [W]rite

-- Copiar a linha horizontalmente
keymap({ 'n', 'i', 'v' }, '<S-M-l>', ':t-1<CR>')
keymap({ 'n', 'i', 'v' }, '<S-M-k>', ':t.<CR>')

keymap('v', '<S-M-l>', "yPgv:'<,'>m '.-1<CR>gv")
keymap('v', '<S-M-k>', 'yPgv')

-- Delete a word using Ctrl+Backspace
keymap({ 'i', 'c' }, '<C-BS>', '<C-w>')

-- preservar buffer
keymap('x', '<leader>p', '"_dp')

-- copiar para o system clipboard
keymap({ 'n', 'v' }, '<leader>y', '"+y')

-- deletar pro void
keymap({ 'n', 'v' }, '<leader>d', '"_d')

--  ╭──────────────────────────────────────────────────────────╮
--  │                          Debug                           │
--  ╰──────────────────────────────────────────────────────────╯

-- keymap({ 'n' }, '<leader>c', ':PackerCompile<CR>')
-- keymap({ 'n' }, '<leader>s', ':PackerSync<CR>')
-- keymap({ 'n', 'v' }, '<leader>w', ':w<CR>:so %<CR>') -- [W]rite
-- keymap({ "n", "v" }, "<leader>w", ":w<CR>:so %<CR>:PackerCompile<CR>", silent) -- [W]rite
