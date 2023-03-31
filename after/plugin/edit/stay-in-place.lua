local sip = require("stay-in-place")

sip.setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    set_keymaps = false,
})

vim.keymap.set("n", ">", sip.shift_right, { noremap = true, expr = true })
vim.keymap.set("n", "<", sip.shift_left, { noremap = true, expr = true })
vim.keymap.set("n", "=", sip.filter, { noremap = true, expr = true })


vim.keymap.set("n", ">", sip.shift_right_line, { noremap = true })
vim.keymap.set("n", "<", sip.shift_left_line, { noremap = true })
vim.keymap.set("n", "==", sip.filter_line, { noremap = true })

vim.keymap.set("x", ">", sip.shift_right_visual, { noremap = true })
vim.keymap.set("x", "<", sip.shift_left_visual, { noremap = true })
vim.keymap.set("x", "=", sip.filter_visual, { noremap = true })
