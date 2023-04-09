local map = require('utils').map

map("n", "<leader>r", ":w<CR>:TermExec cmd='python %'<CR>")
