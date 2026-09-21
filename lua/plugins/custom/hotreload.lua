---inspiração: https://github.com/diogo464/hotreload.nvim
local M = {}

---Verifica se é seguro checar/recarregar arquivos no modo atual
---@return boolean
local function should_check()
	local mode = vim.api.nvim_get_mode().mode
	return not (
		mode:match('[cR!s]') -- Pula: modos command-line, replace, ex, select
		or vim.fn.getcmdwintype() ~= '' -- Pula: janela de command-line está aberta
	)
end

---Verifica se um buffer deve ser recarregado
---@param buf number Buffer handle
---@return boolean
local function should_reload_buffer(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
	local modified = vim.api.nvim_get_option_value('modified', { buf = buf })
	local is_real_file = name ~= '' and not name:match('^%w+://') -- Pula URIs como diffview://, fugitive://, etc

	return is_real_file and buftype == '' and not modified
end

---Retorna tabela com buffers visíveis na tab atual
---@return table<number, boolean>
local function get_visible_buffers()
	local visible = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		visible[vim.api.nvim_win_get_buf(win)] = true
	end
	return visible
end

---Encontra um buffer pelo filepath
---@param filepath string
---@return number? Buffer handle ou nil se não encontrado
local find_buffer_by_filepath = function(filepath)
	local visible_buffers = get_visible_buffers()
	for buf, _ in pairs(visible_buffers) do
		if vim.api.nvim_buf_get_name(buf) == filepath then return buf end
	end
	return nil
end

-- Registra handler para mudanças em arquivos no diretório monitorado
U.directory_watcher.registerOnChangeHandler('hotreload', function(filepath, _)
	if not should_check() then return end

	local buf = find_buffer_by_filepath(filepath)
	if buf and should_reload_buffer(buf) then vim.cmd('checktime ' .. buf) end
end)

---Auto-reload de buffers quando arquivos mudarem no disco
---
---Recarrega automaticamente buffers visíveis quando:
--- - Arquivos são modificados externamente (ex: por Claude Code, git, etc)
--- - Você ganha foco no terminal (FocusGained)
--- - Você muda de buffer ou janela (BufEnter, WinEnter)
--- - O cursor fica parado (CursorHold, CursorHoldI)
---
---Proteções:
--- - Não recarrega buffers modificados (preserva suas mudanças não salvas)
--- - Não recarrega buffers especiais (URIs como diffview://, fugitive://)
--- - Pula em modos inseguros (command-line, replace, ex, select)

---Fecha buffers de arquivos deletados no disco (com confirmação diferida).
---O delay evita falso-positivo com saves atômicos (write tmp + rename),
---onde o path some por milissegundos. Só fecha buffers sem mudanças.
local pending_deletes = {} ---@type table<number, boolean>
local function handle_possibly_deleted(buf, name)
	if pending_deletes[buf] then return end
	pending_deletes[buf] = true
	vim.defer_fn(function()
		pending_deletes[buf] = nil
		if not vim.api.nvim_buf_is_valid(buf) then return end
		if not should_reload_buffer(buf) then return end -- usuário editou nesse meio-tempo: mantém
		if vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf)) ~= nil then return end -- reapareceu: mantém
		vim.notify('Arquivo deletado no disco, fechando buffer: ' .. name, vim.log.levels.WARN)
		pcall(vim.api.nvim_buf_delete, buf, { force = false }) -- dispara didClose no LSP
	end, 1000)
end

---Checa timestamps de todos os buffers reais.
---Um :checktime sem argumento só checa o buffer atual, então buffers em
---background (ex: arquivo que um agente editou enquanto você olha outro)
---ficariam com conteúdo stale e o LSP nunca receberia didChange.
local function check_all_buffers()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and should_reload_buffer(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			if vim.uv.fs_stat(name) == nil then
				handle_possibly_deleted(buf, name)
			else
				pcall(vim.cmd, 'checktime ' .. buf)
			end
		end
	end
end

M.setup = function()
	U.api.augroup('hotreload', {
		event = { 'FocusGained', 'TermLeave', 'BufEnter', 'WinEnter', 'CursorHold', 'CursorHoldI' },
		command = function()
			if should_check() then check_all_buffers() end
		end,
	})
end

return M
