---@type FiletypeSettings
return {
  picker = {
    keymap = '<leader><leader>o',
    title = 'JS/TS',
    actions = {
      { name = 'npm run dev', handler = 'npm run dev' },
    },
  },
  mappings = {
    { 'n', '<leader>r', ":TermExec cmd='clear && bun run dev'<CR>" },
    -- { 'n', '<leader>r', ":TermExec cmd='tree-sitter generate && clear && tree-sitter parse ../test.foo'<CR>" },
  },
}
