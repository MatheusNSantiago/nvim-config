---@type FiletypeSettings
return {
  picker = {
    keymap = '<leader><leader>o',
    title = 'JS/TS',
    actions = {
      { name = 'npm run dev', handler = 'npm run start' },
    },
  },
  mappings = {
    { 'n', '<leader>r', ":TermExec cmd='clear && npm run start'<CR>" },
    -- { 'n', '<leader>r', ":TermExec cmd='tree-sitter generate && clear && tree-sitter parse ../test.foo'<CR>" },
  },
}
