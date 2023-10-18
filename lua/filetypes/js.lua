return {
  commands = function()
    create_picker('<leader><leader>o', 'JS/TS', {
      { name = 'npm run dev', handler = 'npm run dev' },
    })
  end,
  mappings = {},
}
