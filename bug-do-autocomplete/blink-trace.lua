local state = rawget(_G, "__blink_keymap_trace") or {}
_G.__blink_keymap_trace = state

if state.installed then
  print("blink trace já instalado: " .. state.path)
  return
end

state.installed = true
local log_dir = vim.fn.expand("~/.config/nvim/bug-do-autocomplete")
vim.fn.mkdir(log_dir, "p")
state.path = log_dir .. "/blink-trace-" .. os.date("%Y%m%d-%H%M%S") .. ".log"
state.originals = {
  nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap,
  nvim_buf_del_keymap = vim.api.nvim_buf_del_keymap,
  nvim_set_keymap = vim.api.nvim_set_keymap,
  nvim_del_keymap = vim.api.nvim_del_keymap,
  keymap_set = vim.keymap.set,
  keymap_del = vim.keymap.del,
}

local function matches(lhs, opts)
  if lhs == "<CR>" or lhs == "<Tab>" or lhs == "<S-Tab>" or lhs == "<C-space>" then
    return true
  end
  if type(opts) == "table" and type(opts.desc) == "string" and opts.desc:find("blink", 1, true) then
    return true
  end
  return false
end

local function append(event, payload)
  local lines = {
    "",
    "## " .. os.date("%Y-%m-%d %H:%M:%S") .. " " .. event,
    vim.inspect(payload),
    debug.traceback("stack", 3),
  }
  vim.fn.writefile(lines, state.path, "a")
end

vim.api.nvim_buf_set_keymap = function(bufnr, mode, lhs, rhs, opts)
  if matches(lhs, opts) then
    append("nvim_buf_set_keymap", { bufnr = bufnr, mode = mode, lhs = lhs, opts = opts })
  end
  return state.originals.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

vim.api.nvim_buf_del_keymap = function(bufnr, mode, lhs)
  if matches(lhs) then
    append("nvim_buf_del_keymap", { bufnr = bufnr, mode = mode, lhs = lhs })
  end
  return state.originals.nvim_buf_del_keymap(bufnr, mode, lhs)
end

vim.api.nvim_set_keymap = function(mode, lhs, rhs, opts)
  if matches(lhs, opts) then
    append("nvim_set_keymap", { mode = mode, lhs = lhs, opts = opts })
  end
  return state.originals.nvim_set_keymap(mode, lhs, rhs, opts)
end

vim.api.nvim_del_keymap = function(mode, lhs)
  if matches(lhs) then
    append("nvim_del_keymap", { mode = mode, lhs = lhs })
  end
  return state.originals.nvim_del_keymap(mode, lhs)
end

vim.keymap.set = function(mode, lhs, rhs, opts)
  if matches(lhs, opts) then
    append("vim.keymap.set", { mode = mode, lhs = lhs, opts = opts })
  end
  return state.originals.keymap_set(mode, lhs, rhs, opts)
end

vim.keymap.del = function(mode, lhs, opts)
  if matches(lhs, opts) then
    append("vim.keymap.del", { mode = mode, lhs = lhs, opts = opts })
  end
  return state.originals.keymap_del(mode, lhs, opts)
end

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave", "ModeChanged", "BufEnter", "User" }, {
  callback = function(args)
    if args.event == "User" and not tostring(args.match):find("Blink", 1, true) then
      return
    end
    local cr = vim.fn.maparg("<CR>", "i", false, true)
    local tab = vim.fn.maparg("<Tab>", "i", false, true)
    append("event " .. args.event, {
      event = args.event,
      match = args.match,
      buf = args.buf,
      mode = vim.api.nvim_get_mode(),
      insert_cr = cr,
      insert_tab = tab,
      filetype = vim.bo[args.buf].filetype,
      buftype = vim.bo[args.buf].buftype,
    })
  end,
})

append("trace installed", { path = state.path, buf = vim.api.nvim_get_current_buf() })
print("blink trace instalado: " .. state.path)
