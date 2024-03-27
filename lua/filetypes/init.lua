---@diagnostic disable: missing-fields

local ok, cobol_bundle = pcall(require,'cobol-bundle')
if not ok then cobol_bundle = {} end

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
