local function dump(value)
  return vim.inspect(value)
end

local log_dir = vim.fn.expand("~/.config/nvim/bug-do-autocomplete")
vim.fn.mkdir(log_dir, "p")
local path = log_dir .. "/blink-dump-" .. os.date("%Y%m%d-%H%M%S") .. ".log"
local lines = {}
local function add(label, value)
  table.insert(lines, "\n## " .. label)
  table.insert(lines, type(value) == "string" and value or dump(value))
end

add("nvim", vim.version())
add("mode", vim.api.nvim_get_mode())
add("buf", {
  bufnr = vim.api.nvim_get_current_buf(),
  filetype = vim.bo.filetype,
  buftype = vim.bo.buftype,
  completion = vim.b.completion,
})

local keys = { "<CR>", "<Tab>", "<S-Tab>", "<C-space>", "<M-[>", "<M-]>" }
for _, mode in ipairs({ "i", "s", "n" }) do
  local got = {}
  for _, key in ipairs(keys) do
    got[key] = vim.fn.maparg(key, mode, false, true)
  end
  add("maparg mode=" .. mode, got)
end

local buf_maps = {}
for _, mode in ipairs({ "i", "s" }) do
  buf_maps[mode] = vim.tbl_filter(function(m)
    return m.lhs == "<CR>"
      or m.lhs == "<Tab>"
      or m.lhs == "<S-Tab>"
      or m.lhs == "<C-Space>"
      or m.lhs == "<M-[>"
      or m.lhs == "<M-]>"
      or (m.desc and m.desc:find("blink", 1, true))
  end, vim.api.nvim_buf_get_keymap(0, mode))
end
add("buffer keymaps", buf_maps)

local blink_ok, cmp = pcall(require, "blink.cmp")
if blink_ok then
  local state = {
    visible = cmp.is_visible(),
    active = cmp.is_active(),
    snippet_active = cmp.snippet_active(),
  }
  add("blink state", state)
else
  add("blink require error", cmp)
end

local copilot_ok, suggestion = pcall(require, "copilot.suggestion")
if copilot_ok then
  add("copilot state", { visible = suggestion.is_visible() })
else
  add("copilot require error", suggestion)
end

vim.fn.writefile(lines, path)
print("blink dump escrito em " .. path)
