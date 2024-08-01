---@type FiletypeSettings
return {
  picker = {
    keymap = '<leader><leader>o',
    title = 'Markdown',
    actions = {
      { name = 'Ativar Preview', handler = ':MarkdownPreview<CR>' },
    },
  },
  on_buf_enter = function()
    vim.cmd('DisableHLIndent') --
  end,
  mappings = {
    -- { 'n', '<leader>r', ":TermExec cmd='tree-sitter generate && clear && tree-sitter parse ../test.foo'<CR>" },
  },
}
