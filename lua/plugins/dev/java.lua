local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'mfussenegger/nvim-jdtls',
		ft = { 'java' },
		config = M.config,
	}
end

local function get_config()
	local jdtls_path = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls')
	local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

	if launcher == '' then
		vim.notify('[java] jdtls não encontrado. Execute :MasonInstall jdtls', vim.log.levels.ERROR)
		return nil
	end

	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
	local workspace_dir = vim.fn.expand('~/.local/share/eclipse/' .. project_name)

	return {
		cmd = {
			'/usr/lib/jvm/java-21-openjdk/bin/java',
			'-Declipse.application=org.eclipse.jdt.ls.core.id1',
			'-Dosgi.bundles.defaultStartLevel=4',
			'-Declipse.product=org.eclipse.jdt.ls.core.product',
			'-Dlog.protocol=true',
			'-Dlog.level=ALL',
			'-Xmx1g',
			'--add-modules=ALL-SYSTEM',
			'--add-opens', 'java.base/java.util=ALL-UNNAMED',
			'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
			'-jar', launcher,
			'-configuration', jdtls_path .. '/config_linux',
			'-data', workspace_dir,
		},
		root_dir = require('jdtls.setup').find_root({
			'pom.xml',
			'build.gradle',
			'build.gradle.kts',
			'settings.gradle',
			'settings.gradle.kts',
			'WORKSPACE',
			'.git',
		}),
		settings = {
			java = {
				configuration = {
					runtimes = {
						{ name = 'JavaSE-21', path = '/usr/lib/jvm/java-21-openjdk', default = true },
						{ name = 'JavaSE-8', path = '/opt/desenv/libs/jdk1.8.0_281/' },
					},
				},
				inlayHints = { parameterNames = { enabled = 'all' } },
			},
		},
		on_attach = require('lsp').common_on_attach,
		capabilities = require('lsp').client_capabilities(),
	}
end

function M.config()
	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'java',
		callback = function()
			local cfg = get_config()
			if cfg then require('jdtls').start_or_attach(cfg) end
		end,
	})

	-- Dispara para o buffer que causou o carregamento do plugin
	if vim.bo.filetype == 'java' then
		local cfg = get_config()
		if cfg then require('jdtls').start_or_attach(cfg) end
	end
end

return M
