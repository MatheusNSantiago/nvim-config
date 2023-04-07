local M = {}


M.settings = {
  Lua = {
    completion = { callSnippet = "Replace" },
    diagnostics = {
      globals = { "vim", "bit", "packer_plugins" },
    },
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = "LuaJIT",
    },
    workspace = { checkThirdParty = false },
    telemetry = { enable = false },
    hint = { enable = false },
  },
}

M.single_file_support = false

return M
