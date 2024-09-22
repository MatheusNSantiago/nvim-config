---@diagnostic disable: missing-fields
local safe_require = utils.api.require

utils.ft_helpers.filetype_settings({
  ['python'] = require('filetypes.python'),
  [{ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }] = require('filetypes.js'),
  ['c'] = require('filetypes.c'),
  ['java'] = require('filetypes.java'),
  -- ['markdown'] = require('filetypes.markdown'),
  ['rust'] = require('filetypes.rust'),
--  ╾───────────────────────────────────────────────────────────────────────────────────╼
  ['cobol'] = safe_require('cobol-bundle').cobol_config,
  ['copybook'] = safe_require('cobol-bundle').copybook_config,
  ['foo'] = safe_require('cobol-foo'),
})

create_picker('<leader><leader>u', 'Utilities', {
  { name = 'Icon Picker', handler = ':IconPickerNormal<CR>' },
})
