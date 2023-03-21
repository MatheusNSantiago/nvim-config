-- Set lualine as statusline
--

local colors = {
  darkgray = "#16161d",
  gray = "#727169",
  innerbg = nil,
  transparent = nil,
  outerbg = "#16161D",
  normal = "#7e9cd8",
  insert = "#98bb6c",
  visual = "#ffa066",
  replace = "#e46876",
  command = "#e6c384",
}

local theme = {
  inactive = {
    a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  visual = {
    a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  replace = {
    a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  normal = {
    a = { bg = colors.normal, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  insert = {
    a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
  command = {
    a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
    b = { fg = colors.gray, bg = colors.outerbg },
    c = { fg = colors.gray, bg = colors.innerbg },
  },
}


local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.transparent, bg = colors.transparent } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function modified()
  if vim.bo.modified then return '+'
  elseif (vim.bo.modifiable == false) or (vim.bo.readonly == true) then
    return '-'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    -- component_separators = '',
    -- section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      { 'diagnostics', source = { 'nvim' }, sections = { 'error' } },
      { 'diagnostics', source = { 'nvim' }, sections = { 'warn' } },
      { 'filename', file_status = false, path = 1 },
      { modified },
      { '%w', cond = function() return vim.wo.previewwindow end },
      { '%r', cond = function() return vim.bo.readonly end },
      { '%q', cond = function() return vim.bo.buftype == 'quickfix' end },
    },
    lualine_c = {},
    lualine_x = {},
    -- lualine_y = { search_result, 'fileformat', 'filetype' },
    lualine_y = { 'filetype' },
    lualine_z = { '%p%%/%L' },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}
