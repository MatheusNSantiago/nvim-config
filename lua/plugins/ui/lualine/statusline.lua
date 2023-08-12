local icons = require('utils.icons')
local c = vim.tbl_extend('force', require('utils.colors'), {
  normal = '#7e9cd8',
  insert = '#98bb6c',
  visual = '#ffa066',
  replace = '#e46876',
  command = '#e6c384',
})

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  fileformat_is_not_unix = function()
    local ff = vim.bo.fileformat
    return ff ~= 'unix'
  end,
  encoding_is_not_utf8 = function()
    local enc = vim.bo.fenc
    return enc ~= 'utf-8'
  end,
  has_git = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local function show_macro_recording()
  local rec_reg = vim.fn.reg_recording()
  if rec_reg == '' then
    return ''
  else
    return 'recording @' .. rec_reg
  end
end

local function mode_color_with_transparent_background()
  local mode = vim.fn.mode()

  if mode == 'n' then
    return { fg = c['normal'], bg = c.transparent }
  elseif mode == 'i' then
    return { fg = c['insert'], c.transparent }
  elseif mode == 'v' or mode == 'V' then
    return { fg = c['visual'], c.transparent }
  elseif mode == 'c' then
    return { fg = c['command'], c.transparent }
  end
end
local function mode_color_without_transparent_background()
  local mode = vim.fn.mode()

  if mode == 'n' then
    return { fg = c['normal'] }
  elseif mode == 'i' then
    return { fg = c['insert'] }
  elseif mode == 'v' or mode == 'V' then
    return { fg = c['visual'] }
  elseif mode == 'c' then
    return { fg = c['command'] }
  end
end

local function left_separator() return '' end
local function right_separator() return '' end

return {
  lualine_a = {
    { 'mode', color = { fg = c.dark_bg, gui = 'bold' } },
    {
      left_separator,
      color = mode_color_with_transparent_background,
      padding = { right = 0, left = 0 },
      cond = function() return not conditions.has_git() end,
    },
  },
  lualine_b = {
    {
      left_separator,
      color = mode_color_without_transparent_background,
      padding = { right = 0, left = 0 },
      cond = conditions.has_git,
    },
    { 'FugitiveHead', icon = icons.git.Branch },
    {
      'diff',
      symbols = {
        added = icons.git.Add .. ' ',
        modified = icons.git.Mod .. ' ',
        removed = icons.git.Remove .. ' ',
      },
      diff_color = {
        added = { fg = c.green },
        modified = { fg = c.orange },
        removed = { fg = c.red },
      },
      cond = conditions.hide_in_width,
    },
    {
      'macro-recording',
      fmt = show_macro_recording,
    },
  },
  lualine_c = {
    { left_separator, color = { fg = c.outerbg }, padding = { right = 0, left = 0 }, cond = conditions.has_git },
    { '%=' },
    {
      'filename',
      cond = conditions.buffer_not_empty,
      file_status = false,
      path = 1,
      color = { fg = c.magenta, gui = 'bold' },
    },
  },
  lualine_x = {
    { right_separator, color = { fg = c.outerbg }, padding = { right = 0, left = 0 } },
  },
  lualine_y = {
    {
      'diagnostics',
      -- sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic' },
      sources = { 'nvim_workspace_diagnostic' },
      sections = { 'hint', 'info', 'warn', 'error' },
      symbols = {
        error = icons.diagnostics.ErrorFilled,
        warn = icons.diagnostics.WarningFilled,
        info = icons.diagnostics.InformationFilled,
        hint = icons.diagnostics.HintFilled,
      },
      diagnostics_color = {
        error = { fg = c.red },
        warn = { fg = c.orange },
        info = { fg = c.cyan },
        hint = { fg = c.blue },
      },
    },
    {
      -- Lsp server name .
      function()
        local msg = 'No LSP'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then return msg end

        local servers = vim.tbl_extend('keep', require('lsp').servers, { 'dartls', 'typescript-tools' })
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            if vim.tbl_contains(servers, client.name) then return client.name end
          end
        end
        return msg
      end,
      icon = '',
      color = { fg = '#ffffff', gui = 'bold' },
      on_click = function() vim.cmd([[LspInfo]]) end,
    },
    { 'searchcount',   maxcount = 999,                                    timeout = 500 },
    { 'encoding',      cond = conditions.encoding_is_not_utf8 },
    { 'fileformat',    cond = conditions.fileformat_is_not_unix },
    { right_separator, color = mode_color_without_transparent_background, padding = { right = 0, left = 0 } },
  },
  lualine_z = {
    {
      '%p%%/%L',
      cond = conditions.buffer_not_empty,
      color = { fg = c.dark_bg },
      padding = { right = 1, left = 1 },
    },
  },
}
