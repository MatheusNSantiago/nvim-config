require("utils")

vim.g.EasyMotion_keys = "çalskdjfwoeicmvn"
vim.g.EasyMotion_startofline = 0 -- mantém a mesma coluna ao fazer o j/k motion (tipo como se fosse 10j/k)

map("n", "<leader><leader>k", "<Plug>(easymotion-j)") -- linhas de baixo
map("n", "<leader><leader>ç", "<Plug>(easymotion-lineforward)") -- linhas de cima
map("n", "<leader><leader>l", "<Plug>(easymotion-k)") -- linhas de cima
map("n", "<leader><leader>j", "<Plug>(easymotion-linebackward)") -- linhas de cima

-- Tipo um vim sneak (2 char search)
map('n', "<leader><leader>s", "<Plug>(easymotion-s2)")
map('n', "<leader><leader>t", "<Plug>(easymotion-t2)")

map('n', "<leader><leader>/", "<Plug>(easymotion-vim-sn)")
