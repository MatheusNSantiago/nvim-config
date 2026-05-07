-- Wrapper que recria a UX do :TSInstall + auto_install antigos para parsers locais.
-- Cada filetype registrado: ao abrir o arquivo, se o .so não existe ainda em
-- ~/.cache/tree-sitter/lib/, roda `tree-sitter build` automaticamente e ativa.

local M = {}

local registry = {}
local building = {}
local cache_dir = vim.fn.expand('~/.cache/tree-sitter/lib/')

local function so_path(name) return cache_dir .. name .. '.so' end

local function is_built(name) return vim.fn.filereadable(so_path(name)) == 1 end

local function activate(name)
	if not is_built(name) then return false end
	local ok = pcall(vim.treesitter.language.add, name, { path = so_path(name) })
	return ok
end

local function build(name, on_done)
	if building[name] then return end
	local source = registry[name]
	if not source then return end

	building[name] = true
	vim.notify('[local-parsers] building ' .. name .. '...', vim.log.levels.INFO)

	vim.fn.jobstart({ 'tree-sitter', 'build' }, {
		cwd = source,
		on_exit = function(_, code)
			building[name] = nil
			vim.schedule(function()
				if code ~= 0 then
					vim.notify('[local-parsers] failed to build ' .. name, vim.log.levels.ERROR)
					return
				end
				if activate(name) then
					vim.notify('[local-parsers] activated ' .. name, vim.log.levels.INFO)
					if on_done then on_done() end
				end
			end)
		end,
	})
end

function M.register(name, source_path)
	registry[name] = vim.fn.expand(source_path)
	activate(name) -- se já buildado, ativa imediatamente no startup
end

function M.is_registered(name) return registry[name] ~= nil end

function M.ensure_for_buf(bufnr, ft, on_ready)
	if not registry[ft] then return false end
	if is_built(ft) then
		activate(ft)
		if on_ready then on_ready() end
		return true
	end
	build(ft, on_ready)
	return true
end

function M.rebuild(name, on_done)
	if not registry[name] then
		vim.notify('[local-parsers] not registered: ' .. name, vim.log.levels.ERROR)
		return
	end
	build(name, on_done)
end

function M.list()
	return vim.tbl_keys(registry)
end

return M
