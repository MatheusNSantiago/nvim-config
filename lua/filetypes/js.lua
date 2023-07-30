local keymap = utils.api.keymap
return {
  commands = function()
    create_picker('JS/TS', '<leader><leader>o', {
      {
        name = 'npm run dev',
        handler = 'npm run dev',
      },
    })

  end,
}
