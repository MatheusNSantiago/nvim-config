return {
  commands = function()
    create_picker(
      '<leader><leader>o',
      { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
      'JS/TS',
      {
        { name = 'npm run dev', handler = 'npm run dev' },
      } --
    )
  end,
}
