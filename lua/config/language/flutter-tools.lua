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
        debugger = {
            -- enabled = true,
            -- run_via_dap = true,
        },
        -- outline = { auto_open = false },
        -- decorations = {
        -- 	statusline = { device = true, app_version = true },
        -- },
        -- widget_guides = { enabled = true, debug = true },
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
            -- on_attach = require("config.lsp").on_attach,
            -- capabilities = require("config.lsp").capabilities,
        },
    })

end

return M
