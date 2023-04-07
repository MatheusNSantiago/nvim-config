local M = {}

M.settings = {
  pyright = { autoImportCompletion = true },
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = "openFilesOnly",
      useLibraryCodeForTypes = true,
      completeFunctionParens = true,
      typeCheckingMode = "off",
    },
  },
}

return M
