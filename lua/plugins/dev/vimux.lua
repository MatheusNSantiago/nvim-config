local M = {}

local HIDDEN_SESSION = '__nvim_hidden__'

function M.setup()
  return {
    'preservim/vimux',
    lazy = false,
    keys = {
      { '<A-i>', function() M.toggle('v', '30%') end, mode = { 'n', 'i', 'x' }, desc = 'vimux: toggle runner horizontal' },
      { '<A-v>', function() M.toggle('h', '25%') end, mode = { 'n', 'i', 'x' }, desc = 'vimux: toggle runner vertical' },
      { '<leader>vi', '<cmd>VimuxInspectRunner<CR>', desc = 'vimux: inspecionar runner (copy mode)' },
      -- { '<leader>vl', '<cmd>VimuxRunLastCommand<CR>', desc = 'vimux: reexecutar último comando' },
      -- { '<leader>vz', '<cmd>VimuxZoomRunner<CR>', desc = 'vimux: zoom no runner' },
      { '<leader>vq', '<cmd>VimuxCloseRunner<CR>', desc = 'vimux: fechar runner' },
    },
    init = M.init,
  }
end

function M.init()
  vim.g.VimuxUseNearest = 0
  vim.g.VimuxCloseOnExit = 0
  vim.api.nvim_create_autocmd('VimLeave', { callback = M._cleanup_runners })
end

-- ── Helpers tmux ──────────────────────────────────────────────────────────────

function M._tmux_capture(command)
  return vim.fn.system('tmux ' .. command):gsub('%s+', '')
end

function M._tmux_run(command)
  vim.fn.system('tmux ' .. command)
end

function M._pane_exists_on_server(pane_id)
  local count = vim.fn.system("tmux list-panes -a -F '#{pane_id}' 2>/dev/null | grep -Fxc '" .. pane_id .. "'")
  return (tonumber((count:gsub('%s+', ''))) or 0) > 0
end

function M._tmux_split_flag(orientation)
  return orientation == 'v' and '-v' or '-h'
end

-- ── Estado do runner escondido ────────────────────────────────────────────────

function M._hidden_runner_key(orientation)
  return '_vimux_hidden_pane_' .. orientation
end

function M._get_hidden_runner_pane(orientation)
  return vim.g[M._hidden_runner_key(orientation)] or ''
end

function M._set_hidden_runner_pane(orientation, pane_id)
  vim.g[M._hidden_runner_key(orientation)] = pane_id
end

function M._clear_hidden_runner_pane(orientation)
  vim.g[M._hidden_runner_key(orientation)] = ''
end

function M._runner_is_hidden(orientation)
  local pane_id = M._get_hidden_runner_pane(orientation)
  return pane_id ~= '' and M._pane_exists_on_server(pane_id)
end

-- ── Registro do pane nvim (para keybindings tmux) ────────────────────────────
-- Permite que <A-i>/<A-v> funcionem a partir de qualquer pane, não só do nvim.

function M._register_nvim_pane_for_tmux(orientation)
  local pane_id = M._tmux_capture('display-message -p "#{pane_id}"')
  M._tmux_run('set-environment -g _nvim_pane_' .. orientation .. ' ' .. pane_id)
end

-- ── Operações hide / restore / open ──────────────────────────────────────────

-- Move o pane direto para a sessão oculta num único comando, sem janela intermediária visível.
function M._move_pane_to_hidden_session(pane_id)
  M._tmux_run('new-session -d -s ' .. HIDDEN_SESSION .. ' 2>/dev/null')
  M._tmux_run(string.format('break-pane -d -s "%s" -t "%s:"', pane_id, HIDDEN_SESSION))
end

function M._hide_runner(orientation)
  local pane_id = M._tmux_capture(
    'display-message -p -t ' .. tostring(vim.g.VimuxRunnerIndex) .. ' "#{pane_id}"'
  )
  M._move_pane_to_hidden_session(pane_id)
  M._set_hidden_runner_pane(orientation, pane_id)
  vim.g.VimuxRunnerIndex = nil
end

function M._restore_runner(orientation, height)
  local pane_id = M._get_hidden_runner_pane(orientation)
  M._tmux_run(string.format('join-pane -s "%s" %s -l %s', pane_id, M._tmux_split_flag(orientation), height))
  vim.g.VimuxRunnerIndex = pane_id
  M._clear_hidden_runner_pane(orientation)
  M._tmux_run('select-pane -t ' .. pane_id)
end

function M._open_new_runner()
  vim.fn.VimuxOpenRunner()
  M._tmux_run('select-pane -t ' .. tostring(vim.g.VimuxRunnerIndex))
end

-- ── Cleanup ───────────────────────────────────────────────────────────────────

function M._cleanup_runners()
  if vim.fn.VimuxHasRunner() then
    vim.fn.VimuxCloseRunner()
  end
  -- Mata a sessão oculta inteira (inclui o pane inicial criado com new-session)
  M._tmux_run('kill-session -t ' .. HIDDEN_SESSION .. ' 2>/dev/null')
end

-- ── Toggle ────────────────────────────────────────────────────────────────────

M.toggle = function(orientation, height)
  vim.g.VimuxOrientation = orientation
  vim.g.VimuxHeight = height
  M._register_nvim_pane_for_tmux(orientation)

  if vim.fn.VimuxHasRunner() then
    M._hide_runner(orientation)
    return
  end

  if M._runner_is_hidden(orientation) then
    M._restore_runner(orientation, height)
    return
  end

  M._open_new_runner()
end

return M
