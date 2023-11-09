local Input = require('nui.input')

---@class InputOpts
---@field on_submit fun(value: string)
---@field on_close? fun(value: string)
---@field title? string
---@field default_value? string
---@field auto_mount? boolean

---@param opts InputOpts
return function(opts)
  local input = Input({
    relative = 'cursor',
    position = { row = -1, col = 0 },
    size = { width = 20, height = 1 },
    border = {
      style = 'rounded',
      text = { top = opts.title, top_align = 'center' },
    },
  }, {
    on_submit = opts.on_submit,
    on_close = opts.on_close,
    default_value = opts.default_value,
  })
  if opts.auto_mount then input:mount() end

  input:on('BufLeave', function() input:unmount() end)

  input:map('n', 'q', function() input:unmount() end)
  input:map('i', '<C-c>', function() input:unmount() end)

  return input
end
