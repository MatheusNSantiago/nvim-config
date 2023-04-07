local M = {}

function M.setup()
  return {
"axelvc/template-string.nvim",
    connfig = M.config,
  }

end
function M.config()
  local template_string = require("template-string")

  template_string.setup({
    filetypes = {
      "typescript",
      "javascript",
      "typescriptreact",
      "javascriptreact",
      "python",
    },                            -- filetypes where the plugin is active
    jsx_brackets = true,          -- must add brackets to jsx attributes
    remove_template_string = true, -- remove backticks when there are no template string
    restore_quotes = {
      -- quotes used when "remove_template_string" option is enabled
      normal = [[']],
      jsx = [["]],
    },
  })
end

return M
