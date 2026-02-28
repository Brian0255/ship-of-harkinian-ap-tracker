local Deque = {}
Deque.__index = Deque

setmetatable(Deque, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

function Deque.new(items)
    local self = {}
    setmetatable(self, Deque)

    self.front = 0
    self.back = -1
    self.items = {}

    for _, item in ipairs(items or {}) do
        self:append(item)
    end

    return self
end

function Deque:append(item)
    self:push_back(item)
end

function Deque:extend(items)
    for _, item in ipairs(items) do
        self:append(item)
    end
end

function Deque:is_empty()
	return self.front > self.back
end

function Deque:peek_front()
	return self.items[self.front]
end

function Deque:peek_back()
	return self.items[self.back]
end

function Deque:push_front(value)
	self.front = self.front - 1
	self.items[self.front] = value
end

function Deque:pop_front()
	if self.front <= self.back then
		local result = self.items[self.front]
		self.items[self.front] = nil
		self.front = self.front + 1
		return result
	end
end

function Deque:push_back(value)
	self.back = self.back + 1
	self.items[self.back] = value
end

function Deque:pop_back()
	if self.front <= self.back then
		local result = self.items[self.back]
		self.items[self.back] = nil
		self.back = self.back - 1
		return result
	end
end

return Deque
