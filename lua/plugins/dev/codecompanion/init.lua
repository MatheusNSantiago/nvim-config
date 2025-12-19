local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'olimorris/codecompanion.nvim',
		version = '^18.0.0',
		config = M.config,
		keys = {
			{ '<leader>ao', M.open_picker, mode = { 'n', 'v' }, desc = 'codecompanion: abrir picker' },
			-- { '<leader>k', M.open_quick_prompt, mode = { 'n', 'v' }, desc = 'codecompanion: quick prompt' },
			{ '<leader>v', M.toggle_chat, desc = 'codecompanion: toggle chat' },
		},
	}
end

function M.config()
	local spinner = require('plugins.dev.codecompanion.inline-spinner')
	spinner:init()

	require('codecompanion').setup({
		language = 'English', -- Default is "English"
		adapters = {
			http = {
				openai = function() -- remove o print da qnt de tokens utilizados
					return require('codecompanion.adapters').extend('openai', {
						handlers = { tokens = function() end },
					})
				end,
				['openrouter'] = function()
					return require('codecompanion.adapters').extend('openai_compatible', {
						url = 'https://openrouter.ai/api/v1/chat/completions',
						env = { api_key = 'OPENROUTER_API_KEY' },
						schema = { model = { default = 'google/gemini-2.5-flash' } },
					})
				end,
				opts = U.is_wsl() and { allow_insecure = true, proxy = 'http://192.168.127.254:3128' } or nil,
			},
			adapters = {
				acp = {
					codex = function()
						return require('codecompanion.adapters').extend('codex', {
							defaults = {
								auth_method = 'chatgpt', -- "openai-api-key"|"codex-api-key"|"chatgpt"
							},
						})
					end,
				},
			},
		},
		-- PROMPT LIBRARIES ---------------------------------------------------------
		-- prompt_library = {
		-- 	['Testes Unitários'] = M.get_prompt('teste-unitario'),
		-- 	['Explicar Diagnóstico do LSP'] = M.get_prompt('explicar-diagnostico-lsp'),
		-- 	['Explicar Código'] = M.get_prompt('explicar-codigo'),
		-- 	['Documentar'] = M.get_prompt('documentar'),
		-- 	['Gerar Commit Message'] = M.get_prompt('gerar-commit-message'),
		-- },
		-- strategies = {
		-- 	-- CHAT STRATEGY ----------------------------------------------------------
		-- 	chat = {
		-- 		adapter = 'openrouter',
		-- 		roles = { llm = 'CodeCompanion', user = 'Eu' },
		-- 		variables = {
		-- 			['buffer'] = {
		-- 				callback = 'strategies.chat.variables.buffer',
		-- 				description = 'Share the current buffer with the LLM',
		-- 				opts = { contains_code = true, has_params = true },
		-- 			},
		-- 			['lsp'] = {
		-- 				callback = 'strategies.chat.variables.lsp',
		-- 				description = 'Share LSP information and code for the current buffer',
		-- 				opts = { contains_code = true, hide_reference = true },
		-- 			},
		-- 			['viewport'] = {
		-- 				callback = 'strategies.chat.variables.viewport',
		-- 				description = 'Share the code that you see in Neovim with the LLM',
		-- 				opts = { contains_code = true, hide_reference = true },
		-- 			},
		-- 		},
		-- 		slash_commands = M.get_slash_commands(),
		-- 		keymaps = M.chat_keymaps,
		-- 		opts = {
		-- 			register = '+', -- The register to use for yanking code
		-- 			yank_jump_delay_ms = 400, -- Delay in milliseconds before jumping back from the yanked code
		-- 		},
		-- 	},
		-- 	-- INLINE STRATEGY --------------------------------------------------------
		-- 	inline = {
		-- 		adapter = U.is_wsl() and 'openai' or 'openrouter',
		-- 		keymaps = {
		-- 			accept_change = {
		-- 				modes = { n = 'ga' },
		-- 				index = 1,
		-- 				callback = 'keymaps.accept_change',
		-- 				description = 'Accept change',
		-- 			},
		-- 			reject_change = {
		-- 				modes = { n = 'gr' },
		-- 				index = 2,
		-- 				callback = 'keymaps.reject_change',
		-- 				description = 'Reject change',
		-- 			},
		-- 		},
		-- 		-- prompts = {
		-- 		-- 	-- The prompt to send to the LLM when a user initiates the inline strategy and it needs to convert to a chat
		-- 		-- 	inline_to_chat = function(context)
		-- 		-- 		return string.format(
		-- 		-- 			[[I want you to act as an expert and senior developer in the %s language. I will ask you questions, perhaps giving you code examples, and I want you to advise me with explanations and code where neccessary.]],
		-- 		-- 			context.filetype
		-- 		-- 		)
		-- 		-- 	end,
		-- 		-- },
		-- 	},
		-- 	-- AGENT STRATEGY ---------------------------------------------------------
		-- 	agent = {
		-- 		['full_stack_dev'] = {
		-- 			description = 'Full Stack Developer - Can run code, edit code and modify files',
		-- 			system_prompt = "**DO NOT** make any assumptions about the dependencies that a user has installed. If you need to install any dependencies to fulfil the user's request, do so via the Command Runner tool. If the user doesn't specify a path, use their current working directory.",
		-- 			tools = {
		-- 				'cmd_runner',
		-- 				'editor',
		-- 				'files',
		-- 			},
		-- 		},
		-- 		tools = {
		-- 			['cmd_runner'] = {
		-- 				callback = 'strategies.chat.tools.cmd_runner',
		-- 				description = 'Run shell commands initiated by the LLM',
		-- 				opts = {
		-- 					user_approval = true,
		-- 				},
		-- 			},
		-- 			['editor'] = {
		-- 				callback = 'strategies.chat.tools.editor',
		-- 				description = "Update a buffer with the LLM's response",
		-- 			},
		-- 			['files'] = {
		-- 				callback = 'strategies.chat.tools.files',
		-- 				description = "Update the file system with the LLM's response",
		-- 				opts = {
		-- 					user_approval = true,
		-- 				},
		-- 			},
		-- 			['rag'] = {
		-- 				callback = 'strategies.chat.tools.rag',
		-- 				description = 'Supplement the LLM with real-time info from the internet',
		-- 				opts = {
		-- 					hide_output = true,
		-- 				},
		-- 			},
		-- 			opts = {
		-- 				auto_submit_errors = false, -- Send any errors to the LLM automatically?
		-- 				auto_submit_success = false, -- Send any successful output to the LLM automatically?
		-- 				system_prompt = [[## Tools
		--
		--   You now have access to tools:
		--   - These enable you to assist the user with specific tasks
		--   - The user will outline which specific tools you have access to
		--   - You trigger a tool by following a specific XML schema which is defined for each tool
		--
		--   You must:
		--   - Only use the tool when prompted by the user, despite having access to it
		--   - Follow the specific tool's schema
		--   - Respond with the schema in XML format
		--   - Ensure the schema is in a markdown code block that is designated as XML
		--   - Ensure any output you're intending to execute will be able to parsed as valid XML
		--
		--   Points to note:
		--   - The user detects that you've triggered a tool by using Tree-sitter to parse your markdown response
		--   - If you call multiple tools within the same response:
		--     - Each unique tool MUST be called in its own, individual, XML codeblock
		--     - Tools of the same type SHOULD be called in the same XML codeblock
		--   - If your response doesn't follow the tool's schema, the tool will not execute
		--   - Tools should not alter your core tasks and how you respond to a user]],
		-- 			},
		-- 		},
		-- 	},
		-- },
		-- DISPLAY OPTIONS ----------------------------------------------------------
		display = {
			action_palette = {
				width = 95,
				height = 10,
				prompt = 'Prompt ', -- Prompt used for interactive LLM calls
				provider = 'default', -- telescope|mini_pick|snacks|default
				opts = {
					show_preset_actions = true, -- Show the preset actions in the action palette?
					show_preset_prompts = true, -- Show the preset prompts in the action palette?
					show_preset_rules = true, -- Show the preset rules in the action palette?
					title = 'CodeCompanion actions', -- The title of the action palette
				},
			},
			chat = {
				window = {
					buflisted = false, -- List the chat buffer in the buffer list?
					sticky = true, -- Chat buffer remains open when switching tabs
					layout = 'vertical', -- float|vertical|horizontal|buffer
					full_height = true, -- for vertical layout
					position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
					width = 0.25, ---@type number|"auto" using "auto" will allow full_height buffers to act like normal buffers
					height = 0.8,
					border = 'single', -- single | rounded
					relative = 'editor',
					-- Ensure that long paragraphs of markdown are wrapped
					opts = {
						breakindent = true,
						linebreak = true,
						wrap = true,
					-- 	breakindent = true,
					-- 	cursorcolumn = false,
					-- 	cursorline = false,
					-- 	foldcolumn = '0',
					-- 	linebreak = true,
					-- 	list = false,
					-- 	signcolumn = 'no',
					-- 	spell = false,
					-- 	wrap = true,
					-- 	number = false,
					-- 	relativenumber = false,
					},
				},
				-- intro_message = '',
				-- show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an exteral markdown formatting plugin
				-- separator = '─', -- The separator between the different messages in the chat buffer
				-- render_headers = false,
				--
				-- show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
				-- show_settings = false, -- Show LLM settings at the top of the chat buffer?
				-- show_token_count = false, -- Show the token count for each response?
				-- start_in_insert_mode = false, -- Open the chat buffer in insert mode?
				--
				-- ---@param tokens number
				-- ---@param adapter CodeCompanion.Adapter
				-- token_count = function(tokens, adapter) -- The function to display the token count
				-- 	return ' (' .. tokens .. ' tokens)'
				-- end,
			},
			-- diff = {
			-- 	enabled = true,
			-- 	close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
			-- 	layout = 'vertical', -- vertical|horizontal split for default provider
			-- 	opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
			-- 	provider = 'default', -- default|mini_diff
			-- },
			-- inline = { -- If the inline prompt creates a new buffer, how should we display this?
			-- 	layout = 'vertical', -- vertical|horizontal|buffer
			-- },
			-- },
			-- GENERAL OPTIONS ----------------------------------------------------------
			-- opts = {
			-- 	log_level = 'ERROR', -- TRACE|DEBUG|ERROR|INFO
			-- 	-- If this is false then any default prompt that is marked as containing code
			-- 	-- will not be sent to the LLM. Please note that whilst I have made every
			-- 	-- effort to ensure no code leakage, using this is at your own risk
			-- 	send_code = true,
			--
			-- 	-- This is the default prompt which is sent with every request in the chat
			-- 	-- strategy. It is primarily based on the GitHub Copilot Chat's prompt
			-- 	-- but with some modifications. You can choose to remove this via
			-- 	-- your own config but note that LLM results may not be as good
			-- 	---@param adapter CodeCompanion.Adapter
			-- 	---@return string
			-- 	---@diagnostic disable-next-line: unused-local
			-- 	system_prompt = function(adapter)
			-- 		return table.concat({
			-- 			"Você é um assistente de programação de IA chamado 'CodeCompanion'.",
			-- 			'Você está atualmente conectado ao editor de texto Neovim na máquina de um usuário.',
			-- 			'',
			-- 			'Suas principais tarefas incluem:',
			-- 			'- Responder a perguntas gerais de programação.',
			-- 			'- Explicar como o código em um buffer do Neovim funciona.',
			-- 			'- Revisar o código selecionado em um buffer do Neovim.',
			-- 			'- Gerar testes unitários para o código selecionado.',
			-- 			'- Propor correções para problemas no código selecionado.',
			-- 			'- Estruturar código para um novo espaço de trabalho.',
			-- 			'- Encontrar código relevante para a consulta do usuário.',
			-- 			'- Propor correções para falhas de testes.',
			-- 			'- Responder a perguntas sobre o Neovim.',
			-- 			'- Executar ferramentas.',
			-- 			'',
			-- 			'Você deve:',
			-- 			'- Seguir os requisitos do usuário cuidadosamente e ao pé da letra.',
			-- 			'- Manter suas respostas curtas e impessoais, especialmente se o usuário responder com contexto fora de suas tarefas.',
			-- 			'- Evitar floreios desnecessários.',
			-- 			'- Usar formatação Markdown em suas respostas.',
			-- 			'- Incluir o nome da linguagem de programação no início dos blocos de código Markdown.',
			-- 			'- Evitar números de linha em blocos de código.',
			-- 			'- Evitar envolver toda a resposta em três crases invertidas ```.',
			-- 			'- Retornar apenas o código relevante para a tarefa. Não precisa retornar todo o código compartilhado pelo usuário.',
			-- 			"- Usar quebras de linha reais em vez de '\n' em sua resposta para iniciar novas linhas.",
			-- 			"- Usar '\n' apenas quando quiser uma barra invertida literal seguida pelo caractere 'n'.",
			-- 			'- Responder no mesmo idioma da consulta do usuário.',
			-- 			'',
			-- 			'Ao receber uma tarefa:',
			-- 			'1. Pense passo a passo e descreva seu plano para o que construir em pseudocódigo, escrito em grande detalhe, a menos que seja solicitado a não fazê-lo.',
			-- 			'2. Exiba o código em um único bloco de código, tendo cuidado para retornar apenas o código relevante.',
			-- 			'3. Você só pode dar uma resposta para cada interação da conversa.',
			-- 		}, '\n')
			-- 	end,
		},
	})
end

local null_keymap = { modes = { n = 'g&' }, hide = true }
M.chat_keymaps = {
	options = {
		modes = { n = '?' },
		callback = 'keymaps.options',
		description = 'Options',
		hide = true,
	},
	completion = {
		modes = { i = '<C-_>' },
		index = 1,
		callback = 'keymaps.completion',
		description = 'Completion menu',
	},
	-- send = {
	-- 	modes = { n = { '<CR>', '<C-s>' }, i = '<C-s>' },
	-- 	index = 2,
	-- 	callback = 'keymaps.send',
	-- 	description = 'Send message',
	-- },
	send = {
		modes = { n = { '<CR>', '<C-s>' }, i = '<C-s>' },
		callback = function(chat)
			vim.cmd('stopinsert')
			chat:submit()
			chat:add_buf_message({ role = 'llm', content = '' })
		end,
		index = 2,
		description = 'Send message',
	},

	regenerate = {
		modes = { n = 'gr' },
		index = 3,
		callback = 'keymaps.regenerate',
		description = 'Regenerate last response',
	},
	close = {
		modes = { n = '<C-c>', i = '<C-c>' },
		-- 		modes = { n = 'q', i = '<C-c>' },
		index = 4,
		callback = 'keymaps.close',
		description = 'Close chat',
	},
	stop = {
		modes = { n = 'q' },
		-- 		modes = { n = '<C-c>' },
		index = 5,
		callback = 'keymaps.stop',
		description = 'Stop request',
	},
	clear = {
		modes = { n = 'gx' },
		index = 6,
		callback = 'keymaps.clear',
		description = 'Clear chat',
	},
	codeblock = {
		modes = { n = 'gc' },
		index = 7,
		callback = 'keymaps.codeblock',
		description = 'Insert codeblock',
	},
	yank_code = {
		modes = { n = 'gy' },
		index = 8,
		callback = 'keymaps.yank_code',
		description = 'Yank code',
	},
	buffer_sync_all = {
		modes = { n = 'gba' },
		index = 9,
		callback = 'keymaps.buffer_sync_all',
		description = 'Toggle the syncing of the entire buffer',
	},
	buffer_sync_diff = {
		modes = { n = 'gbd' },
		index = 10,
		callback = 'keymaps.buffer_sync_diff',
		description = "Toggle the syncing of the buffer to share it's diffs",
	},
	next_chat = {
		modes = { n = '}' },
		index = 11,
		callback = 'keymaps.next_chat',
		description = 'Next chat',
	},
	previous_chat = {
		modes = { n = '{' },
		index = 12,
		callback = 'keymaps.previous_chat',
		description = 'Previous chat',
	},
	next_header = {
		modes = { n = ']]' },
		index = 13,
		callback = 'keymaps.next_header',
		description = 'Next header',
	},
	previous_header = {
		modes = { n = '[[' },
		index = 14,
		callback = 'keymaps.previous_header',
		description = 'Previous header',
	},
	change_adapter = {
		modes = { n = 'ga' },
		index = 15,
		callback = 'keymaps.change_adapter',
		description = 'Change adapter',
	},
	fold_code = {
		modes = { n = 'gf' },
		index = 15,
		callback = 'keymaps.fold_code',
		description = 'Fold code',
	},
	debug = {
		modes = { n = 'gd' },
		index = 16,
		callback = 'keymaps.debug',
		description = 'View debug info',
	},
	system_prompt = {
		modes = { n = 'gs' },
		index = 17,
		callback = 'keymaps.toggle_system_prompt',
		description = 'Toggle system prompt',
	},
	rules = {
		modes = { n = 'gM' },
		index = 18,
		callback = 'keymaps.clear_rules',
		description = 'Clear Rules',
	},
	yolo_mode = {
		modes = { n = 'gty' },
		index = 19,
		callback = 'keymaps.yolo_mode',
		description = 'YOLO mode toggle',
	},
	goto_file_under_cursor = {
		modes = { n = 'gR' },
		index = 20,
		callback = 'keymaps.goto_file_under_cursor',
		description = 'Open file under cursor',
	},
	copilot_stats = {
		modes = { n = 'gS' },
		index = 21,
		callback = 'keymaps.copilot_stats',
		description = 'Show Copilot statistics',
	},
	super_diff = {
		modes = { n = 'gD' },
		index = 22,
		callback = 'keymaps.super_diff',
		description = 'Show Super Diff',
	},
	-- Keymaps for ACP permission requests
	_acp_allow_always = {
		modes = { n = 'g1' },
		description = 'Allow Always',
	},
	_acp_allow_once = {
		modes = { n = 'g2' },
		description = 'Allow Once',
	},
	_acp_reject_once = {
		modes = { n = 'g3' },
		description = 'Reject Once',
	},
	_acp_reject_always = {
		modes = { n = 'g4' },
		description = 'Reject Always',
	},
}
-- M.chat_keymaps = {
-- 	options = {
-- 		modes = { n = '?' },
-- 		callback = 'keymaps.options',
-- 		description = 'Options',
-- 		hide = true,
-- 	},
-- 	send = {
-- 		modes = { n = { '<CR>', '<C-s>' }, i = '<C-s>' },
-- 		index = 1,
-- 		---@param chat CodeCompanion.Chat
-- 		callback = function(chat) return chat:submit() end,
-- 		description = 'Send',
-- 	},
-- 	regenerate = {
-- 		modes = { n = 'gr' },
-- 		index = 2,
-- 		callback = 'keymaps.regenerate',
-- 		description = 'Regenerate the last response',
-- 	},
-- 	close = {
-- 		modes = { n = 'q', i = '<C-c>' },
-- 		index = 3,
-- 		callback = 'keymaps.close',
-- 		description = 'Close Chat',
-- 	},
-- 	stop = {
-- 		modes = { n = '<C-c>' },
-- 		index = 4,
-- 		callback = 'keymaps.stop',
-- 		description = 'Stop Request',
-- 	},
-- 	clear = {
-- 		modes = { n = 'gx' },
-- 		index = 5,
-- 		callback = 'keymaps.clear',
-- 		description = 'Clear Chat',
-- 	},
-- 	codeblock = null_keymap,
-- 	yank_code = {
-- 		modes = { n = 'gy' },
-- 		index = 6,
-- 		callback = 'keymaps.yank_code',
-- 		description = 'Yank Code',
-- 	},
-- 	next_chat = {
-- 		modes = { n = ']c' },
-- 		index = 7,
-- 		callback = 'keymaps.next_chat',
-- 		description = 'Next Chat',
-- 	},
-- 	previous_chat = {
-- 		modes = { n = '[c' },
-- 		index = 8,
-- 		callback = 'keymaps.previous_chat',
-- 		description = 'Previous Chat',
-- 	},
-- 	next_header = {
-- 		modes = { n = ']]' },
-- 		index = 9,
-- 		callback = 'keymaps.next_header',
-- 		description = 'Next Header',
-- 	},
-- 	previous_header = {
-- 		modes = { n = '[[' },
-- 		index = 10,
-- 		callback = 'keymaps.previous_header',
-- 		description = 'Previous Header',
-- 	},
-- 	change_adapter = null_keymap,
-- 	fold_code = {
-- 		modes = { n = 'gf' },
-- 		index = 11,
-- 		callback = 'keymaps.fold_code',
-- 		description = 'Fold code',
-- 	},
-- 	debug = {
-- 		modes = { n = 'gd' },
-- 		index = 12,
-- 		callback = 'keymaps.debug',
-- 		description = 'View debug info',
-- 	},
-- 	system_prompt = {
-- 		modes = { n = 'gs' },
-- 		index = 13,
-- 		callback = 'keymaps.toggle_system_prompt',
-- 		description = 'Toggle the system prompt',
-- 	},
-- }

-- M.slash_commands = {
-- 	['buffer'] = {
-- 		callback = 'strategies.chat.slash_commands.buffer',
-- 		description = 'Insert open buffers',
-- 		opts = {
-- 			contains_code = true,
-- 			provider = 'default', -- default|telescope|mini_pick|fzf_lua
-- 		},
-- 	},
-- 	['fetch'] = {
-- 		callback = 'strategies.chat.slash_commands.fetch',
-- 		description = 'Insert URL contents',
-- 		opts = {
-- 			adapter = 'jina',
-- 		},
-- 	},
-- 	['file'] = {
-- 		callback = 'strategies.chat.slash_commands.file',
-- 		description = 'Insert a file',
-- 		opts = {
-- 			contains_code = true,
-- 			max_lines = 1000,
-- 			provider = 'default', -- default|telescope|mini_pick|fzf_lua
-- 		},
-- 	},
-- 	['help'] = {
-- 		callback = 'strategies.chat.slash_commands.help',
-- 		description = 'Insert content from help tags',
-- 		opts = {
-- 			contains_code = false,
-- 			provider = 'telescope', -- telescope|mini_pick
-- 		},
-- 	},
-- 	['now'] = {
-- 		callback = 'strategies.chat.slash_commands.now',
-- 		description = 'Insert the current date and time',
-- 		opts = {
-- 			contains_code = false,
-- 		},
-- 	},
-- 	['symbols'] = {
-- 		callback = 'strategies.chat.slash_commands.symbols',
-- 		description = 'Insert symbols for a selected file',
-- 		opts = {
-- 			contains_code = true,
-- 			provider = 'default', -- default|telescope|mini_pick|fzf_lua
-- 		},
-- 	},
-- 	['terminal'] = {
-- 		callback = 'strategies.chat.slash_commands.terminal',
-- 		description = 'Insert terminal output',
-- 		opts = {
-- 			contains_code = false,
-- 		},
-- 	},
-- }

M.get_slash_commands = function()
	local providers = require('codecompanion.providers')
	return {
		['buffer'] = {
			callback = 'interactions.chat.slash_commands.builtin.buffer',
			description = 'Insert open buffers',
			opts = {
				contains_code = true,
				default_params = 'diff', -- all|diff
				provider = providers.pickers, -- telescope|fzf_lua|mini_pick|snacks|default
			},
		},
		['compact'] = {
			callback = 'interactions.chat.slash_commands.builtin.compact',
			description = 'Clears some of the chat history, keeping a summary in context',
			enabled = function(opts)
				if opts.adapter and opts.adapter.type == 'http' then return true end
				return false
			end,
			opts = {
				contains_code = false,
			},
		},
		['fetch'] = {
			callback = 'interactions.chat.slash_commands.builtin.fetch',
			description = 'Insert URL contents',
			opts = {
				adapter = 'jina', -- jina
				cache_path = vim.fn.stdpath('data') .. '/codecompanion/urls',
				provider = providers.pickers, -- telescope|fzf_lua|mini_pick|snacks|default
			},
		},
		['quickfix'] = {
			callback = 'interactions.chat.slash_commands.builtin.quickfix',
			description = 'Insert quickfix list entries',
			opts = {
				contains_code = true,
			},
		},
		['file'] = {
			callback = 'interactions.chat.slash_commands.builtin.file',
			description = 'Insert a file',
			opts = {
				contains_code = true,
				max_lines = 1000,
				provider = providers.pickers, -- telescope|fzf_lua|mini_pick|snacks|default
			},
		},
		['help'] = {
			callback = 'interactions.chat.slash_commands.builtin.help',
			description = 'Insert content from help tags',
			opts = {
				contains_code = false,
				max_lines = 128, -- Maximum amount of lines to of the help file to send (NOTE: Each vimdoc line is typically 10 tokens)
				provider = providers.help, -- telescope|fzf_lua|mini_pick|snacks
			},
		},
		['image'] = {
			callback = 'interactions.chat.slash_commands.builtin.image',
			description = 'Insert an image',
			---@param opts { adapter: CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter }
			---@return boolean
			enabled = function(opts)
				if opts.adapter and opts.adapter.opts then return opts.adapter.opts.vision == true end
				return false
			end,
			opts = {
				dirs = {}, -- Directories to search for images
				filetypes = { 'png', 'jpg', 'jpeg', 'gif', 'webp' }, -- Filetypes to search for
				provider = providers.images, -- telescope|snacks|default
			},
		},
		['rules'] = {
			callback = 'interactions.chat.slash_commands.builtin.rules',
			description = 'Insert rules into the chat buffer',
			opts = {
				contains_code = true,
			},
		},
		['mode'] = {
			callback = 'interactions.chat.slash_commands.builtin.mode',
			description = 'Change the ACP session mode',
			---@param opts { adapter: CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter }
			---@return boolean
			enabled = function(opts)
				if opts.adapter and opts.adapter.type == 'acp' then return true end
				return false
			end,
			opts = {
				contains_code = false,
			},
		},
		['now'] = {
			callback = 'interactions.chat.slash_commands.builtin.now',
			description = 'Insert the current date and time',
			opts = {
				contains_code = false,
			},
		},
		['symbols'] = {
			callback = 'interactions.chat.slash_commands.builtin.symbols',
			description = 'Insert symbols for a selected file',
			opts = {
				contains_code = true,
				provider = providers.pickers, -- telescope|fzf_lua|mini_pick|snacks|default
			},
		},
		['terminal'] = {
			callback = 'interactions.chat.slash_commands.builtin.terminal',
			description = 'Insert terminal output',
			opts = {
				contains_code = false,
			},
		},
		opts = {
			acp = {
				enabled = true, -- Enable ACP command completion
				trigger = '\\', -- Trigger character for ACP commands
			},
		},
	}
end

M.open_picker = function()
	vim.cmd('NvimTreeClose')
	vim.cmd('CodeCompanionActions')
end

local function is_chat_open(filetype)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == filetype then return true end
	end
	return false
end

M.toggle_chat = function()
	if not is_chat_open('codecompanion') then --
		vim.cmd('NvimTreeClose')
	end
	vim.cmd('CodeCompanionChat Toggle')
end

-- M.open_quick_prompt = function() vim.cmd('CodeCompanion /documentar') end

M.get_prompt = function(title) --
	return require('plugins.dev.codecompanion.prompts.' .. title)
end

return M
