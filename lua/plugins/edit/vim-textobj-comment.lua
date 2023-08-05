local M = {}

function M.setup()
  return {
    'glts/vim-textobj-comment',
    dependencies = { 'kana/vim-textobj-user', 'kana/vim-operator-user' },
    config = M.config,
    keys = {
      { 'ax', '<Plug>(textobj-comment-a)', mode = { 'x', 'o' } },
      { 'ix', '<Plug>(textobj-comment-i)', mode = { 'x', 'o' } },
    },
  }
end

function M.config() vim.g.textobj_comment_no_default_key_mappings = 1 end

return M
