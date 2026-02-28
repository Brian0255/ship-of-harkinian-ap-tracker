

local Location = {}
Location.__index = Location

setmetatable(Location, {
    __call = function(cls, ...)
        return cls.new(...)
    end,
})

function Location.new(name, parent_region, access_rule)
    local self = {}
    setmetatable(self, Location)

    self.name = name
    self.parent_region = parent_region
    self.access_rule = access_rule or function() return true end

    self.event_item = nil

    return self
end

function Location:can_reach(state)
    assert(self.parent_region, string.format("called can_reach on a Location %s with no parent_region", self.name))
    return self.parent_region:can_reach(state) and self.access_rule(state)
end

function Location:set_event_item(event_item)
    self.event_item = event_item
end

return Location
