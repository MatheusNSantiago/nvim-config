---@diagnostic disable: unused-local, assign-type-mismatch, duplicate-set-field
require('neotest.types')
local lib = require('neotest.lib')
local parser = require('plugins.dev.neotest.neotest-bun.parse-result')

local function readXMLFile(file_path)
	if not file_path then return nil, 'no file_path' end

	local file, err = io.open(file_path, 'r')
	if not file then return nil, err end

	local content = file:read('*all')
	file:close()

	return content
end

---@class neotest.Adapter
Adapter = {
	name = 'neotest-bun',

	---Find the project root directory given a current directory to work from.
	---Should no root be found, the adapter can still be used in a non-project context if a test file matches.
	---@async
	---@param dir string @Directory to treat as cwd
	---@return string | nil @Absolute root dir of test suite
	root = function(dir)
		-- package.json é um bom proxy de root em projetos JS/TS
		return lib.files.match_root_pattern('package.json')(dir)
	end,

	---Filter directories when searching for test files
	---@async
	---@param name string Name of directory
	---@param rel_path string Path to directory, relative to root
	---@param root string Root directory of project
	---@return boolean
	filter_dir = function(name, rel_path, root) return name ~= 'node_modules' end,

	---@async
	---@param file_path string
	---@return boolean
	is_test_file = function(file_path)
		if file_path == nil then return false end
		local is_test_file = false

		for _, pattern in ipairs({
			'%.test%.ts$',
			'%.test%.tsx$',
			'%.spec%.ts$',
			'%.spec%.tsx$',
			'%.test%.js$',
			'%.test%.jsx$',
			'%.spec%.js$',
			'%.spec%.jsx$',
		}) do
			local match_result = string.match(file_path, pattern)
			if match_result then
				is_test_file = true
				break
			end
		end

		return is_test_file
	end,

	---Given a file path, parse all the tests within it.
	---@async
	---@param file_path string Absolute file path
	---@return neotest.Tree | nil
	discover_positions = function(file_path)
		local query = [[
    ; -- Namespaces --
    ; Matches: `describe('context', () => {})`
    ((call_expression
      function: (identifier) @func_name (#eq? @func_name "describe")
      arguments: (arguments (string (string_fragment) @namespace.name) (arrow_function))
    )) @namespace.definition
    ; Matches: `describe('context', function() {})`
    ((call_expression
      function: (identifier) @func_name (#eq? @func_name "describe")
      arguments: (arguments (string (string_fragment) @namespace.name) (function_expression))
    )) @namespace.definition
    ; Matches: `describe.only('context', () => {})`
    ((call_expression
      function: (member_expression
        object: (identifier) @func_name (#any-of? @func_name "describe")
      )
      arguments: (arguments (string (string_fragment) @namespace.name) (arrow_function))
    )) @namespace.definition
    ; Matches: `describe.only('context', function() {})`
    ((call_expression
      function: (member_expression
        object: (identifier) @func_name (#any-of? @func_name "describe")
      )
      arguments: (arguments (string (string_fragment) @namespace.name) (function_expression))
    )) @namespace.definition
    ; Matches: `describe.each(['data'])('context', () => {})`
    ((call_expression
      function: (call_expression
        function: (member_expression
          object: (identifier) @func_name (#any-of? @func_name "describe")
        )
      )
      arguments: (arguments (string (string_fragment) @namespace.name) (arrow_function))
    )) @namespace.definition
    ; Matches: `describe.each(['data'])('context', function() {})`
    ((call_expression
      function: (call_expression
        function: (member_expression
          object: (identifier) @func_name (#any-of? @func_name "describe")
        )
      )
      arguments: (arguments (string (string_fragment) @namespace.name) (function_expression))
    )) @namespace.definition

    ; -- Tests --
    ; Matches: `test('test') / it('test')`
    ((call_expression
      function: (identifier) @func_name (#any-of? @func_name "it" "test")
      arguments: (arguments (string (string_fragment) @test.name) [(arrow_function) (function_expression)])
    )) @test.definition
    ; Matches: `test.only('test') / it.only('test')`
    ((call_expression
      function: (member_expression
        object: (identifier) @func_name (#any-of? @func_name "test" "it")
      )
      arguments: (arguments (string (string_fragment) @test.name) [(arrow_function) (function_expression)])
    )) @test.definition
    ; Matches: `test.each(['data'])('test') / it.each(['data'])('test')`
    ((call_expression
      function: (call_expression
        function: (member_expression
          object: (identifier) @func_name (#any-of? @func_name "it" "test")
          property: (property_identifier) @each_property (#eq? @each_property "each")
        )
      )
      arguments: (arguments (string (string_fragment) @test.name) [(arrow_function) (function_expression)])
    )) @test.definition
		]]

		local positions = lib.treesitter.parse_positions(file_path, query, {
			nested_tests = true,
			-- importante: usa a função deste módulo, não um require("neotest-bun") externo
			build_position = Adapter.build_position,
		})

		return positions
	end,

	---@param args neotest.RunArgs
	---@return nil | neotest.RunSpec | neotest.RunSpec[]
	build_spec = function(args)
		local position = args.tree:data()

		-- Arquivo temporário para o JUnit (sem usar vim.fn.tempname, que quebra em fast event)
		local results_path = os.tmpname() .. '.xml'

		local command = {
			'bun',
			'test',
			'--reporter=junit',
			'--reporter-outfile=' .. results_path,
		}

		-- Rodando um teste específico
		if position.type == 'test' then
			table.insert(command, '--test-name-pattern')
			table.insert(command, position.name)
		end

		-- Rodando arquivo específico
		if position.path then table.insert(command, position.path) end

		return {
			command = command,
			context = {
				file = position.path,
				pos_id = position.id,
				results_path = results_path,
			},
		}
	end,

	---@async
	---@param spec neotest.RunSpec
	---@param _result neotest.StrategyResult
	---@param tree neotest.Tree
	---@return table<string, neotest.Result>
	results = function(spec, _result, tree)
		local results_path = spec.context and spec.context.results_path
		local xml_content, open_err = readXMLFile(results_path)

		-- Tentamos o caminho feliz: XML gerado pelo bun
		if xml_content then
			local cases = parser.xmlToNeotestResults(xml_content)

			if results_path then
				-- melhor esforço; se falhar, tanto faz
				pcall(os.remove, results_path)
			end

			-- Indexa casos por (abs_file, test_name) pra casar com a árvore do neotest
			local by_key = {}
			local cwd = vim.fn.getcwd()

			for _, case in ipairs(cases) do
				local file = case.file
				local abs

				if file and #file > 0 then
					if file:sub(1, 1) == '/' then
						abs = vim.fn.fnamemodify(file, ':p')
					else
						abs = vim.fn.fnamemodify(cwd .. '/' .. file, ':p')
					end
				elseif spec.context and spec.context.file then
					abs = vim.fn.fnamemodify(spec.context.file, ':p')
				end

				if abs and case.name then
					local key = abs .. '::' .. case.name
					by_key[key] = case
				end
			end

			local formatted_results = {}

			-- Percorre os nós da árvore e casa por (arquivo + nome do teste)
			for _, node in tree:iter_nodes() do
				local pos = node:data()
				if pos.type == 'test' and pos.path and pos.name then
					local abs_path = vim.fn.fnamemodify(pos.path, ':p')
					local key = abs_path .. '::' .. pos.name
					local case = by_key[key]

					if case then formatted_results[pos.id] = {
						status = case.status,
						errors = case.errors,
					} end
				end
			end

			-- Se conseguimos mapear pelo menos um teste, ótimo
			if next(formatted_results) ~= nil then return formatted_results end
			-- Se não mapeou nada, cai no fallback abaixo
		end

		-- Fallback: sem XML ou não conseguimos casar testes -> marca pelo exit code
		local formatted_results = {}
		local pos_id = spec.context and spec.context.pos_id
		local status = _result.code == 0 and 'passed' or 'failed'

		if pos_id then
			formatted_results[pos_id] = {
				status = status,
				short = 'bun test exit code: ' .. tostring(_result.code),
			}
		end

		return formatted_results
	end,
}

local function get_match_type(captured_nodes)
	if captured_nodes['test.name'] then return 'test' end
	if captured_nodes['namespace.name'] then return 'namespace' end
end

function Adapter.build_position(file_path, source, captured_nodes)
	local match_type = get_match_type(captured_nodes)
	if not match_type then return end

	---@type string
	local name = vim.treesitter.get_node_text(captured_nodes[match_type .. '.name'], source)
	local definition = captured_nodes[match_type .. '.definition']

	return {
		type = match_type,
		path = file_path,
		name = name,
		range = { definition:range() },
	}
end

function Adapter.setup(_opts) return Adapter end

setmetatable(Adapter, {
	__call = function(_, opts)
		opts = opts or {}
		return Adapter
	end,
})

return Adapter
