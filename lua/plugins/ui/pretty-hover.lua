local M = {}

function M.setup()
  return {
    'Fildo7525/pretty_hover',
    config = M.config,
  }
end

function M.config()
  require('pretty_hover').setup({
    -- Tables grouping the detected strings and using the markdown highlighters.
    header = {
      detect = { '[\\@]class' },
      styler = '###',
    },
    line = {
      detect = { '[\\@]brief' },
      styler = '**',
    },
    listing = {
      detect = { '[\\@]lia' },
      styler = ' - ',
    },
    references = {
      detect = {
        '[\\@]ref',
        '[\\@]c',
        '[\\@]name',
      },
      styler = { '**', '`' },
    },
    word = {
      detect = {
        '[\\@]param',
        '[\\@]tparam',
        '[\\@]see',
        '[\\@]*param*', -- For lua
      },
      styler = '`',
    },

    -- Tables used for cleaner identification of hover segments.
    code = {
      start = { '[\\@]code' },
      ending = { '[\\@]endcode' },
    },
    return_statement = {
      '[\\@]return',
      '[\\@]*return*',
    },

    -- Highlight groups used in the hover method. Feel free to define your own highlight group.
    hl = {
      error = {
        color = '#DC2626',
        detect = { '[\\@]error', '[\\@]bug' },
        line = false, -- Flag detecting if the whole line should be highlighted
      },
      warning = {
        color = '#FBBF24',
        detect = { '[\\@]warning', '[\\@]thread_safety', '[\\@]throw' },
        line = false,
      },
      info = {
        color = '#2563EB',
        detect = { '[\\@]remark', '[\\@]note', '[\\@]notes' },
      },
    },

    border = 'rounded',
    max_width = nil,
    max_height = nil,
  })
end

return M
