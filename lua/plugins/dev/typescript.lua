local M = {}

function M.setup()
  return {
    'pmizio/typescript-tools.nvim',
    config = M.config,
  }
end

function M.config()
  local tsserver_configs = require('lsp').get_configs_for('tsserver')
  local typescript_tools_configs = {
    -- Note that handlers can be used to override certain LSP methods.
    -- For example, you can use the filter_diagnostics helper to ignore specific errors:
    -- handlers = {
    --   ['textDocument/publishDiagnostics'] = require("typescript-tools.api").filter_diagnostics(
    --   -- Ignore 'This may be converted to an async function' diagnostics.
    --     { 80006 }
    --   ),
    -- },
    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = 'insert_leave',
      -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
      -- specify commands exposed as code_actions
      expose_as_code_action = {},
      -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
      -- not exists then standard path resolution strategy is applied
      tsserver_path = nil,
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = 'auto',
      -- described below
      -- You can also pass custom configuration options that will be passed to tsserver instance.
      -- You can find available options in typescript repository (e.g. for version 5.0.4 of typescript):
      -- tsserver_file_preferences: https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
      -- tsserver_format_options: https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3418
      -- INFO: this two defaults are same as in vscode
      tsserver_file_preferences = {
        quotePreference = 'auto',
        importModuleSpecifierEnding = 'auto',
        jsxAttributeCompletionStyle = 'auto',
        allowTextChangesInNewFiles = true,
        providePrefixAndSuffixTextForRename = true,
        allowRenameOfImportPath = true,
        includeAutomaticOptionalChainCompletions = true,
        provideRefactorNotApplicableReason = true,
        generateReturnInDocTemplate = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsWithSnippetText = true,
        includeCompletionsWithClassMemberSnippets = true,
        includeCompletionsWithObjectLiteralMethodSnippets = true,
        useLabelDetailsInCompletionEntries = true,
        allowIncompleteCompletions = true,
        displayPartsForJSDoc = true,
        disableLineTextInReferences = true,
        includeInlayParameterNameHints = 'none',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = false,
      },
      tsserver_format_options = {
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterConstructor = false,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        insertSpaceBeforeFunctionParenthesis = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
        insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
        insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
        insertSpaceAfterTypeAssertion = false,
        placeOpenBraceOnNewLineForFunctions = false,
        placeOpenBraceOnNewLineForControlBlocks = false,
        semicolons = 'ignore',
        indentSwitchCase = true,
      },
    },
  }
  local combined_configs = vim.tbl_deep_extend('force', tsserver_configs, typescript_tools_configs)

  require('typescript-tools').setup(combined_configs)
end

return M
