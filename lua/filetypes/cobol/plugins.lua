local U = require('filetypes.cobol.utils')
return {
  ['comment-box'] = function(plugin) plugin.setup({ box_width = 64, line_width = 64 }) end,
  ['Comment'] = function(plugin)
    plugin.setup({

      sticky = true,
      pre_hook = function() return '%s' end, -- previnir o default "     *%s" (que não funfava)
      --- cria um toggle comment functional
      post_hook = function(ctx)
        if vim.bo.filetype ~= 'cobol' then return end

        local row_start = ctx.range.srow
        local row_end = ctx.range.erow

        U.comment_lines(row_start, row_end)
      end,
    })
  end,
}
