local M = {}

function M.setup()
  return {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'BufRead',
    config = M.config,
  }
end

function M.config()
  require('rainbow-delimiters.setup').setup({
    ---Query names by file type
    query = {
      [''] = 'rainbow-delimiters',
      javascript = 'rainbow-delimiters-react',
    },
    ---Highlight strategies by file type
    strategy = {
      [''] = require('rainbow-delimiters.strategy.global'),
    },
    priority = {
      [''] = 110,
    },
    -- Highlight groups in order of display
    highlight = {
      -- The colours are intentionally not in the usual order to make
      -- the contrast between them stronger
      'RainbowDelimiterYellow',
      'RainbowDelimiterRed',
      'RainbowDelimiterOrange',
      'RainbowDelimiterBlue',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    },
  })
end

return M
