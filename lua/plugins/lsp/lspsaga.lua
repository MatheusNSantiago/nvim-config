local M = {}

function M.setup()
    return {
        'glepnir/lspsaga.nvim',
        commit = '4f075452c466df263e69ae142f6659dcf9324bf6',
        config = M.config,
    }
end

function M.config()
    require('lspsaga').setup({
        scroll_preview = {
            scroll_down = '<C-d>',
            scroll_up = '<C-u>',
        },
        request_timeout = 3000,
        ui = {
            title = true,
            -- Border type can be single, double, rounded, solid, shadow.
            border = 'single',
            winblend = 0,
            expand = '',
            collapse = '',
            code_action = '💡',
            incoming = ' ',
            outgoing = ' ',
            hover = ' ',
            kind = {},
        },
        definition = {
            width = 0.6,
            height = 0.5,
            keys = {
                edit = '<C-c>o',
                vsplit = '<C-c>v',
                split = '<C-c>h',
                tabe = '<C-c>t',
                quit = 'q',
                close = '<C-c>k',
            },
        },
        symbol_in_winbar = {
            enable = false,
            separator = ' ',
            ignore_patterns = {},
            hide_keyword = true,
            show_file = true,
            folder_level = 1,
            respect_root = false,
            color_mode = true,
        },
        rename = {
            quit = '<C-c>',
            exec = '<CR>',
            mark = 'x',
            confirm = '<CR>',
            in_select = true,
        },
        lightbulb = {
            enable = true,
            sign = true,
            debounce = 10,
            sign_priority = 40,
            virtual_text = false,
            enable_in_insert = true,
        },
        code_action = {
            num_shortcut = true,
            show_server_name = false,
            extend_gitsigns = false,
            keys = {
                -- string | table type
                quit = 'q',
                exec = '<CR>',
            },
        },
        finder = {
            --percentage
            max_height = 0.5,
            force_max_height = false,
            keys = {
                jump_to = 'p',
                edit = { 'o', '<CR>' },
                vsplit = 'v',
                split = 'h',
                tabe = 't',
                tabnew = 'r',
                quit = { 'q', '<ESC>' },
                close_in_preview = '<ESC>',
            },
        },
        implement = {
            enable = true,
            sign = true,
            virtual_text = true,
            priority = 100,
        },
        diagnostic = {
            show_code_action = true,
            show_layout = 'float',
            show_normal_height = 10,
            jump_num_shortcut = true,
            max_width = 0.8,
            max_height = 0.6,
            max_show_width = 0.9,
            max_show_height = 0.6,
            text_hl_follow = true,
            border_follow = true,
            extend_relatedInformation = false,
            diagnostic_only_current = false,
            keys = {
                exec_action = 'o',
                quit = 'q',
                toggle_or_jump = '<CR>',
                quit_in_show = { 'q', '<ESC>' },
            },
        },
    })
end

return M
