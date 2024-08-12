local function termexec(cmd)
  vim.cmd("TermExec cmd='" .. cmd .. "'")
  vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
end

---@type FiletypeSettings
return {
  picker = {
    keymap = '<leader><leader>o',
    title = 'Rust',
    actions = {},
  },
  mappings = {
    { 'n', '<leader>r', function() termexec('clear && cargo run') end },
  },
}
