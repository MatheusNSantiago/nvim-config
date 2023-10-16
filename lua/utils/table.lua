local Table = {}

---Finds the first element in a table that satisfies a given predicate.
---@param table table The table to search in.
---@param predicate fun(entry: any): boolean The predicate to satisfy.
---@return any|nil: The first element that satisfies the predicate, or nil if no element is found.
function Table.find_first(table, predicate)
	for _, entry in pairs(table) do
		if predicate(entry) then return entry end
	end
	return nil
end

---Determines if a table contains an element that satisfies a given predicate.
---@param table table The table to search in.
---@param predicate fun(entry: any): boolean The predicate to satisfy.
---@return boolean: Whether the table contains an element that satisfies the predicate.
function Table.contains(table, predicate) return Table.find_first(table, predicate) ~= nil end

return Table
