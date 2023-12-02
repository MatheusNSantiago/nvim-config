local NuiInput = require('nui.input')
local Input = NuiInput:extend('Input')

---@class InputOpts
---@field on_submit fun(value: string)
---@field on_close? fun(value: string)
---@field title? string
---@field default_value? string
---@field auto_mount? boolean

---@param opts InputOpts
function Input:init(opts)

  local popup_options = {
    relative = 'editor',
    position = '50%',
    size = { width = 20, height = 1 },
    border = {
      style = 'rounded',
      text = { top = 'Novo book', top_align = 'center' },
    },
  }

  popup_options.win_options = vim.tbl_deep_extend('force', popup_options.win_options or {}, {
    conceallevel = 2,
    concealcursor = 'nvi',
  })

  Input.super.init(self, popup_options, {
    on_submit = function(value) print(value) end,
  })

  self._.conceal_char = '*'
end

function Input:mount()
  Input.super.mount(self)

  local conceal_char = self._.conceal_char
  local prompt_length = vim.api.nvim_strwidth(vim.fn.prompt_getprompt(self.bufnr))

  vim.api.nvim_buf_call(
    self.bufnr,
    function()
      vim.cmd(string.format(
        [[
        syn region SecretValue start=/^/ms=s+%s end=/$/ contains=SecretChar
        syn match SecretChar /./ contained conceal %s
      ]],
        prompt_length,
        conceal_char and 'cchar=' .. conceal_char or ''
      ))
    end
  )
end

return Input
