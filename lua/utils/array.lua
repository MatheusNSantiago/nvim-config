---@class Array
local Array = Class('Array')

---@param ... any
---@return Array
function Array:initialize(...)
  local temp = { ... }
  if #temp == 0 then return self end

  if #temp == 1 and type(temp[1]) == 'table' then --
    temp = temp[1]
  end

  for _, v in ipairs(temp) do
    self:push(v)
  end
  return self
end

function Array:from(t, f)
  local new_arr = Array:initialize()
  if type(t) == 'table' then
    for k, v in pairs(t) do
      new_arr:push(f and f(v, k) or v)
    end
  elseif type(t) == 'string' then
    for i = 1, #t do
      new_arr:push(f and f(t:sub(i, i), i) or t:sub(i, i))
    end
  end
  return new_arr
end

function Array:size() return #self end

---@param f fun(e: any, idx?: number)
function Array:foreach(f)
  log(self)
  for k, v in pairs(self) do
    f(v, k)
  end
end

function Array:map(f)
  local new_arr = Array:initialize()
  for k, v in pairs(self) do
    new_arr:push(f(v, k))
  end
  return new_arr
end

---@param predicate fun(e: any, idx?: number): boolean
function Array:filter(predicate)
  local new_arr = Array:initialize()

  self:foreach(function(e)
    if predicate(e) then new_arr:push(e) end
  end)
  return new_arr
end

function Array:push(v)
  local size = self:size()
  self[size + 1] = v
  return self
end

function Array:pop()
  local size = self:size()
  local v = self[size]
  self[size] = nil
  return v
end

function Array:shift()
  local size = self:size()
  local v = self[1]
  for i = 1, size - 1 do
    self[i] = self[i + 1]
  end
  self[size] = nil
  return v
end

function Array:join(sep)
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
---@return any|nil: The first element that satisfies the predicate, or nil if no element is found.
function Array:find_first(predicate)
  for _, entry in ipairs(self) do
    if predicate(entry) then return entry end
  end
  return nil
end

---@param value any: The value to search for.
---@return boolean: Whether the array contains the value.
function Array:contains(value)
  return (self:find_first(function(e) return e == value end) ~= nil)
end

function Array:is_empty() return self:size() == 0 end

function Array:to_table() return { unpack(self) } end

function Array:extend(arr)
  for _, v in ipairs(arr) do
    self:push(v)
  end
  return self
end

---@alias Array.constructor fun(...): Array
---@type Array|Array.constructor
local _Array = Array
return _Array
