---@type { name: string, handler: string|function }[]

return {
  { name = 'Adicionar Copybook', handler = require('filetypes.cobol.picker-actions.add-copybook') },
  { name = 'Limpar Arquivo',     handler = require('filetypes.cobol.picker-actions.clean-file') },
  { name = 'Exportar Arquivo',     handler = require('filetypes.cobol.picker-actions.export-file') },
}
