local M = {}

function M.setup()
  -- conserta os highlights
  vim.filetype.add({ extension = { ['http'] = 'http' } })

  -- 1) `sudo pacman -Syu jq` (formatted JSON responses)
  -- 2) `sudo pacman -Syu jq` (formatted XML/HTML responses)
  return {
    'mistweaverco/kulala.nvim',
    config = M.config,
    ft = 'http',
  }
end

function M.config()
  local keymap = utils.api.keymap --('n', '<C-k>', ":lua require('kulala').jump_prev()<CR>")
  local kulala = require('kulala')

  utils.api.augroup('PackageInfoKeymaps', {
    event = 'FileType',
    pattern = 'http',
    command = function(args) keymap('n', '<leader>r', kulala.run, { buffer = args.buf, desc = 'kulala: run' }) end,
  })

  kulala.setup({
    -- default_view, body or headers
    default_view = 'body',
    -- dev, test, prod, can be anything
    -- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
    default_env = 'dev',
    -- enable/disable debug mode
    debug = false,
    -- default formatters for different content types
    formatters = {
      json = { 'jq', '.' },
      xml = { 'xmllint', '--format', '-' },
      html = { 'xmllint', '--format', '--html', '-' },
    },
    -- default icons
    icons = {
      inlay = {
        loading = '⏳',
        done = '✅ ',
      },
      lualine = '🐼',
    },
    -- additional cURL options
    -- e.g. { "--insecure", "-A", "Mozilla/5.0" }
    additional_curl_options = {},
  })
end

return M
