local lazy_require = U.lazy_require

vim.filetype.add({ extension = { ['cpy'] = 'copybook' } })

local settings_map = {
  ['python'] = lazy_require('filetypes.python'),
  ['javascript'] = lazy_require('filetypes.javascript'),
  ['typescript'] = lazy_require('filetypes.typescript'),
  ['typescriptreact'] = lazy_require('filetypes.typescript'),
  ['c'] = lazy_require('filetypes.c'),
  ['java'] = lazy_require('filetypes.java'),
  ['markdown'] = lazy_require('filetypes.markdown'),
  ['rust'] = lazy_require('filetypes.rust'),
  --  ╾───────────────────────────────────────────────────────────────────────────────────╼
  ['cobol'] = lazy_require('cobol-bundle', 'cobol_config'),
  ['copybook'] = lazy_require('cobol-bundle', 'copybook_config'),
  ['foo'] = lazy_require('cobol-foo'),
}

local filetypes = vim.tbl_keys(settings_map)

local get_settings = function()
  local _get_settings = settings_map[vim.bo.ft]
  return _get_settings()
end

U.api.augroup('filetype_configs', {
  event = { 'BufEnter' },
  command = function(args)
    if not vim.tbl_contains(filetypes, vim.bo.filetype) then
      return
    end

    local settings = get_settings()
    for scope, value in pairs(settings) do
      local apply = U.switch(scope, {
        on_buf_enter = vim.schedule_wrap(function() value(args) end),
        picker = function()
          -- hack pra atualizar o picker quando muda o buffer
          -- U.api.augroup('filetype_picker', {
          --   event = 'BufEnter',
          --   command = function()
            if not vim.tbl_contains(filetypes, vim.bo.ft) then return end
            value = get_settings().picker
            if not value then return end
            create_picker({ keymap = value.keymap, title = value.title, actions = value.actions })
            -- end,
          -- })
        end,
        plugins = function()
          if type(value) ~= 'table' then return end
          for pkg, callback in pairs(value) do
            local ok, plugin = utils.pcall(require, pkg)
            if ok then callback(plugin) end
          end
        end,
        bo = function()
          for option, setting in pairs(value) do
            vim.bo[option] = setting
          end
        end,
        opt = function()
          for option, setting in pairs(value) do
            vim.opt_local[option] = setting
          end
        end,
        mappings = function()
          Array(value):foreach(function(m)
            assert(m[1] and m[2] and m[3], 'mappings devem ter no mínimo 3 items')

            local opts = utils.fold(function(acc, item, key)
              if type(key) == 'string' then acc[key] = item end
              return acc
            end, m, { buffer = args.buf })

            U.api.keymap(m[1], m[2], m[3], opts)
          end)
        end,
        autocommands = function()
          local commands = value
          U.api.augroup('filetype_aucommands', unpack(commands))
        end,
      })
      if apply then apply() end
    end
  end,
})

---@class FiletypeSettings
---@field on_buf_enter fun(args: AutocmdArgs)
---@field picker CreatePickerSettings
---@field plugins table<string, fun(plugin: any)>
---@field bo vim.bo
---@field opt table<string, any>
---@field mappings table<string, string>
---@field autocommands table<string, string | fun(args: AutocmdArgs)>
