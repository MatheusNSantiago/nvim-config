local keymaps = utils.api.keymap
return {
  commands = function()
    create_picker('JS/TS', '<leader><leader>o', {
      {
        name = 'npm run dev',
        handler = 'npm run dev',
      },
    })

    keymaps('n', '<leader>toi', ':TSToolsOrganizeImports<CR>', { desc = '[T]ypescript: [O]rganize [I]mports' })
    keymaps('n', '<leader>tsi', ':TSToolsSortImports<CR>', { desc = '[T]ypescript: [S]ort [I]mports' })
    keymaps('n', '<leader>tru', ':TSToolsRemoveUnused<CR>', { desc = '[T]ypescript: [R]emove [U]nused' })
    keymaps('n', 'gd', ':TSToolsGoToSourceDefinition<CR>', { desc = 'Typescript: [G]o to [D]efinition' })
    keymaps(
      'n',
      '<leader>trui',
      ':TSToolsRemoveUnusedImports<CR>',
      { desc = '[T]ypescript: [R]emove [U]nused [I]mports' }
    )
    keymaps('n', '<leader>tfa', ':TSToolsFixAll<CR>', { desc = '[T]ypescript: [F]ix [A]ll' })
    keymaps('n', '<leader>tami', ':TSToolsAddMissingImports<CR>', { desc = '[T]ypescript: [A]dd [M]issing [I]mports' })
  end,
}
