local function Table(o)
	return setmetatable(o or {}, {__index = function(t, k) return table[k] end})
end

function table:removeValue(value)
	assert(type(value) ~= 'nil', 'arg 1 missing value')
	for i=#self, 1, -1  do
		if (self[i] == value) then
			self:remove(i)
			return true
		end
	end
	return false
end

function table:contains(value)
	assert(type(value) ~= 'nil', 'arg 1 missing value')
	for i=1, #self do
		if (self[i] == value) then
			return true
		end
	end
	return false
end

function table:map(func)
	assert(type(func) == 'function', 'arg 1 not a function')
	local new = Table()
	for i=1, #self do
		new[i] = func(self[i], i, self)
	end
	return new
end

function table:filter(func)
	assert(type(func) == 'function', 'arg 1 not a function')
	local new = Table()
	for i=1, #self do
		local value = self[i]
		if func(value, i, self) then
			new[#new+1] = value
		end
	end
	return new
end

function table:reduce(func, startval)
	assert(type(func) == 'function', 'arg 1 not a function')
	local value = startval or 0
	for i=1, #self do
		value = func(value, self[i], startval)
	end
	return value
end

function table:copy()
	local new = Table()
	for k, v in pairs(self) do
		if (type(v) == "table") then
			v = v:copy()
		end
		new[k] = v
	end
	return new
end

return Table