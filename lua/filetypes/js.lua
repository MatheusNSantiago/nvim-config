---@type FiletypeSettings
return {
  picker = {
    '<leader><leader>o',
    'JS/TS',
    {
      { name = 'npm run dev', handler = 'npm run dev' },
    },
  },
  mappings = {
    { 'n', '<leader>r', ":TermExec cmd='tree-sitter generate && tree-sitter parse examples/foo.cbl'<CR>" },
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
