local map = require("utils").map
vim.opt_local.shiftwidth = 2 -- width for autoindents

-- Only run this on dart files
map("n", "<leader>r", ":FlutterReload<CR>", { buffer = 0, desc = "Flutter: reload" })
map("n", "<leader><leader>r", ":FlutterRestart<CR>", { buffer = 0, desc = "Flutter: restart" })
map("n", "<leader><leader>o", ":Flutter<CR>", { buffer = 0, desc = "Flutter: open pallete" })
map(
  "n",
  "<leader>br",
  ":TermExec cmd='flutter pub run build_runner watch'<CR>",
  { buffer = 0, desc = "flutter: run code generation" }
)
