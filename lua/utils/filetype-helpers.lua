local M = {}

---@class FiletypeSettings
---@field g table<string, any>
---@field bo vim.bo
---@field wo vim.wo
---@field opt vim.opt
---@field plugins {[string]: fun(module: table)}

---@param args {[1]: string, [2]: string, [3]: string, [string]: boolean | integer}[]
---@param buf integer
local function apply_ft_mappings(args, buf)
  utils.foreach(function(m)
    assert(m[1] and m[2] and m[3], 'map args must be a table with at least 3 items')

    local opts = utils.fold(function(acc, item, key)
      if type(key) == 'string' then acc[key] = item end
      return acc
    end, m, { buffer = buf })

    utils.api.keymap(m[1], m[2], m[3], opts)
  end, args)
end

--- A convenience wrapper that calls the ftplugin config for a plugin if it exists
--- and warns me if the plugin is not installed
---@param configs table<string, fun(module: table)>
function M.ftplugin_conf(configs)
  if type(configs) ~= 'table' then return end
  for name, callback in pairs(configs) do
    local ok, plugin = M.pcall(require, name)
    if ok then callback(plugin) end
  end
end

--- This function is an alternative API to using ftplugin files. It allows defining
--- filetype settings in a single place, then creating FileType autocommands from this definition
---
--- e.g.
--- ```lua
---   as.filetype_settings({
---     lua = {
---      opt = {foldmethod = 'expr' },
---      bo = { shiftwidth = 2 }
---     },
---    [{'c', 'cpp'}] = {
---      bo = { shiftwidth = 2 }
---    }
---   })
--- ```
--- One future idea is to generate the ftplugin files from this function, so the settings are still
--- centralized but the curation of these files is automated. Although I'm not sure this actually
--- has value over autocommands, unless ftplugin files specifically have that value
---
--@param map {[string|string[]]: FiletypeSettings | {[integer]: fun(args: AutocmdArgs)}}
function M.filetype_settings(map)
  local commands = utils.map(function(settings, ft)
    ---@diagnostic disable-next-line: param-type-mismatch
    local name = type(ft) == 'string' and ft or table.concat(ft, ',')

    return {
      pattern = ft,
      event = 'FileType',
      desc = ('ft settings for %s'):format(name),
      command = function(args)
        utils.foreach(function(value, scope)
          if scope == 'commands' then return value() end
          if scope == 'opt' then scope = 'opt_local' end
          if scope == 'mappings' then return apply_ft_mappings(value, args.buf) end
          if scope == 'plugins' then return M.ftplugin_conf(value) end

          utils.foreach(function(setting, option) vim[scope][option] = setting end, value)
        end, settings)
      end,
    }
  end, map)

  utils.api.augroup('filetype-settings', unpack(commands))
end

return M
