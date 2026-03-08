local Entrance = require("scripts/logic/base_classes/entrance")

local Region = {}
Region.__index = Region

setmetatable(
    Region,
    {
        __call = function(cls, ...)
            return cls.new(...)
        end
    }
)

function Region.new(name, world, entrances, exits, locations)
    local self = {}
    setmetatable(self, Region)

    self.name = name or ""
    self.world = world or {}
    self.entrances = entrances or {}
    self.exits = exits or {}
    self.locations = locations or {}
    self.events = {}

    return self
end

function Region:get_locations()
    return self.locations
end

function Region:set_locations(new)
    if new == self.locations then
        return
    end
    self.locations = {}
    self.events = {}
    self.world.regions.location_cache = {}
    self:add_locations(new)
end

function Region:get_exits()
    return self.exits
end

function Region:set_exits(new)
    if new == self.exits then
        return
    end
    for _, exit in pairs(self.exits) do
        self.world.regions.entrance_cache[exit.name] = nil
    end
    self.exits = {}
    self:add_exits(new)
end

function Region:can_reach(state)
    if state.stale then
        state:update_reachable_regions()
    end
    return state.reachable_regions[self] or false
end

function Region:_add_location(location)
    if self.world.regions.location_cache[location.name] then
        print("Duplicate location name: " .. location.name)
    end
    table.insert(self.locations, location)
    self.world.regions.location_cache[location.name] = location
end

function Region:add_locations(locations, location_class)
    for _, location in pairs(locations) do
        self:_add_location(location_class(location, self))
    end
end

function Region:_add_event(event)
    table.insert(self.events, event)
    self.world.regions.location_cache[event.name] = event
end

function Region:add_event_locations(locations, location_class)
    for _, location in pairs(locations) do
        self:_add_event(location_class(location, self))
    end
end

function Region:connect(connecting_region, name, rule)
    local exit = self:create_exit(name or self.name .. " -> " .. connecting_region.name)
    if rule then
        exit.access_rule = rule
    end
    exit:connect(connecting_region)
    return exit
end

function Region:create_exit(name)
    local exit = Entrance(name, self)
    table.insert(self.exits, exit)
    self.world.regions.entrance_cache[exit.name] = exit
    return exit
end

function Region:create_er_target(name)
    local entrance = Entrance(name, self)
    entrance:connect(self)
    self.world.regions.entrance_cache[entrance.name] = entrance
    return entrance
end

function Region:add_exits(exits, rules)
    for connecting_region, exit_name in pairs(exits) do
        local rule = rules[connecting_region] or nil
        self:connect(connecting_region, exit_name, rule)
    end
end

return Region
