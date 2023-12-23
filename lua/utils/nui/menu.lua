local NuiMenu = require('nui.menu')

---@class Menu
local Menu = Class('Menu')

---@alias MenuItem {[1]: string, [2]?: table } | string

---@class MenuOptions
---@field title? string
---@field items MenuItem[]
---@field size {width: number, height: number}
---@field on_submit? fun(item: {text: string, data?: table})

---@param opts MenuOptions
function Menu:initialize(opts)
  self.menu = NuiMenu({
    relative = 'editor',
    position = '50%',
    size = opts.size or { width = 25, height = 5 },
    border = {
      style = 'rounded',
      text = { top = opts.title, top_align = 'center' },
    },
    win_options = { winhighlight = 'Normal:Normal,FloatBorder:Normal' },
  }, {
    lines = self:_set_items(opts.items),
    max_width = 20,
    keymap = {
      focus_next = { 'k', '<Down>', '<Tab>' },
      focus_prev = { 'l', '<Up>', '<S-Tab>' },
      close = { '<Esc>', '<C-c>', 'q' },
      submit = { '<CR>', 'o' },
    },
    on_close = function() self:set_cursor_transparency('off') end,
    on_submit = function(item)
      self:set_cursor_transparency('off')
      if opts.on_submit then opts.on_submit(item) end
    end,
  })
end

function Menu:mount()
  self.original_guicursor = vim.api.nvim_get_option('guicursor')
  self.menu:mount()

  vim.cmd('IlluminatePauseBuf')
  self:set_cursor_transparency('on')
end

---@param opt "on" | "off"
function Menu:set_cursor_transparency(opt)
  if opt == 'on' then return vim.api.nvim_set_option('guicursor', 'a:CobolOutlineCursor') end
  vim.api.nvim_set_option('guicursor', self.original_guicursor)
end

---@param items MenuItem[]
function Menu:_set_items(items)
  local normalized_items = {}

  for _, item in ipairs(items) do
    if type(item) == 'string' then
      table.insert(normalized_items, NuiMenu.item(item))
    else
      table.insert(normalized_items, NuiMenu.item(item[1], item[2]))
    end
  end
  return normalized_items
end

--  ╾───────────────────────────────────────────────────────────────────────────────────╼
---@alias Menu.constructor fun(opts: MenuOptions): Menu
---@type Menu|Menu.constructor
local _Menu = Menu
return _Menu
