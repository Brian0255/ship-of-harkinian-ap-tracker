local Entrance = {}
Entrance.__index = Entrance

setmetatable(Entrance, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

function Entrance.new(name, parent_region)
    local self = {}
    setmetatable(self, Entrance)

    self.access_rule = function() return true end
    self.hide_path = false
    self.name = name
    self.parent_region = parent_region
    self.connected_region = nil

    return self
end

function Entrance:can_reach(state)
    assert(self.parent_region,
    string.format('called can_reach on an Entrance "%s" with no parent_region', tostring(self)))
    return (self.parent_region:can_reach(state) and self.access_rule(state))
end

function Entrance:connect(region)
    self.connected_region = region
    table.insert(region.entrances, self)
end

return Entrance
