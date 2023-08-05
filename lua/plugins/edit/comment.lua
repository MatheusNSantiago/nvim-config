local M = {}
function M.setup()
  return {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = M.config,
    keys = { { 'gc', mode = { 'n', 'v' } }, { 'gcc', mode = { 'n', 'v' } }, { 'gbc', mode = { 'n', 'v' } } },
  }
end

function M.config()
  require('Comment').setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      -- line = '<leaer><leader>;',-- Line-comment toggle keymap
      -- block = 'ctrl-:', -- Block-comment toggle keymap
    },
    -- -LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      -- -Line-comment keymap
      -- line = '<leader>;',
      -- -Block-comment keymap
      -- block = '<leader>b',
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      -- above = ';O',
      -- -Add comment on the line below
      -- below = ';o',
      -- -Add comment at the end of line
      -- eol = '<leader>;A',
    },
    ---Enable keybindings
    mappings = {
      -- -Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

    ---Function to call after (un)comment
    -- post_hook = nil,
  })
end

return M
