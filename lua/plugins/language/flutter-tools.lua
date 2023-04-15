local M = {}

function M.setup()
    vim.cmd([[command! Flutter lua require("telescope").extensions.flutter.commands() ]])

    return {
        "akinsho/flutter-tools.nvim",
        config = M.config,
    }
end

function M.config()
    local flutter_tools = require("flutter-tools")
    flutter_tools.setup({
        ui = {
            border = "rounded", -- e.g. "single" | "shadow" | {<table-of-eight-chars>}
            notification_style = "plugin",
        },
        debugger = {
            -- enabled = true,
            -- run_via_dap = true,
        },
        -- outline = { auto_open = false },
        decorations = {
            statusline = {
                device = true, -- {flutter_tools_decorations.app_version} lualine
                app_version = true, -- {flutter_tools_decorations.device} lualine
            },
        },
        widget_guides = { enabled = true },
        -- dev_log = { enabled = false, open_cmd = "tabedit" },
        lsp = {
            -- color = {
            -- 	enabled = true,
            -- 	background = true,
            -- 	virtual_text = false,
            -- },
            -- settings = {
            -- 	showTodos = true,
            -- 	renameFilesWithClasses = "prompt",
            -- },
            -- on_attach = require("plugins.lsp").on_attach,
            -- capabilities = require("plugins.lsp").capabilities,
        },
    })
end

return M
