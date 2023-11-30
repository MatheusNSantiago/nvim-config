---@class Set
local Set = Class('Set')

---@param ... any
---@return Set
function Set:initialize(...)
  local temp_arr = { ... }
  if #temp_arr == 0 then return self end

  if #temp_arr == 1 and type(temp_arr[1]) == 'table' then --
    temp_arr = temp_arr[1]
  end

  for _, v in ipairs(temp_arr) do
    if not self:has(v) then --
      self:push(v)
    end
  end

  return self
end

function Set:has(element)
  for _, v in ipairs(self) do
    if v == element then return true end
  end
  return false
end

function Set.is_set(element)
  if type(element) ~= 'table' then return false end
  local ok, is_set = pcall(function() return element:is_instance_of(Set) end)

  return ok and is_set
end

function Set:size() return #self end

---@param f fun(e: any, idx?: number)
function Set:foreach(f)
  for k, v in ipairs(self) do
    f(v, k)
  end
end

---@param f fun(e: any, idx?: number): any
function Set:map(f)
  for k, v in ipairs(self) do
    self[k] = f(v, k)
  end
  return self
end

---@param predicate fun(e: any, idx?: number): boolean
function Set:filter(predicate)
  local new_arr = Set:initialize()

  self:foreach(function(e)
    if predicate(e) then new_arr:push(e) end
  end)
  return new_arr
end

function Set:push(element)
  if not self:has(element) then --
    table.insert(self, element)
  end
end

function Set:remove(value)
  local _, idx = self:find_first(function(e) return e == value end)
  if idx == nil then
    print('Value' .. value .. ' not found in Set')
    return self
  end
  table.remove(self, idx)
end

function Set:join(sep)
  sep = sep or ''
  local res = ''
  for k, v in pairs(self) do
    if k == 1 then
      res = res .. tostring(v)
    else
      res = res .. sep .. tostring(v)
    end
  end
  return res
end

---Finds the first element in a list that satisfies a given predicate.
---@param predicate fun(entry: any): boolean The predicate to satisfy.
---@return any, number|nil: The first element that satisfies the predicate, and its index.
function Set:find_first(predicate)
  for i, entry in ipairs(self) do
    if predicate(entry) then --
      return entry, i
    end
  end
  return nil, nil
end

---@param value any: The value to search for.
---@return boolean: Whether the array contains the value.
function Set:contains(value)
  return (self:find_first(function(e) return e == value end) ~= nil)
end

function Set:is_empty() return self:size() == 0 end

function Set:to_table() return { unpack(self) } end

function Set:extend(arr)
  for _, v in ipairs(arr) do
    self:push(v)
  end
  return self
end

---@alias Set.constructor fun(...): Set
---@type Set|Set.constructor
local _Set = Set
return _Set
