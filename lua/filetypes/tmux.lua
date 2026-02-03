---@type FiletypeSettings
return {
  on_buf_enter = function(args)
    vim.treesitter.stop(args.buf)
  end,
}
