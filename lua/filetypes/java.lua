local M = {}

---@type FiletypeSettings
M.settings = {
  mappings = {
    { 'n', '<leader>r', M.run_program },
  },
}

M.run_program = function()
  vim.cmd('silent !mvn package ')
  vim.cmd('TermExec cmd="clear && java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App"')

  vim.schedule(function()
    vim.cmd('wincmd j')
    vim.cmd('wincmd k')

    vim.defer_fn(function()
      vim.cmd('stopinsert')
      utils.api.feedkeys('ç')
    end, 50)
  end)
end

return M.settings
