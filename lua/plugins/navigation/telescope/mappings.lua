---@brief [[
---  You can also add other mappings using tables with `type = "command"`.
---    For example:
--- <code>
---   {
---     ...,
---     ["jj"] = { "<esc>", type = "command" },
---     ["kk"] = { "<cmd>echo \"Hello, World!\"<cr>", type = "command" },)
---     ...,
---   }
--- </code>
---
--- You can also add additional options for mappings of any type ("action" and "command").
---   For example:
--- <code>
---   {
---     ...,
---     ["<C-j>"] = {
---       actions.move_selection_next, type = "action",
---       opts = { nowait = true, silent = true }
---     },
---     ...,
---   }
--- 3. `attach_mappings` function for a particular picker.
--- <code>
---   require("telescope.builtin").find_files {
---     attach_mappings = function(_, map)
---       map("i", "asdf", function(_prompt_bufnr)
---         print "You typed asdf"
---       end)
---
---       map({"i", "n"}, "<C-r>", function(_prompt_bufnr)
---         print "You typed <C-r>"
---       end)
---
---       -- needs to return true if you want to map default_mappings and
---       -- false if not
---       return true
---     end,
---   }
--- </code>
---@brief ]]

local actions = require('telescope.actions')

return {
  i = {
    ['<C-n>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_next,
    ['<Down>'] = actions.move_selection_next,

    ['<C-l>'] = actions.move_selection_previous,
    ['<C-p>'] = actions.move_selection_previous,
    ['<Up>'] = actions.move_selection_previous,

    ['<C-c>'] = actions.close,

    ['<CR>'] = actions.select_default,
    ['<C-h>'] = actions.select_horizontal,
    ['<C-v>'] = actions.select_vertical,
    ['<C-t>'] = actions.select_tab,

    ['<C-u>'] = actions.preview_scrolling_up,
    ['<C-d>'] = actions.preview_scrolling_down,

    ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
    ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,

    -- disable c-j because we dont want to allow new lines #2123
    ['<C-j>'] = actions.nop,
  },
  n = {
    ['<C-c>'] = 'close',

    ['<ESC>'] = actions.close,
    ['<CR>'] = actions.select_default,
    ['h'] = actions.select_horizontal,
    ['v'] = actions.select_vertical,
    ['t'] = actions.select_tab,

    ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
    ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,

    ['k'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_next,
    ['<Down>'] = actions.move_selection_next,

    ['l'] = actions.move_selection_previous,
    ['<C-l>'] = actions.move_selection_previous,
    ['<Up>'] = actions.move_selection_previous,

    ['H'] = actions.move_to_top,
    ['M'] = actions.move_to_middle,
    ['L'] = actions.move_to_bottom,

    ['gg'] = actions.move_to_top,
    ['G'] = actions.move_to_bottom,

    ['<C-u>'] = actions.preview_scrolling_up,
    ['<C-d>'] = actions.preview_scrolling_down,

    ['?'] = actions.which_key,
  },
}
