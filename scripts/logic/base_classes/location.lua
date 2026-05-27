

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
    --assert(self.parent_region, string.format("called can_reach on a Location %s with no parent_region", self.name))
    local parent_access_level = self.parent_region:can_reach(state)
    if parent_access_level == ACCESS_NONE then
        return ACCESS_NONE
    end
    if self.access_rule(state) then
        return parent_access_level
    end

    local was_glitched = state.is_glitched
    state:set_glitched_state(true)
    if self.access_rule(state) then
        state:set_glitched_state(was_glitched)
        return ACCESS_SEQUENCEBREAK
    end
    state:set_glitched_state(was_glitched)
    return ACCESS_NONE
end

function Location:set_event_item(event_item)
    self.event_item = event_item
end

function Location:remove_event_item()
    self.event_item = nil
end

return Location
