local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'Goose97/timber.nvim',
		version = '*', -- Use for stability; omit to use `main` branch for the latest features
		keys = {
			{ '<leader>lk', mode = { 'n', 'x' }, desc = 'timber: insert log below' },
			{ '<leader>ll', mode = { 'n', 'x' }, desc = 'timber: insert log above' },
		},
		config = M.config,
	}
end

function M.config()
	require('timber').setup({
		log_templates = {
			default = {
				javascript = [[console.log("%log_target", %log_target)]],
				typescript = [[console.log("%log_target", %log_target)]],
				jsx = [[console.log("%log_target", %log_target)]],
				tsx = [[console.log("%log_target", %log_target)]],
				lua = [[print("%log_target", %log_target)]],
				ruby = [[puts("%log_target #{%log_target}")]],
				elixir = [[IO.inspect(%log_target, label: "%log_target")]],
				go = [[log.Printf("%log_target: %v\n", %log_target)]],
				rust = [[println!("%log_target: {:#?}", %log_target);]],
				python = [[print("%log_target", %log_target)]],
				c = [[printf("%log_target: %s\n", %log_target);]],
				cpp = [[std::cout << "%log_target: " << %log_target << std::endl;]],
				java = [[System.out.println("%log_target: " + %log_target);]],
				c_sharp = [[Console.WriteLine($"%log_target: {%log_target}");]],
			},
			plain = {
				javascript = [[console.log("%insert_cursor")]],
				typescript = [[console.log("%insert_cursor")]],
				jsx = [[console.log("%insert_cursor")]],
				tsx = [[console.log("%insert_cursor")]],
				lua = [[print("%insert_cursor")]],
				ruby = [[puts("%insert_cursor")]],
				elixir = [[IO.puts(%insert_cursor)]],
				go = [[log.Printf("%insert_cursor")]],
				rust = [[println!("%insert_cursor");]],
				python = [[print("%insert_cursor")]],
				c = [[printf("%insert_cursor \n");]],
				cpp = [[std::cout << "%insert_cursor" << std::endl;]],
				java = [[System.out.println("%insert_cursor");]],
				c_sharp = [[Console.WriteLine("%insert_cursor");]],
			},
		},
		batch_log_templates = {
			default = {
				javascript = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
				typescript = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
				jsx = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
				tsx = [[console.log({ %repeat<"%log_target": %log_target><, > })]],
				lua = [[print(string.format("%repeat<%log_target=%s><, >", %repeat<%log_target><, >))]],
				ruby = [[puts("%repeat<%log_target: #{%log_target}><, >")]],
				elixir = [[IO.inspect({ %repeat<%log_target><, > })]],
				go = [[log.Printf("%repeat<%log_target: %v><, >\n", %repeat<%log_target><, >)]],
				rust = [[println!("%repeat<%log_target: {:#?}><, >", %repeat<%log_target><, >);]],
				python = [[print(%repeat<"%log_target", %log_target><, >)]],
				c = [[printf("%repeat<%log_target: %s><, >\n", %repeat<%log_target><, >);]],
				cpp = [[std::cout %repeat<<< "%log_target: " << %log_target>< << "\n  " > << std::endl;]],
				java = [[System.out.printf("%repeat<%log_target=%s><, >%n", %repeat<%log_target><, >);]],
				c_sharp = [[Console.WriteLine($"%repeat<%log_target: {%log_target}><, >");]],
			},
		},
		-- The string to search for when deleting or commenting log statements
		-- Can be used in log templates as %log_marker placeholder
		log_marker = '🪵',
		-- Controls the flash highlight after a log statement is inserted
		-- or a log target is added to a batch
		highlight = {
			on_insert = true,
			on_add_to_batch = true,
			duration = 500,
		},
		keymaps = {
			-- Set to false to disable the default keymap for specific actions
			-- insert_log_below = false,
			insert_log_below = '<leader>lk', --'glk',
			insert_log_above = '<leader>ll', --'gll',
			insert_plain_log_below = false, -- 'glo',
			insert_plain_log_above = false, -- 'gl<S-o>',
			insert_batch_log = false, -- 'glb',
			add_log_targets_to_batch = false, -- 'gla',
			insert_log_below_operator = false, -- 'g<S-l>j',
			insert_log_above_operator = false, -- 'g<S-l>k',
			insert_batch_log_operator = false, -- 'g<S-l>b',
			add_log_targets_to_batch_operator = false, -- 'g<S-l>a',
		},
		-- Set to false to disable all default keymaps
		default_keymaps_enabled = true,
		log_watcher = {
			enabled = false,
			sources = {},
			preview_snippet_length = 32,
		},
	})
end

return M
