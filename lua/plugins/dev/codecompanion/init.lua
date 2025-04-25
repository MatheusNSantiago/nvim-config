local M = {}

function M.setup()
  return { ---@type LazyPluginSpec
    'olimorris/codecompanion.nvim',
    config = M.config,
    keys = {
      { '<leader>ao', M.open_picker, mode = { 'n', 'v' },                desc = 'codecompanion: abrir picker' },
      -- { '<leader>k', M.open_quick_prompt, mode = { 'n', 'v' }, desc = 'codecompanion: quick prompt' },
      { '<leader>v',  M.toggle_chat, desc = 'codecompanion: toggle chat' },
    },
  }
end

function M.config()
  require('codecompanion').setup({
    language = 'English', -- Default is "English"
    adapters = {
      openai = function() -- remove o print da qnt de tokens utilizados
        return require('codecompanion.adapters').extend('openai', {
          handlers = { tokens = function() end },
        })
      end,
      ['openrouter'] = function()
        return require('codecompanion.adapters').extend('openai_compatible', {
          url = 'https://openrouter.ai/api/v1/chat/completions',
          env = { api_key = 'OPENROUTER_API_KEY' },
          schema = { model = { default = 'google/gemini-2.0-flash-001' } },
        })
      end,
    },
    -- PROMPT LIBRARIES ---------------------------------------------------------
    prompt_library = {
      ['Testes Unitários'] = M.get_prompt('teste-unitario'),
      ['Explicar Diagnóstico do LSP'] = M.get_prompt('explicar-diagnostico-lsp'),
      ['Explicar Código'] = M.get_prompt('explicar-codigo'),
      ['Documentar'] = M.get_prompt('documentar'),
      ['Gerar Commit Message'] = M.get_prompt('gerar-commit-message'),
    },
    strategies = {
      -- CHAT STRATEGY ----------------------------------------------------------
      chat = {
        adapter = U.is_wsl() and 'openai' or 'openrouter',
        roles = { llm = 'CodeCompanion', user = 'Eu' },
        variables = {
          ['buffer'] = {
            callback = 'strategies.chat.variables.buffer',
            description = 'Share the current buffer with the LLM',
            opts = { contains_code = true, has_params = true },
          },
          ['lsp'] = {
            callback = 'strategies.chat.variables.lsp',
            description = 'Share LSP information and code for the current buffer',
            opts = { contains_code = true, hide_reference = true },
          },
          ['viewport'] = {
            callback = 'strategies.chat.variables.viewport',
            description = 'Share the code that you see in Neovim with the LLM',
            opts = { contains_code = true, hide_reference = true },
          },
        },
        slash_commands = M.slash_commands,
        keymaps = M.chat_keymaps,
        opts = {
          register = '+',           -- The register to use for yanking code
          yank_jump_delay_ms = 400, -- Delay in milliseconds before jumping back from the yanked code
        },
      },
      -- INLINE STRATEGY --------------------------------------------------------
      inline = {
        adapter = U.is_wsl() and 'openai' or 'openrouter',
        keymaps = {
          accept_change = {
            modes = { n = 'ga' },
            index = 1,
            callback = 'keymaps.accept_change',
            description = 'Accept change',
          },
          reject_change = {
            modes = { n = 'gr' },
            index = 2,
            callback = 'keymaps.reject_change',
            description = 'Reject change',
          },
        },
        prompts = {
          -- The prompt to send to the LLM when a user initiates the inline strategy and it needs to convert to a chat
          inline_to_chat = function(context)
            return string.format(
              [[I want you to act as an expert and senior developer in the %s language. I will ask you questions, perhaps giving you code examples, and I want you to advise me with explanations and code where neccessary.]],
              context.filetype
            )
          end,
        },
      },
      -- AGENT STRATEGY ---------------------------------------------------------
      agent = {
        ['full_stack_dev'] = {
          description = 'Full Stack Developer - Can run code, edit code and modify files',
          system_prompt =
          "**DO NOT** make any assumptions about the dependencies that a user has installed. If you need to install any dependencies to fulfil the user's request, do so via the Command Runner tool. If the user doesn't specify a path, use their current working directory.",
          tools = {
            'cmd_runner',
            'editor',
            'files',
          },
        },
        tools = {
          ['cmd_runner'] = {
            callback = 'strategies.chat.tools.cmd_runner',
            description = 'Run shell commands initiated by the LLM',
            opts = {
              user_approval = true,
            },
          },
          ['editor'] = {
            callback = 'strategies.chat.tools.editor',
            description = "Update a buffer with the LLM's response",
          },
          ['files'] = {
            callback = 'strategies.chat.tools.files',
            description = "Update the file system with the LLM's response",
            opts = {
              user_approval = true,
            },
          },
          ['rag'] = {
            callback = 'strategies.chat.tools.rag',
            description = 'Supplement the LLM with real-time info from the internet',
            opts = {
              hide_output = true,
            },
          },
          opts = {
            auto_submit_errors = false,  -- Send any errors to the LLM automatically?
            auto_submit_success = false, -- Send any successful output to the LLM automatically?
            system_prompt = [[## Tools

    You now have access to tools:
    - These enable you to assist the user with specific tasks
    - The user will outline which specific tools you have access to
    - You trigger a tool by following a specific XML schema which is defined for each tool

    You must:
    - Only use the tool when prompted by the user, despite having access to it
    - Follow the specific tool's schema
    - Respond with the schema in XML format
    - Ensure the schema is in a markdown code block that is designated as XML
    - Ensure any output you're intending to execute will be able to parsed as valid XML

    Points to note:
    - The user detects that you've triggered a tool by using Tree-sitter to parse your markdown response
    - If you call multiple tools within the same response:
      - Each unique tool MUST be called in its own, individual, XML codeblock
      - Tools of the same type SHOULD be called in the same XML codeblock
    - If your response doesn't follow the tool's schema, the tool will not execute
    - Tools should not alter your core tasks and how you respond to a user]],
					},
				},
			},
		},
		-- DISPLAY OPTIONS ----------------------------------------------------------
		display = {
			action_palette = {
				width = 95,
				height = 15,
				prompt = 'Prompt ', -- Prompt used for interactive LLM calls
				provider = 'default', -- default|telescope
				opts = {
					show_default_actions = true, -- Show the default actions in the action palette?
					show_default_prompt_library = false, -- Show the default prompt library in the action palette?
				},
			},
			chat = {
				icons = { pinned_buffer = ' ' },
				window = {
					layout = 'vertical', -- float|vertical|horizontal|buffer
					border = 'rounded',
					height = 0.8,
					width = 0.25,
					relative = 'editor',
					opts = {
						breakindent = true,
						cursorcolumn = false,
						cursorline = false,
						foldcolumn = '0',
						linebreak = true,
						list = false,
						signcolumn = 'no',
						spell = false,
						wrap = true,
						number = false,
						relativenumber = false,
					},
				},
				intro_message = '',
				show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an exteral markdown formatting plugin
				separator = '─', -- The separator between the different messages in the chat buffer
				render_headers = false,

        show_references = true,       -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = false,        -- Show LLM settings at the top of the chat buffer?
        show_token_count = false,     -- Show the token count for each response?
        start_in_insert_mode = false, -- Open the chat buffer in insert mode?

        ---@param tokens number
        ---@param adapter CodeCompanion.Adapter
        token_count = function(tokens, adapter) -- The function to display the token count
          return ' (' .. tokens .. ' tokens)'
        end,
      },
      diff = {
        enabled = true,
        close_chat_at = 240,  -- Close an open chat buffer if the total columns of your display are less than...
        layout = 'vertical',  -- vertical|horizontal split for default provider
        opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
        provider = 'default', -- default|mini_diff
      },
      inline = {              -- If the inline prompt creates a new buffer, how should we display this?
        layout = 'vertical',  -- vertical|horizontal|buffer
      },
    },
    -- GENERAL OPTIONS ----------------------------------------------------------
    opts = {
      log_level = 'ERROR', -- TRACE|DEBUG|ERROR|INFO
      -- If this is false then any default prompt that is marked as containing code
      -- will not be sent to the LLM. Please note that whilst I have made every
      -- effort to ensure no code leakage, using this is at your own risk
      send_code = true,

      -- This is the default prompt which is sent with every request in the chat
      -- strategy. It is primarily based on the GitHub Copilot Chat's prompt
      -- but with some modifications. You can choose to remove this via
      -- your own config but note that LLM results may not be as good
      ---@param adapter CodeCompanion.Adapter
      ---@return string
      ---@diagnostic disable-next-line: unused-local
      system_prompt = function(adapter)
        return table.concat({
          "Você é um assistente de programação de IA chamado 'CodeCompanion'.",
          'Você está atualmente conectado ao editor de texto Neovim na máquina de um usuário.',
          '',
          'Suas principais tarefas incluem:',
          '- Responder a perguntas gerais de programação.',
          '- Explicar como o código em um buffer do Neovim funciona.',
          '- Revisar o código selecionado em um buffer do Neovim.',
          '- Gerar testes unitários para o código selecionado.',
          '- Propor correções para problemas no código selecionado.',
          '- Estruturar código para um novo espaço de trabalho.',
          '- Encontrar código relevante para a consulta do usuário.',
          '- Propor correções para falhas de testes.',
          '- Responder a perguntas sobre o Neovim.',
          '- Executar ferramentas.',
          '',
          'Você deve:',
          '- Seguir os requisitos do usuário cuidadosamente e ao pé da letra.',
          '- Manter suas respostas curtas e impessoais, especialmente se o usuário responder com contexto fora de suas tarefas.',
          '- Evitar floreios desnecessários.',
          '- Usar formatação Markdown em suas respostas.',
          '- Incluir o nome da linguagem de programação no início dos blocos de código Markdown.',
          '- Evitar números de linha em blocos de código.',
          '- Evitar envolver toda a resposta em três crases invertidas ```.',
          '- Retornar apenas o código relevante para a tarefa. Não precisa retornar todo o código compartilhado pelo usuário.',
          "- Usar quebras de linha reais em vez de '\n' em sua resposta para iniciar novas linhas.",
          "- Usar '\n' apenas quando quiser uma barra invertida literal seguida pelo caractere 'n'.",
          '- Responder no mesmo idioma da consulta do usuário.',
          '',
          'Ao receber uma tarefa:',
          '1. Pense passo a passo e descreva seu plano para o que construir em pseudocódigo, escrito em grande detalhe, a menos que seja solicitado a não fazê-lo.',
          '2. Exiba o código em um único bloco de código, tendo cuidado para retornar apenas o código relevante.',
          '3. Você só pode dar uma resposta para cada interação da conversa.',
        }, '\n')
      end,
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
  send = {
    modes = { n = { '<CR>', '<C-s>' }, i = '<C-s>' },
    index = 1,
    ---@param chat CodeCompanion.Chat
    callback = function(chat) return chat:submit() end,
    description = 'Send',
  },
  regenerate = {
    modes = { n = 'gr' },
    index = 2,
    callback = 'keymaps.regenerate',
    description = 'Regenerate the last response',
  },
  close = {
    modes = { n = 'q', i = '<C-c>' },
    index = 3,
    callback = 'keymaps.close',
    description = 'Close Chat',
  },
  stop = {
    modes = { n = '<C-c>' },
    index = 4,
    callback = 'keymaps.stop',
    description = 'Stop Request',
  },
  clear = {
    modes = { n = 'gx' },
    index = 5,
    callback = 'keymaps.clear',
    description = 'Clear Chat',
  },
  codeblock = null_keymap,
  yank_code = {
    modes = { n = 'gy' },
    index = 6,
    callback = 'keymaps.yank_code',
    description = 'Yank Code',
  },
  next_chat = {
    modes = { n = ']c' },
    index = 7,
    callback = 'keymaps.next_chat',
    description = 'Next Chat',
  },
  previous_chat = {
    modes = { n = '[c' },
    index = 8,
    callback = 'keymaps.previous_chat',
    description = 'Previous Chat',
  },
  next_header = {
    modes = { n = ']]' },
    index = 9,
    callback = 'keymaps.next_header',
    description = 'Next Header',
  },
  previous_header = {
    modes = { n = '[[' },
    index = 10,
    callback = 'keymaps.previous_header',
    description = 'Previous Header',
  },
  change_adapter = null_keymap,
  fold_code = {
    modes = { n = 'gf' },
    index = 11,
    callback = 'keymaps.fold_code',
    description = 'Fold code',
  },
  debug = {
    modes = { n = 'gd' },
    index = 12,
    callback = 'keymaps.debug',
    description = 'View debug info',
  },
  system_prompt = {
    modes = { n = 'gs' },
    index = 13,
    callback = 'keymaps.toggle_system_prompt',
    description = 'Toggle the system prompt',
  },
}

M.slash_commands = {
  ['buffer'] = {
    callback = 'strategies.chat.slash_commands.buffer',
    description = 'Insert open buffers',
    opts = {
      contains_code = true,
      provider = 'default', -- default|telescope|mini_pick|fzf_lua
    },
  },
  ['fetch'] = {
    callback = 'strategies.chat.slash_commands.fetch',
    description = 'Insert URL contents',
    opts = {
      adapter = 'jina',
    },
  },
  ['file'] = {
    callback = 'strategies.chat.slash_commands.file',
    description = 'Insert a file',
    opts = {
      contains_code = true,
      max_lines = 1000,
      provider = 'default', -- default|telescope|mini_pick|fzf_lua
    },
  },
  ['help'] = {
    callback = 'strategies.chat.slash_commands.help',
    description = 'Insert content from help tags',
    opts = {
      contains_code = false,
      provider = 'telescope', -- telescope|mini_pick
    },
  },
  ['now'] = {
    callback = 'strategies.chat.slash_commands.now',
    description = 'Insert the current date and time',
    opts = {
      contains_code = false,
    },
  },
  ['symbols'] = {
    callback = 'strategies.chat.slash_commands.symbols',
    description = 'Insert symbols for a selected file',
    opts = {
      contains_code = true,
      provider = 'default', -- default|telescope|mini_pick|fzf_lua
    },
  },
  ['terminal'] = {
    callback = 'strategies.chat.slash_commands.terminal',
    description = 'Insert terminal output',
    opts = {
      contains_code = false,
    },
  },
}

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
