local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'esmuellert/codediff.nvim',
		config = M.config,
		cmd = 'CodeDiff',
		dependencies = { 'MunifTanjim/nui.nvim' },
	}
end

function M.config()
	require('codediff').setup({
		diff = {
			layout = 'inline', -- Diff layout: "side-by-side" (two panes) or "inline" (single pane with virtual lines)
			disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
			ignore_trim_whitespace = false, -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
			hide_merge_artifacts = false, -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
			conflict_result_height = 30, -- Height of result pane in bottom layout (% of total height)
			conflict_result_width_ratio = { 1, 1, 1 }, -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
			jump_to_first_change = true, -- Auto-scroll to first change when opening a diff: false to stay at same line
			compute_moves = true, -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
			cycle_hunks_across_files = true, -- Tab/S-Tab at file boundary jump to first/last hunk of next/prev file
		},
		explorer = {
			position = 'left',
			view_mode = 'tree',
			width = 30,
		},
		keymaps = {
			view = {
				quit = 'q', -- Close diff tab
				toggle_explorer = '<leader>e', -- Toggle explorer visibility (explorer mode only)
				next_hunk = '<Tab>', -- Jump to next change (crosses into next file at last hunk)
				prev_hunk = '<S-Tab>', -- Jump to previous change (crosses into previous file at first hunk)
				next_file = ']f', -- Next file in explorer mode
				prev_file = '[f', -- Previous file in explorer mode
				diff_get = 'do', -- Get change from other buffer (like vimdiff)
				diff_put = 'dp', -- Put change to other buffer (like vimdiff)
				open_in_prev_tab = 'gf', -- Open current buffer in previous tab (or create one before)
				close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
				toggle_stage = '-', -- Stage/unstage current file (works in explorer and diff buffers)
				stage_hunk = '<leader>hs', -- Stage hunk under cursor to git index
				unstage_hunk = '<leader>hu', -- Unstage hunk under cursor from git index
				discard_hunk = '<leader>hr', -- Discard hunk under cursor (working tree only)
				hunk_textobject = 'ih', -- Textobject for hunk (vih to select, yih to yank, etc.)
				show_help = 'g?', -- Show floating window with available keymaps
				align_move = 'gm', -- Temporarily align moved code blocks across panes
				toggle_layout = 't', -- Toggle between side-by-side and inline layout
			},
			explorer = {
				select = 'o',
				hover = 'K', -- Show file diff preview
				refresh = 'R', -- Refresh git status
				toggle_view_mode = 'i', -- Toggle between 'list' and 'tree' views
				stage_all = 'S', -- Stage all files
				unstage_all = 'U', -- Unstage all files
				restore = 'X', -- Discard changes (restore file)
				toggle_changes = 'gu', -- Toggle Changes (unstaged) group visibility
				toggle_staged = 'gs', -- Toggle Staged Changes group visibility
				-- Fold keymaps (Vim-style)
				fold_open = 'zo', -- Open fold (expand current node)
				fold_open_recursive = 'zO', -- Open fold recursively (expand all descendants)
				fold_close = 'zc', -- Close fold (collapse current node)
				fold_close_recursive = 'zC', -- Close fold recursively (collapse all descendants)
				fold_toggle = 'za', -- Toggle fold (expand/collapse current node)
				fold_toggle_recursive = 'zA', -- Toggle fold recursively
				fold_open_all = 'zR', -- Open all folds in tree
				fold_close_all = 'zM', -- Close all folds in tree
			},
			history = {
				select = '<CR>', -- Select commit/file or toggle expand
				toggle_view_mode = 'i', -- Toggle between 'list' and 'tree' views
				refresh = 'R', -- Refresh history (re-fetch commits)
				-- Fold keymaps (Vim-style, apply to directory nodes only)
				fold_open = 'zo', -- Open fold (expand current node)
				fold_open_recursive = 'zO', -- Open fold recursively (expand all descendants)
				fold_close = 'zc', -- Close fold (collapse current node)
				fold_close_recursive = 'zC', -- Close fold recursively (collapse all descendants)
				fold_toggle = 'za', -- Toggle fold (expand/collapse current node)
				fold_toggle_recursive = 'zA', -- Toggle fold recursively
				fold_open_all = 'zR', -- Open all folds in tree
				fold_close_all = 'zM', -- Close all folds in tree
			},
			conflict = {
				accept_incoming = '<leader>ct', -- Accept incoming (theirs/left) change
				accept_current = '<leader>co', -- Accept current (ours/right) change
				accept_both = '<leader>cb', -- Accept both changes (incoming first)
				discard = '<leader>cx', -- Discard both, keep base
				-- Accept all (whole file) - uppercase versions
				accept_all_incoming = '<leader>cT', -- Accept ALL incoming changes
				accept_all_current = '<leader>cO', -- Accept ALL current changes
				accept_all_both = '<leader>cB', -- Accept ALL both changes
				discard_all = '<leader>cX', -- Discard ALL, reset to base
				next_conflict = ']x', -- Jump to next conflict
				prev_conflict = '[x', -- Jump to previous conflict
				diffget_incoming = '2do', -- Get hunk from incoming (left/theirs) buffer
				diffget_current = '3do', -- Get hunk from current (right/ours) buffer
			},
		},
	})

	M.fix_explorer_width()
	M.fix_hunk_hop()
	M.fix_wrap()
end

--- Resize manual do explorer sobrevive à troca de arquivo.
---
---   você arrasta: 30 ──► 50 ──WinResized──► config.width = 50
---                                                   │
---   troca de arquivo ──► arrange() repina config ──► 50 ✓
---
--- Sem isso, arrange() (codediff/ui/layout.lua) repinava sempre os 30
--- originais do config, descartando o resize.
function M.fix_explorer_width()
	local codediff_config = require('codediff.config')
	U.api.augroup('CodediffExplorerWidth', {
		event = 'WinResized',
		command = function()
			local valid_win = Array(vim.v.event.windows or {}):find(vim.api.nvim_win_is_valid)
			if not valid_win then return end
			local buf = vim.api.nvim_win_get_buf(valid_win)
			if vim.bo[buf].filetype ~= 'codediff-explorer' then return end
			codediff_config.options.explorer.width = vim.api.nvim_win_get_width(valid_win)
		end,
	})
end

--- Tab/Shift-Tab atravessam arquivos mesmo quando o atual não tem hunks
--- (ex: arquivo novo ??).
---
---   a.txt: H1 → H2 ──Tab──► n1.txt (??) ──Tab──► n2.txt (??) ──Tab──► …
---                                    ▲
---                       sem o patch, o Tab morria aqui
---
--- Causa: next/prev_hunk retornam false quando #changes == 0 sem tentar o
--- arquivo vizinho (early return em codediff/ui/view/navigation.lua).
---
--- Patch feito aqui (e não na fonte do plugin, que o lazy update apagaria):
--- os keymaps leem navigation.next_hunk ao abrir cada tab, então trocar o
--- campo do módulo no setup vale para todas as tabs futuras. Se o upstream
--- corrigir o early return, deletar esta função.
function M.fix_hunk_hop()
	local codediff_config = require('codediff.config')
	local navigation = require('codediff.ui.view.navigation')
	local lifecycle = require('codediff.ui.lifecycle')
	--- Réplica de hop_to_adjacent_file, que é local ao plugin e não dá para reutilizar.
	---@param direction 'next'|'prev'
	---@return boolean true se trocou de arquivo
	local function hop_across_files(direction)
		local tabpage = vim.api.nvim_get_current_tabpage()
		if not lifecycle.get_explorer(tabpage) then return false end
		local session = lifecycle.get_session(tabpage)
		if session then session.pending_cursor_landing = direction == 'next' and 'first' or 'last' end
		if direction == 'next' then return navigation.next_file() end
		return navigation.prev_file()
	end
	---@param original fun(): boolean next/prev_hunk original
	---@param direction 'next'|'prev'
	---@return fun(): boolean hunk hop com travessia de arquivos sem hunks
	local function wrap_hunk_hop(original, direction)
		return function()
			local session = lifecycle.get_session(vim.api.nvim_get_current_tabpage())
			local diff = session and session.stored_diff_result
			-- nil = diff ainda carregando (não atravessa); vazio = sem hunks (atravessa).
			local should_hop = diff
				and diff.changes
				and #diff.changes == 0
				and codediff_config.options.diff.cycle_hunks_across_files
			if should_hop and hop_across_files(direction) then return true end
			return original()
		end
	end
	navigation.next_hunk = wrap_hunk_hop(navigation.next_hunk, 'next')
	navigation.prev_hunk = wrap_hunk_hop(navigation.prev_hunk, 'prev')
end

--- Wrap ligado nos painéis de diff.
---
---   plugin abre: wrap=false ──schedule──► wrap=true ✓
---
--- Sem isso, linha longa vaza para a direita sem quebrar: o plugin não
--- expõe opção de wrap e impõe wrap=false hardcoded em vários pontos
--- (ui/view/inline_view.lua, render.lua, side_by_side.lua,
--- conflict_window.lua, lifecycle/state.lua), além de reaplicar via
--- autocmd próprio (session.lua: BufWinEnter/BufEnter/WinEnter/FileType).
--- wrap é window-local, então o wrap=true global do options.lua não
--- sobrevive à abertura do diff.
---
--- Patch feito aqui (e não na fonte do plugin, que o lazy update
--- apagaria): reaplicar wrap=true DEPOIS do plugin, sempre via
--- vim.schedule — o autocmd do plugin é síncrono e foi registrado depois
--- do nosso, então o agendado roda por último e vence. OptionSet não serve
--- de gatilho: não dispara para vim.wo via API (testado). Se o upstream
--- adicionar opção de wrap, deletar esta função.
function M.fix_wrap()
	local lifecycle = require('codediff.ui.lifecycle')
	---@param win number? janela do painel de diff
	local function enable_wrap(win)
		if not win or not vim.api.nvim_win_is_valid(win) then return end
		vim.wo[win].wrap = true
		vim.wo[win].linebreak = true
		vim.wo[win].breakindent = true
	end
	---@param tabpage number
	local function wrap_session(tabpage)
		local session = lifecycle.get_session(tabpage)
		if not session then return end
		enable_wrap(session.original_win)
		enable_wrap(session.modified_win)
		enable_wrap(session.result_win)
	end
	local function wrap_all_sessions()
		for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
			wrap_session(tabpage)
		end
	end
	--- Revisão virtual renderiza dentro de dois schedules aninhados
	--- (git.get_file_content ──► schedule ──► schedule(render)): um schedule
	--- só empataria com o render, então agenda de novo para correr depois.
	local function wrap_all_sessions_deferred()
		vim.schedule(wrap_all_sessions)
	end
	U.api.augroup('CodediffWrap', {
		event = 'User',
		pattern = 'CodeDiffOpen',
		command = function() vim.schedule(wrap_all_sessions) end,
	}, {
		event = 'User',
		pattern = 'CodeDiffFileSelect',
		command = function() vim.schedule(wrap_all_sessions) end,
	}, {
		event = 'User',
		pattern = 'CodeDiffVirtualFileLoaded',
		command = function() vim.schedule(wrap_all_sessions_deferred) end,
	}, {
		event = {
			'WinEnter',
			'BufWinEnter',
			'BufEnter',
			'WinNew',
			'TabEnter',
			'TextChanged',
			'TextChangedI',
		},
		command = function() vim.schedule(wrap_all_sessions) end,
	})
end

return M
