local RegionManager = require("scripts/logic/base_classes/region_manager")
local SoHLocation = require("scripts/logic/soh_location")

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
    self.archipelago_seed = 0
    self.apworld_version = 0
    self.vanilla_shop_item_to_location = {}
    self.required_trials = {}
    self.hintable_items = {}
    self.static_hints = {}
    self.free_dungeon_reward = nil

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

function World:is_token_type_vanilla(token_type)
    local token_option = self:get_option("shuffle_skull_tokens")
    if token_type == TokenTypes.OVERWORLD then
        return token_option == Options.TOKEN_SHUFFLE_OFF or token_option == Options.TOKEN_SHUFFLE_DUNGEON
    elseif token_type == TokenTypes.DUNGEON then
        return token_option == Options.TOKEN_SHUFFLE_OFF or token_option == Options.TOKEN_SHUFFLE_OVERWORLD
    end
end

local slot_data_to_vanilla_shop_item = {
    ["Buy Deku Shield"] = Items.DEKU_SHIELD,
    ["Buy Hylian Shield"] = Items.HYLIAN_SHIELD,
    ["Buy Goron Tunic"] = Items.GORON_TUNIC,
    ["Buy Zora Tunic"] = Items.ZORA_TUNIC,
    ["Buy Blue Potion"] = Items.BUY_BLUE_POTION,
    ["Buy Fish"] = Items.BUY_FISH,
    ["Buy Poe"] = Items.BUY_POE,
    ["Buy Bombchu (10)"] = Items.BUY_BOMBCHUS10,
    ["Buy Bombchu (20)"] = Items.BUY_BOMBCHUS20,
    ["Buy Green Potion"] = Items.BUY_GREEN_POTION,
    ["Buy Bottle Bug"] = Items.BUY_BOTTLE_BUG,
    ["Buy Fairy's Spirit"] = Items.BUY_FAIRYS_SPIRIT,
    ["Buy Blue Fire"] = Items.BUY_BLUE_FIRE
}

function World:_scan_altar_hint(key, dungeon_reward_order)
    --if the Altar hint tells us that the Link's pocket check has our own dungeon reward, return that as the free dungeon reward
    local links_pocket_location_ID = 1
    if not self.static_hints[key] then return end
    for index, hint in pairs(self.static_hints[key]) do
        local player_number, location = hint[1], hint[2]
        if player_number == Archipelago.PlayerNumber and location == links_pocket_location_ID then
            return dungeon_reward_order[index]
        end
    end
    return nil
end

function World:_scan_for_free_dungeon_reward()
    local child_altar_stone_order = { Items.KOKIRIS_EMERALD, Items.GORONS_RUBY, Items.ZORAS_SAPPHIRE }
    local adult_altar_stone_order = {Items.LIGHT_MEDALLION, Items.FOREST_MEDALLION, Items.FIRE_MEDALLION, Items.WATER_MEDALLION, Items.SHADOW_MEDALLION, Items.SPIRIT_MEDALLION}
    self.free_dungeon_reward = self:_scan_altar_hint("ToT Altar as Child", child_altar_stone_order)
    if self.free_dungeon_reward == nil then
        self.free_dungeon_reward = self:_scan_altar_hint("ToT Altar as Adult", adult_altar_stone_order)
    end
end

function World:on_item(item_code)
    if item_code == self.free_dungeon_reward then
        Tracker:FindObjectForCode(item_code).CurrentStage = 1
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
    self.required_trials = slot_data["required_trials"]
    self.hintable_items = slot_data["hintable_items"]
    self.static_hints = slot_data["static_hints"]
    self.archipelago_seed = slot_data["archipelago_seed"]

    for _, trick in pairs(self.tricks_in_logic) do
        local obj = Tracker:FindObjectForCode(trick)
        if obj ~= nil then
            obj.Active = true
            SOH_COLLECTION_STATE:on_item_changed(trick)
        end
    end
    self:_compute_child_adult_only_regions(SOH_COLLECTION_STATE)

    for location, item in pairs(self.shop_vanilla_items) do
        if slot_data_to_vanilla_shop_item[item] then
            item = slot_data_to_vanilla_shop_item[item]
            local loc = self:get_location(location)
            if loc then
                loc.parent_region:add_event(location, item, loc.access_rule, SoHLocation)
            end
        end
    end

    self:_scan_for_free_dungeon_reward()
end

function World:onClear()
    for _, trick in pairs(self.tricks_in_logic) do
        local obj = Tracker:FindObjectForCode(trick)
        if obj ~= nil then
            obj.Active = false
            SOH_COLLECTION_STATE:on_item_changed(trick)
        end
    end
    for location_name, item in pairs(self.shop_vanilla_items) do
        if slot_data_to_vanilla_shop_item[item] then
            item = slot_data_to_vanilla_shop_item[item]
            local location = self:get_location(location_name)
            if location then
                local region = location.parent_region
                location:remove_event_item()
                self.complete_event_item_list[item] = nil
                region.events[location_name] = nil
                if next(region.events) == nil then
                    self.regions.event_containing_regions[region.name] = nil
                end
            end
        end
    end
    self.free_dungeon_reward = nil
end

function World:_compute_child_adult_only_regions(state)
    self.regions.child_only_locations = {}
    self.regions.adult_only_locations = {}
    self.regions.child_only_sequence_break_locations = {}
    self.regions.adult_only_sequence_break_locations = {}
    state.has_all_items = true
    state:_soh_invalidate()
    for name, location in pairs(self.regions.location_cache) do
        local c = location:can_reach(state, { Ages.CHILD })
        local a = location:can_reach(state, { Ages.ADULT })
        if c == ACCESS_NORMAL and a < ACCESS_NORMAL then
            self.regions.child_only_locations[name] = true
        elseif a == ACCESS_NORMAL and c < ACCESS_NORMAL then
            self.regions.adult_only_locations[name] = true
        end
        if c > ACCESS_NONE and a == ACCESS_NONE then
            self.regions.child_only_sequence_break_locations[name] = true
        elseif a > ACCESS_NONE and c == ACCESS_NONE then
            self.regions.adult_only_sequence_break_locations[name] = true
        end
    end
    state.has_all_items = false
    state:_soh_invalidate()
end

return World
