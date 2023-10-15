local M = {}

M.commands = function()
  vim.cmd('silent DisableHLIndent')

  utils.api.augroup('cobol', {
    event = 'VimLeavePre',
    desc = 'kill cobol_ls when exiting nvim',
    command = 'silent !killall server-linux',
  })
end

M.opt = {
  colorcolumn = '7,11,73,80',
}

M.mappings = {
  { 'n',          '<leader>r',  function() M._run_code() end },
  { { 'n', 'v' }, '<leader>cl', function() require('comment-box').line(5) end },
  { { 'n', 'v' }, '<leader>cb', require('comment-box').cbox },
}

M.plugins = {
  ['comment-box'] = function(plugin)
    plugin.setup({
      box_width = 64, -- width of the boxes
      line_width = 72, -- width of the lines
    })
  end,
  Comment = function(plugin)
    plugin.setup({
      sticky = true,
      pre_hook = function() return '%s' end, -- previnir o default "     *%s" (que não funfava)
      post_hook = function(ctx)           -- cria um toggle comment functional
        local row_start = ctx.range.srow
        local row_end = ctx.range.erow

        local lines = vim.api.nvim_buf_get_lines(0, row_start - 1, row_end, false)
        for i, line in ipairs(lines) do
          local is_populated = #line > 7

          if is_populated then
            local is_commented = string.sub(line, 7, 7) == '*'

            local replacement_char = is_commented and ' ' or '*'
            -- coloca o replacement_char na posição 7
            lines[i] = string.sub(line, 0, 6) .. replacement_char .. string.sub(line, 8, #line)
          end
        end

        vim.api.nvim_buf_set_lines(0, row_start - 1, row_end, false, lines)
      end,
    })
  end,
}

M._run_code = function()
  local file_path = vim.fn.expand('%:p')
  local filename_without_extension = vim.fn.expand('%:t:r')

  local cmd_compile = 'cobc -xO ' .. '"' .. file_path .. '"'
  local cmd_run = './' .. filename_without_extension
  local cmd_remove_exec = 'rm ' .. filename_without_extension

  local cmd = cmd_compile .. ' && ' .. cmd_run .. ' && ' .. cmd_remove_exec

  vim.cmd('w')
  vim.cmd(("TermExec cmd='%s'"):format(cmd))
  vim.schedule(function() vim.cmd('wincmd j') end) -- Go to bottom terminal
end

return {
  commands = M.commands,
  opt = M.opt,
  mappings = M.mappings,
  plugins = M.plugins,
}
