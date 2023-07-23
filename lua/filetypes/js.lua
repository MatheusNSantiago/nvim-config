return {
  commands = function()
    create_picker('JS/TS', '<leader><leader>o', {
      {
        name = 'start vite dev server',
        handler = 'npm run dev',
      },
    })
  end,
}
