local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts.setup({
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "python",
    "json",
    "html",
    "lua",
    "css",
    "scss",
    "markdown",
    "markdown_inline",
    "toml",
    "fish",
    "yaml",
    "jsdoc",
    "json",
    "regex",
    "yaml",
    "bash",
  },
  context_commentstring = {
    enable = true,
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = "<C-space>",
      -- node_incremental = "<C-space>",
      -- scope_incremental = "<nop>",
      -- node_decremental = "<bs>",
    },
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
