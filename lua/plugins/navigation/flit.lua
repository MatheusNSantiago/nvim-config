local M = {}

function M.setup()
  return {
    'ggandor/flit.nvim',
    dependencies = { 'ggandor/leap.nvim' },
    config = M.config,
  }
end

function M.config()
  require('flit').setup({
    keys = { f = 'f', F = 'F', t = 't', T = 'T' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = 'v',
    multiline = false,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {},
  })
end

return M
