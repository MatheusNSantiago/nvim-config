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

return M
