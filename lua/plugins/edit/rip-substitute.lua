local M = {}

function M.setup()
	return {
		'chrisgrieser/nvim-rip-substitute',
		config = M.config,
		keys = {
			{
				'<leader>sr',
				function() require('rip-substitute').sub() end,
				desc = 'rip-substitute: [S]earch and [R]eplace',
				mode = { 'n', 'x' },
			},
		},
	}
end

function M.config()
  -- default settings
  require('rip-substitute').setup({
    popupWin = {
      title = ' rip-substitute',
      border = 'single',
      matchCountHlGroup = 'Keyword',
      noMatchHlGroup = 'ErrorMsg',
      hideSearchReplaceLabels = false,
      position = 'bottom', -- "top"|"bottom"
    },
    prefill = {
      normal = 'cursorWord',      -- "cursorWord"|false
      visual = 'selectionFirstLine', -- "selectionFirstLine"|false
      startInReplaceLineIfPrefill = false,
    },
    keymaps = {
      -- normal & visual mode
      confirm = '<CR>',
      abort = 'q',
      prevSubstitutionInHistory = '<Up>',
      nextSubstitutionInHistory = '<Down>',
      openAtRegex101 = 'R',
      insertModeConfirm = '<C-CR>', -- (except this one, obviously)
    },
    incrementalPreview = {
      matchHlGroup = 'IncSearch',
      rangeBackdrop = {
        enabled = true,
        blend = 50, -- between 0 and 100
      },
    },
    regexOptions = {
      -- pcre2 enables lookarounds and backreferences, but performs slower
      pcre2 = true,
      ---@type "case-sensitive"|"ignore-case"|"smart-case"
      casing = 'case-sensitive',
      -- disable if you use named capture groups (see README for details)
      autoBraceSimpleCaptureGroups = true,
    },
    editingBehavior = {
      -- Experimental. When typing `()` in the `search` line, automatically
      -- adds `$n` to the `replace` line.
      autoCaptureGroups = false,
    },
  })
end

return M
