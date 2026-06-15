local RegionManager = require("scripts/logic/base_classes/region_manager")

local World = {}
World.__index = World

setmetatable(
    World,
    {
        __call = function(cls, ...)
            return cls.new(...)
        end
    }
)

function World.new()
    local self = {}
    setmetatable(self, World)

    self.regions = RegionManager()
    self.complete_event_item_list = {}
    self.archipelago_seed = 0
    self.apworld_version = 0

    return self
end

function World:get_regions()
    return self.regions.region_cache
end

function World:get_region(region_name)
    return self.regions.region_cache[region_name]
end

function World:get_entrances()
    return self.regions.entrance_cache
end

function World:get_entrance(entrance_name)
    return self.regions.entrance_cache[entrance_name]
end

function World:get_locations()
    return self.regions.location_cache
end

function World:get_location(location_name)
    return self.regions.location_cache[location_name]
end

function World:get_option(option_key)
    local obj = Tracker:FindObjectForCode("setting_" .. option_key)
    if not obj then
        print(string.format("Tried to resolve option with invalid option key: %s", option_key))
        return
    end
    if obj.Type == "toggle" then
        return obj.Active
    elseif obj.Type == "consumable" then
        return obj.AcquiredCount
    elseif obj.Type == "progressive" then
        return obj.CurrentStage
    end
end

function World:on_item(item_code)
end

function World:apply_slot_data(slot_data)
end

function World:onClear()
end

return World
