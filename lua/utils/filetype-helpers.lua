local M = {}

---@param args {[1]: string | string[], [2]: string, [3]: string|function, [string]: boolean | integer}[]
---@param buf integer
local function apply_ft_mappings(args, buf)
  for _, m in ipairs(args) do
    assert(m[1] and m[2] and m[3], 'map args must be a table with at least 3 items')

    local opts = utils.fold(function(acc, item, key)
      if type(key) == 'string' then acc[key] = item end
      return acc
    end, m, { buffer = buf })

    utils.api.keymap(m[1], m[2], m[3], opts)
  end
end

---A convenience wrapper that calls the ftplugin config for a plugin if it exists
---and warns me if the plugin is not installed
---@param configs table<string, fun(module: table)>
function M.ftplugin_conf(configs)
  if type(configs) ~= 'table' then return end

  for name, callback in pairs(configs) do
    local ok, plugin = utils.pcall(require, name)
    if ok then callback(plugin) end
  end
end

---@class FiletypeSettings
---@field opt? vim.opt
---@field mappings {[1]: string | string[], [2]: string, [3]: string|function, [string]: any }[]
---@field plugins? {[string]: fun(module: table)}
---@field on_buf_enter? fun(args: AutocmdArgs)
---@field picker? {keymap: string, title: string, actions_tbl: {name: string, handler: function | string}}
---@field autocommands? Autocommand[]

---Define filetype settings in a single place, then creating FileType autocommands from this definition
---@param map { [string[] | string ]: FiletypeSettings }
function M.filetype_settings(map)
  local commands = utils.map(map, function(settings, ft)
    ---@diagnostic disable-next-line: param-type-mismatch
    local name = type(ft) == 'string' and ft or table.concat(ft, ',')

    return {
      event = 'FileType',
      pattern = ft,
      desc = ('ft settings for %s'):format(name),
      command = function(args)
        for scope, value in pairs(settings) do
          utils.switch(scope, {
            mappings = function() apply_ft_mappings(value, args.buf) end,
            on_buf_enter = vim.schedule_wrap(value),
            plugins = function() M.ftplugin_conf(value) end,
            opt = function()
              for option, setting in pairs(value) do
                vim.opt_local[option] = setting
              end
            end,
            picker = function() create_picker(value.keymap, value.title, value.actions_tbl) end,
            autocommands = function() utils.api.augroup(name, unpack(value)) end,
          })
        end
      end,
    }
  end)

  utils.api.augroup('filetype-settings', unpack(commands))
end

return M
