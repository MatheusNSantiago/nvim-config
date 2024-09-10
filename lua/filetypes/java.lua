local M = {}

---@type FiletypeSettings
M.settings = {
	mappings = {
		{ 'n', '<leader>r', function() M.run_program() end },
	},
	on_buf_enter = function(arg)
		-- local config = {
		--   cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls') },
		--   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
		-- }
		-- require('jdtls').start_or_attach(config)

		-- vim.defer_fn(function()
		-- 	log('FOO')
		-- 	utils.api.feedkeys('q')
		-- end, 2000)
	end,
}

M.run_program = function()
	vim.cmd('silent !mvn package ')
	vim.cmd('TermExec cmd="clear && java -cp target/my-app-1.0-SNAPSHOT.jar com.mycompany.app.App"')

	vim.schedule(function()
		vim.cmd('wincmd j')
		vim.cmd('wincmd k')

		vim.defer_fn(function()
			vim.cmd('stopinsert')
			utils.api.feedkeys('ç')
		end, 50)
	end)
end

return M.settings
