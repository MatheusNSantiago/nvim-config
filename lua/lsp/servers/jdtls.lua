local fn = vim.fn
local lsp = require('lsp')
local config = {}

local jdtls = require('jdtls')
local jdtls_dap = require('jdtls.dap')

-- Setup Workspace
local project_name = fn.fnamemodify(fn.getcwd(), ':p:h:t')
local workspace_dir = fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute('mkdir -p ' .. workspace_dir)

-- Setup extended Capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local lsp_path = fn.expand('$MASON/packages/jdtls')
config.cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xms1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens',
  'java.base/java.util=ALL-UNNAMED',
  '--add-opens',
  'java.base/java.lang=ALL-UNNAMED',
  '-javaagent:' .. lsp_path .. '/lombok.jar',
  '-jar',
  lsp_path .. '/plugins/org.eclipse.equinox.launcher_*.jar',
  '-configuration',
  lsp_path .. '/config_linux',
  '-data',
  workspace_dir,
}
config.root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })
config.capabilities = lsp.client_capabilities()
config.settings = {
  java = {
    eclipse = { downloadSources = true },
    configuration = { updateBuildConfiguration = 'interactive' },
    runtimes = {
      -- { name = 'JavaSE-11', path = '~/.sdkman/candidates/java/11.0.17-tem' },
      -- { name = 'JavaSE-18', path = '~/.sdkman/candidates/java/18.0.2-sem' },
    },
    maven = { downloadSources = true },
    implementationsCodeLens = { enabled = true },
    referencesCodeLens = { enabled = true },
    references = { includeDecompiledSources = true },
    inlayHints = {
      parameterNames = { enabled = 'all' }, -- literals, all, none
    },
    -- format = { enabled = false },
  },
  signatureHelp = { enabled = true },
  extendedClientCapabilities = extendedClientCapabilities,
  completion = {
    favoriteStaticMembers = {
      'org.hamcrest.MatcherAssert.assertThat',
      'org.hamcrest.Matchers.*',
      'org.hamcrest.CoreMatchers.*',
      'org.junit.jupiter.api.Assertions.*',
      'java.util.Objects.requireNonNull',
      'java.util.Objects.requireNonNullElse',
      'org.mockito.Mockito.*',
    },
  },
  sources = {
    organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
  },
}
-- init_options = {
--   bundles = {
--     vim.fn.expand('$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
--     -- unpack remaining bundles
--     (table.unpack or unpack)(vim.split(vim.fn.glob('$MASON/share/java-test/*.jar'), '\n', {})),
--   },
-- },

config.on_attach = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = 'auto' })
  lsp.common_on_attach(client, bufnr)

  pcall(vim.lsp.codelens.refresh)
  jdtls_dap.setup_dap_main_class_configs()
end

utils.api.augroup('Java LSP AutoCommands', {
  event = 'FileType',
  pattern = 'java',
  command = function()
    jdtls.start_or_attach(config)
    -- jdtls_dap.setup_dap_main_class_configs()
  end,
}, {
  event = 'LspAttach',
  pattern = '*.java',
  desc = 'Carrega as configs da main class no LspAttach, garantindo que o LSP esteja completamente attachado',
  command = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name ~= 'jdtls' then return end

    jdtls_dap.setup_dap_main_class_configs()
  end,
}, {
  event = 'BufWritePost',
  pattern = { '*.java' },
  command = function() pcall(vim.lsp.codelens.refresh) end,
})

local mappings = {
  C = {
    name = 'Java',
    o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", 'Organize Imports' },
    v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", 'Extract Variable' },
    c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", 'Extract Constant' },
    t = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", 'Test Method' },
    T = { "<Cmd>lua require'jdtls'.test_class()<CR>", 'Test Class' },
    u = { '<Cmd>JdtUpdateConfig<CR>', 'Update Config' },
  },
}

local vmappings = {
  C = {
    name = 'Java',
    v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", 'Extract Variable' },
    c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", 'Extract Constant' },
    m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", 'Extract Method' },
  },
}

return config