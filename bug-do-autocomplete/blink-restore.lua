local function is_blink_mapping(map)
  return type(map.desc) == "string" and vim.startswith(map.desc, "blink.cmp")
end

for _, mode in ipairs({ "i", "s" }) do
  for _, map in ipairs(vim.api.nvim_buf_get_keymap(0, mode)) do
    if is_blink_mapping(map) then
      pcall(vim.api.nvim_buf_del_keymap, 0, mode, map.lhs)
    end
  end
end

local mappings = require("plugins.dev.blink.mappings")
require("blink.cmp.keymap.apply").keymap_to_current_buffer(mappings)
print("blink mappings reaplicados no buffer " .. vim.api.nvim_get_current_buf())
