local M = {}

function M.setup()
  return {
    'vidocqh/auto-indent.nvim',
    config = M.config,
  }
end

function M.config()
  require('auto-indent').setup({
    lightmode = true,         -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
    indentexpr = function(lnum) -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
      return require('nvim-treesitter.indent').get_indent(lnum)
    end,
    ignore_filetype = {}, -- Disable plugin for specific filetypes, e.g. ignore_filetype = { 'javascript' }
  })
end

return M
