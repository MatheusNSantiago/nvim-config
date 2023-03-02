-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')



local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>sgf', builtin.git_files, { desc = "[S]each [G]it [F]iles" })


-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><leader>r', builtin.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-k>"] = "move_selection_next",
                ["<C-l>"] = "move_selection_previous",

                ["<CR><CR>"] = "select_default",
                ["<C-h>"] = "which_key"
            },
            n = {
                ["t"] = "select_tab",
                ["<C-k>"] = "move_selection_next",
                ["k"] = "move_selection_next",
                ["<C-l>"] = "move_selection_previous",
                ["l"] = "move_selection_previous",
                ["v"] = "select_vertical",
            }

        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}
