local M = {}

function M.setup()
	return {
		'nvim-java/nvim-java',
		config = M.config,
		ft = { 'java' },
		-- enabled = not utils.is_wsl(),
		enabled = true,
		dependencies = {
			'nvim-java/nvim-java-refactor',
			'nvim-java/lua-async-await',
			'nvim-java/nvim-java-core',
			'nvim-java/nvim-java-test',
			'nvim-java/nvim-java-dap',
			'mfussenegger/nvim-dap',
			'MunifTanjim/nui.nvim',
			'neovim/nvim-lspconfig',
		},
	}
end

function M.config()
	require('java').setup({
		java_test = { enable = false },
		java_debug_adapter = { enable = false },
		spring_boot_tools = { enable = true },
		jdk = { auto_install = true }, -- install jdk using mason.nvim
		notifications = { dap = false }, -- enable 'Configuring DAP' & 'DAP configured' messages on start up
		-- We do multiple verifications to make sure things are in place to run this plugin
		-- verification = {
		-- 	-- nvim-java checks for the order of execution of following
		-- 	-- * require('java').setup()
		-- 	-- * require('lspconfig').jdtls.setup()
		-- 	-- IF they are not executed in the correct order, you will see a error notification.
		-- 	-- Set following to false to disable the notification if you know what you are doing
		-- 	invalid_order = true,
		--
		-- 	-- nvim-java checks if the require('java').setup() is called multiple times.
		-- 	-- IF there are multiple setup calls are executed, an error will be shown
		-- 	-- Set following property value to false to disable the notification if you know what you are doing
		-- 	duplicate_setup_calls = true,
		--
		-- 	-- nvim-java checks if nvim-java/mason-registry is added correctly to mason.nvim plugin.
		-- 	-- IF it's not registered correctly, an error will be thrown and nvim-java will stop setup
		-- 	invalid_mason_registry = true,
		-- },
		root_markers = {
			'settings.gradle',
			'settings.gradle.kts',
			'pom.xml',
			'build.gradle',
			'mvnw',
			'gradlew',
			'build.gradle',
			'build.gradle.kts',
			'.git',
		},
	})
end

return M
