local M = {}

function M.setup()
  return {
    'andymass/vim-matchup',
    event = { 'BufReadPost' },
    config = M.config,
  }
end

function M.config() end

M.highlights = {
  MatchParen = { link = 'CursorLine' },
}

return M
