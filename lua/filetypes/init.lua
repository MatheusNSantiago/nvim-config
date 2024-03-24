---@diagnostic disable: missing-fields

local cobol_bundle = require('cobol-bundle')

utils.ft_helpers.filetype_settings({
  ['python'] = require('filetypes.python'),
  [{ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }] = require('filetypes.js'),
  ['c'] = require('filetypes.c'),
  ['cobol'] = cobol_bundle.cobol_config,
  ['copybook'] = cobol_bundle.copybook_config,
  ['foo'] = require("cobol-foo"),
})

create_picker('<leader><leader>u', 'Utilities', {
  { name = 'Icon Picker',  handler = ':IconPickerNormal<CR>' },
})
