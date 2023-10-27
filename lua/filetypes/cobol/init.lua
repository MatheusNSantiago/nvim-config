return {
  commands = require('filetypes.cobol.commands'),
  mappings = require('filetypes.cobol.mappings'),
  plugins = require('filetypes.cobol.plugins'),
  opt = {
    colorcolumn = '7,11,73,80',
    commentstring = '      *%s',
    -- cria as stop word motion '_', '@' e '-' (não sei como setou o -, mas é a vida ;-;)
    iskeyword = '@,48-57,_,192-255',
    -- iskeyword = '48-57',
  },
}
