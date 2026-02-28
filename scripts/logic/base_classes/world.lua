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
    self.shop_prices = {}
    self.shop_vanilla_items = {}
    self.scrub_prices = {}
    self.merchant_prices = {}
    self.tricks_in_logic = {}
    self.complete_event_item_list = {}
    self.triforce_pieces_required = 0
    self.vanilla_progressive_skulltula_count = 0
    self.randomized_progressive_skulltula_count = 0
    self.apworld_version = 0
    self.ice_trap_filler_replacement = ""

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

function World:apply_slot_data(slot_data)
    self.shop_prices = slot_data["shop_prices"]
    self.shop_vanilla_items = slot_data["shop_vanilla_items"]
    self.scrub_prices = slot_data["scrub_prices"]
    self.merchant_prices = slot_data["merchant_prices"]
    self.triforce_pieces_required = slot_data["triforce_pieces_required"]
    self.vanilla_progressive_skulltula_count = slot_data["vanilla_progressive_skulltula_count"]
    self.randomized_progressive_skulltula_count = slot_data["randomized_progressive_skulltula_count"]
    self.tricks_in_logic = slot_data["tricks_in_logic"]
    for _, trick in pairs(self.tricks_in_logic) do
        local obj = Tracker:FindObjectForCode(trick)
        if obj ~= nil then
            obj.Active = true
        end
    end
end

function World:_compute_child_adult_only_regions(state)
    state.has_all_items = true
    state:_soh_invalidate()
    for name, location in pairs(self.regions.location_cache) do
        local c = location:can_reach(state, {Ages.CHILD})
        local a = location:can_reach(state, {Ages.ADULT})
        if c and not a then
            self.regions.child_only_locations[name] = true
        elseif a and not c then
            self.regions.adult_only_locations[name] = true
        end
    end
    state.has_all_items = false
    state:_soh_invalidate()
end

return World
