local util = require('lspconfig.util')
local M = {}

M.root_dir = util.root_pattern(
  'pyproject.toml',
  'requirements.txt',
  '.venv',
  '.git',
  'setup.py',
  'setup.cfg',
  'pyrightconfig.json'
)

M.settings = {
  pyright = { autoImportCompletion = true },
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = 'openFilesOnly',
      useLibraryCodeForTypes = true,
      typeCheckingMode = 'off',
    },
  },
}

return M
