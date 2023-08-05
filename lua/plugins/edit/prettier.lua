local M = {}

function M.setup()
  return {
    'MunifTanjim/prettier.nvim',
    config = M.config,
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  }
end

function M.config()
  require('prettier').setup({
    bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
    cli_options = {
      -- config_precedence = "prefer-file", -- or "cli-override" or "file-override"
      arrow_parens = 'always',
      bracket_spacing = true,
      bracket_same_line = false,
      embedded_language_formatting = 'auto',
      end_of_line = 'lf',
      html_whitespace_sensitivity = 'css',
      -- jsx_bracket_same_line = false,
      jsx_single_quote = false,
      print_width = 80,
      prose_wrap = 'preserve',
      quote_props = 'as-needed',
      semi = true,
      single_attribute_per_line = false,
      single_quote = true,
      tab_width = 2,
      trailing_comma = 'es5',
      use_tabs = false,
      vue_indent_script_and_style = false,
    },
    filetypes = {
      'css',
      'graphql',
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'less',
      'markdown',
      'scss',
      'typescript',
      'typescriptreact',
      'yaml',
    },
    ['null-ls'] = {
      condition = function()
        -- local is_in_package_json = prettier.config_exists({
        -- 	-- if `false`, skips checking `package.json` for `"prettier"` key
        -- 	check_package_json = true,
        -- })
        return true
      end,
      runtime_condition = function(params)
        -- return false to skip running prettier
        return true
      end,
      timeout = 5000,
    },
  })
end

return M
