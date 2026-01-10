local M = {}

local uv = vim.uv
local watcher = nil
local debounce_timer = nil
local on_change_handlers = {}

---Helper de debounce para prevenir múltiplos callbacks em sequência
---@param fn function
---@param delay number
---@return function
local debounce = function(fn, delay)
  return function(...)
    local args = { ... }
    if debounce_timer then
      debounce_timer:close()
    end
    debounce_timer = vim.defer_fn(function()
      debounce_timer = nil
      fn(unpack(args))
    end, delay)
  end
end

---Registra um handler nomeado para ser chamado quando arquivos mudarem
---Se um handler com o mesmo nome existir, ele será substituído
---Nota: Handlers nomeados são necessários para suportar Lua hotreload
---@param name string Nome único do handler
---@param handler fun(filepath: string, events: table) Função callback chamada quando arquivo mudar
M.registerOnChangeHandler = function(name, handler)
  on_change_handlers[name] = handler
end

---@class DirectoryWatcherOpts
---@field path string? Caminho do diretório para monitorar
---@field debounce number? Delay em ms para debounce (padrão: 100)

---Inicia o monitoramento de um diretório para mudanças em arquivos
---@param opts DirectoryWatcherOpts?
---@return boolean Retorna true se o watcher foi iniciado com sucesso
M.setup = function(opts)
  opts = opts or {}
  local path = opts.path
  local debounce_delay = opts.debounce or 100 -- ms

  if not path then
    return false
  end

  -- Para o watcher existente se houver algum
  if watcher then
    M.stop()
  end

  -- Cria handle fs_event
  local fs_event = uv.new_fs_event()
  if not fs_event then
    return false
  end

  -- Callback com debounce para mudanças em arquivos
  local on_change = debounce(function(err, filename, events)
    if err then
      M.stop()
      return
    end

    if filename then
      local full_path = path .. '/' .. filename

      -- Chama todos os handlers registrados
      for _, handler in pairs(on_change_handlers) do
        pcall(handler, full_path, events)
      end
    end
  end, debounce_delay)

  -- Inicia o monitoramento (wrapped para thread safety)
  local ok, _ = fs_event:start(path, { recursive = false }, vim.schedule_wrap(on_change))

  if ok ~= 0 then
    return false
  end

  watcher = fs_event
  return true
end

---Para o watcher e limpa os recursos
M.stop = function()
  if watcher then
    watcher:stop()
    watcher = nil
  end

  if debounce_timer then
    debounce_timer:close()
    debounce_timer = nil
  end
end

return M
