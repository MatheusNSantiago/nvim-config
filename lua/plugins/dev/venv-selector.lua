local M = {}

function M.setup()
  -- vim.api.nvim_create_autocmd('VimEnter', {
  --   desc = 'Auto select virtualenv Nvim open',
  --   pattern = '*',
  --   callback = function()
  --     local venv = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
  --     if venv ~= '' then
  --       require('venv-selector').retrieve_from_cache() --
  --     end
  --   end,
  --   once = true,
  -- })

  return {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
    },
    ft = 'python',
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = M.config,
  }
end

function M.config()
  require('venv-selector').setup({
    -- search = false,
    -- auto_refresh = true,
    -- poetry_path = vim.env.HOME .. '/.cache/pypoetry/virtualenvs',
    -- notify_user_on_activate = false,
  })
end

return M
