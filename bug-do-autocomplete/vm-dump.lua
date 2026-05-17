local log_dir = vim.fn.expand("~/.config/nvim/bug-do-autocomplete")
vim.fn.mkdir(log_dir, "p")
local path = log_dir .. "/vm-dump-" .. os.date("%Y%m%d-%H%M%S") .. ".log"
local vars = vim.b
local lines = {
  "# vim-visual-multi state",
  "buf=" .. vim.api.nvim_get_current_buf(),
  "filetype=" .. vim.bo.filetype,
  "",
  "## b:VM_Debug",
  vim.inspect(vars.VM_Debug),
  "",
  "## b:VM_maps",
  vim.inspect(vars.VM_maps),
  "",
  "## b:VM_unmaps",
  vim.inspect(vars.VM_unmaps),
  "",
  "## insert <CR>",
  vim.inspect(vim.fn.maparg("<CR>", "i", false, true)),
}
vim.fn.writefile(lines, path)
print("vm dump escrito em " .. path)
