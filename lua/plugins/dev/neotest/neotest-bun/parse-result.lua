---@class NeotestBunCase
---@field file string
---@field name string
---@field classname? string
---@field status string
---@field errors? { message: string }[]

local function xmlToNeotestResults(xml_string)
	local xml_parser = require('neotest.lib.xml')
	local ok, root = pcall(xml_parser.parse, xml_string)
	if not ok or not root or not root.testsuites then
		return {}
	end

	local cases = {}

	---Processa um <testsuite> recursivamente, coletando todos os <testcase>
	---@param suite table
	---@param file_path string|nil
	local function processSuite(suite, file_path)
		if type(suite) ~= 'table' then
			return
		end

		local attr = suite._attr or {}
		local current_file_path = attr.file or file_path or attr.name

		-- processa os testcases deste suite
		if suite.testcase then
			local testcases = suite.testcase

			-- neotest.lib.xml representa single-item arrays como tabelas simples
			if #testcases == 0 then
				testcases = { testcases }
			end

			for _, testcase in ipairs(testcases) do
				if type(testcase) == 'table' and testcase._attr then
					local tattr = testcase._attr
					local test_name = tattr.name
					local classname = tattr.classname
					local file = tattr.file or current_file_path

					local status = 'passed'
					local errors = nil

					if testcase.skipped then
						status = 'skipped'
					elseif testcase.failure or testcase.error then
						status = 'failed'
						errors = {}

						local failure_type = ''

						if testcase.failure and testcase.failure._attr and testcase.failure._attr.type then
							failure_type = testcase.failure._attr.type
						end

						table.insert(errors, {
							message = failure_type,
						})
					end

					table.insert(cases, {
						file = file or '',
						name = test_name or '',
						classname = classname,
						status = status,
						errors = errors,
					})
				end
			end
		end

		-- suites aninhados
		if suite.testsuite then
			local nested_suites = suite.testsuite
			if #nested_suites == 0 then
				nested_suites = { nested_suites }
			end
			for _, nested in ipairs(nested_suites) do
				processSuite(nested, current_file_path)
			end
		end
	end

	-- A estrutura típica é: root.testsuites.testsuite[].testsuite[]
	local testsuites = root.testsuites
	if #testsuites == 0 then
		testsuites = { testsuites }
	end

	for _, testsuite in ipairs(testsuites) do
		if testsuite.testsuite then
			local inner = testsuite.testsuite
			if #inner == 0 then
				inner = { inner }
			end

			for _, suite in ipairs(inner) do
				processSuite(suite, suite._attr and suite._attr.file or suite._attr and suite._attr.name)
			end
		end
	end

	return cases
end

return {
	xmlToNeotestResults = xmlToNeotestResults,
}

