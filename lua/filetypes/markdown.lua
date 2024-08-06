---@type FiletypeSettings
return {
  picker = {
    keymap = '<leader><leader>o',
    title = 'Markdown',
    actions = {
      { name = 'Ativar Preview', handler = ':MarkdownPreview<CR>' },
    },
  },
  on_buf_enter = function(arg)
    -- local is_lsp_hover = arg.file == '' or arg.file == 'markdown'
    -- if not is_lsp_hover then
    --   vim.defer_fn(function()
    --     vim.cmd('DisableHLIndent') --
    --   end, 100)
    -- end
  end,
  mappings = {
    -- { 'n', '<leader>r', ":TermExec cmd='tree-sitter generate && clear && tree-sitter parse ../test.foo'<CR>" },
  },
}
