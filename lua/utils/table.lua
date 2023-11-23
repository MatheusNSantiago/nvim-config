local M = {}

---Finds the first element in a table that satisfies a given predicate.
---@param table table The table to search in.
---@param predicate fun(entry: any): boolean The predicate to satisfy.
---@return any|nil: The first element that satisfies the predicate, or nil if no element is found.
function M.find_first(table, predicate)
	for _, entry in pairs(table) do
		if predicate(entry) then return entry end
	end
	return nil
end

--- Checks if an element is present in a table.
---@param table table The table to search in.
---@param element any The element to search for.
---@return boolean: Returns true if the element is found, false otherwise.
function M.contains(table, element)
	return M.find_first(table, function(e) return e == element end) ~= nil
end

function M.count(table)
	local count = 0
	utils.foreach(table, function() count = count + 1 end)
	return count
end

function M.filter(tbl, predicate)
	local filtered = {}
	utils.foreach(tbl, function(e)
		if predicate(e) then table.insert(filtered, e) end
	end)
	return filtered
end

function M.count_occurrences(table, element)
	local count = 0
	utils.foreach(table, function(e)
		if e == element then count = count + 1 end
	end)
	return count
end

function M.any(table, predicate) return M.find_first(table, predicate) ~= nil end

function M.map(table, callback) return vim.tbl_map(callback, table) end

return M
