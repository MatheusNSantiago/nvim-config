local M = {}

function M.setup()
    return {
        "lukas-reineke/indent-blankline.nvim",
        config = M.config,
    }
end

function M.config()
  require("indent_blankline").setup({
    char = "┊",
    show_trailing_blankline_indent = false,
    buftype_exclude = { "terminal", "telescope", "nofile" },
    filetype_exclude = { "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float" },
    show_current_context = true,
    show_current_context_start = false,
    show_end_of_line = false,
    space_char_blankline = " ",
    use_treesitter = true,
  })
end


M.highlights = {
  -- hl(0, "IndentBlanklineContextChar", { fg = c.context, bg = "NONE" })
  -- hl(0, "IndentBlanklineContextStart", { fg = "NONE", bg = "NONE", underline = true })
  -- hl(0, "IndentBlanklineChar", { fg = c.dark_gray, bg = "NONE" })
}

return M
