local Entrance = {
    total_calls = 0
}
Entrance.__index = Entrance

setmetatable(
    Entrance,
    {
        __call = function(cls, ...)
            return cls.new(...)
        end
    }
)

function Entrance.new(name, parent_region)
    local self = {}
    setmetatable(self, Entrance)

    self.access_rule = function()
        return true
    end
    self.hide_path = false
    self.name = name
    self.parent_region = parent_region
    self.connected_region = nil

    return self
end

function Entrance:can_reach(state)
    if self.access_rule(state) then
        return self.parent_region:can_reach(state)
    end
    return ACCESS_NONE
end

function Entrance:connect(region)
    self.connected_region = region
    table.insert(region.entrances, self)
end

return Entrance
