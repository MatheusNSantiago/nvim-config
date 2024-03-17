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
    -- { 'n', '<leader>r', ":TermExec cmd='clear && bun run dev'<CR>" },
    { 'n', '<leader>r', ":TermExec cmd='tree-sitter generate && clear && tree-sitter parse ../test.foo'<CR>" },
    {
      'n',
      'gd',
      ':TypescriptGoToSourceDefinition<CR>',
      desc = 'typescript: go to source definition',
    },
    {
      'n',
      'gD',
      ':tab split | TypescriptGoToSourceDefinition<CR>',
      desc = 'typescript: go to source definition',
    },
    {
      'n',
      'gV',
      ':vsplit<CR><C-w>w<C-w>L:TypescriptGoToSourceDefinition<CR>',
      desc = 'typescript: go to source definition',
    },
  },
}
