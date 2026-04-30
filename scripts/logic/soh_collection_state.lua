local SoHCollectionState = {}
SoHCollectionState.__index = SoHCollectionState

local Deque = require("scripts/logic/base_classes/deque")

setmetatable(
    SoHCollectionState,
    {
        __call = function(cls, ...)
            return cls.new(...)
        end
    }
)

local progressive_item_map = {
    [Items.BRONZE_SCALE] = {item = Items.PROGRESSIVE_SCALE, count = 1},
    [Items.SILVER_SCALE] = {item = Items.PROGRESSIVE_SCALE, count = 2},
    [Items.GOLDEN_SCALE] = {item = Items.PROGRESSIVE_SCALE, count = 3},
    [Items.FAIRY_OCARINA] = {item = Items.PROGRESSIVE_OCARINA, count = 1},
    [Items.OCARINA_OF_TIME] = {item = Items.PROGRESSIVE_OCARINA, count = 2},
    [Items.GORONS_BRACELET] = {item = Items.STRENGTH_UPGRADE, count = 1},
    [Items.SILVER_GAUNTLETS] = {item = Items.STRENGTH_UPGRADE, count = 2},
    [Items.GOLDEN_GAUNTLETS] = {item = Items.STRENGTH_UPGRADE, count = 3},
    [Items.HOOKSHOT] = {item = Items.PROGRESSIVE_HOOKSHOT, count = 1},
    [Items.LONGSHOT] = {item = Items.PROGRESSIVE_HOOKSHOT, count = 2},
    [Items.CHILD_WALLET] = {item = Items.PROGRESSIVE_WALLET, count = 1},
    [Items.ADULT_WALLET] = {item = Items.PROGRESSIVE_WALLET, count = 2},
    [Items.GIANT_WALLET] = {item = Items.PROGRESSIVE_WALLET, count = 3},
    [Items.TYCOON_WALLET] = {item = Items.PROGRESSIVE_WALLET, count = 4},
    [Items.FAIRY_SLINGSHOT] = {item = Items.PROGRESSIVE_SLINGSHOT, count = 1},
    [Items.FAIRY_BOW] = {item = Items.PROGRESSIVE_BOW, count = 1},
    [Items.BOMB_BAG] = {item = Items.PROGRESSIVE_BOMB_BAG, count = 1},
    [Items.DEKU_STICK_BAG] = {item = Items.PROGRESSIVE_STICK_CAPACITY, count = 1},
    [Items.DEKU_NUT_BAG] = {item = Items.PROGRESSIVE_NUT_CAPACITY, count = 1},
    [Items.WEIRD_EGG] = {item = Items.WEIRD_EGG, count = 1},
    [Items.ZELDAS_LETTER] = {item = Items.WEIRD_EGG, count = 2},
    [Items.MAGIC_SINGLE] = {item = Items.PROGRESSIVE_MAGIC_METER, count = 1},
    [Items.MAGIC_DOUBLE] = {item = Items.PROGRESSIVE_MAGIC_METER, count = 2}
}

local vanilla_shop_items = {
    [Items.DEKU_SHIELD] = {slot_data_name = "Buy Deku Shield", is_tunic_or_shield = true},
    [Items.HYLIAN_SHIELD] = {slot_data_name = "Buy Hylian Shield", is_tunic_or_shield = true},
    ["goron_tunic_composite"] = {slot_data_name = "Buy Goron Tunic", is_tunic_or_shield = true},
    [Items.ZORA_TUNIC] = {slot_data_name = "Buy Zora Tunic", is_tunic_or_shield = true},
    [Items.BUY_BLUE_POTION] = {slot_data_name = "Buy Blue Potion"},
    [Items.BUY_FISH] = {slot_data_name = "Buy Fish"},
    [Items.BUY_POE] = {slot_data_name = "Buy Poe"},
    [Items.BUY_BOMBCHUS10] = {slot_data_name = "Buy Bombchu (10)"},
    [Items.BUY_BOMBCHUS20] = {slot_data_name = "Buy Bombchu (20)"},
    [Items.BUY_GREEN_POTION] = {slot_data_name = "Buy Green Potion"},
    [Items.BUY_BOTTLE_BUG] = {slot_data_name = "Buy Bottle Bug"},
    [Items.BUY_FAIRYS_SPIRIT] = {slot_data_name = "Buy Fairy's Spirit"},
    [Items.BUY_BLUE_FIRE] = {slot_data_name = "Buy Blue Fire"}
}

function SoHCollectionState.new(world)
    local self = {}
    setmetatable(self, SoHCollectionState)

    self.world = world

    self.has_all_items = false

    self._soh_stale = true
    self._soh_child_reachable_regions = {}
    self._soh_adult_reachable_regions = {}
    self._soh_child_blocked_regions = {}
    self._soh_adult_blocked_regions = {}
    self._soh_age = Ages.NULL

    self.event_items = {}

    self.disable_invalidating = false

    return self
end

function SoHCollectionState:_soh_invalidate()
    if self.disable_invalidating then
        return
    end
    self._soh_child_reachable_regions = {}
    self._soh_adult_reachable_regions = {}
    self._soh_child_blocked_regions = {}
    self._soh_adult_blocked_regions = {}
    self._soh_stale = true
    self.event_items = {}
end

function SoHCollectionState:_collect_events(region)
    local total = 0
    for _, event in pairs(region.events) do
        if not self.event_items[event.event_item] then
            if event.access_rule(self) then
                total = total + 1
                self.event_items[event.event_item] = true
            end
        end
    end
    return total
end

function SoHCollectionState:_handle_vanilla_shop_items()
    --disable_invalidating is for the bad loop here:
    --you get a deku shield from this, which triggers the watch before the loop finishes, which invalidates the region graph
    --then the loop continues, location.can_reach is called again, the region graph rebuilds
    --since there is no pause here we can easily hit the instruction limit if we don't stop the loop with this
    self.disable_invalidating = true
    local change = false
    for item_name, data in pairs(vanilla_shop_items) do
        local slot_data_name = data.slot_data_name
        local possible_locations = self.world.vanilla_shop_item_to_location[slot_data_name] or {}
        local active = false
        for _, location_name in pairs(possible_locations) do
            local location = self.world:get_location(location_name)
            if location and location:can_reach(self) then
                active = true
                break
            end
        end
        local obj = Tracker:FindObjectForCode(item_name)
        if obj ~= nil then
            if data.is_tunic_or_shield then
                --some messy looking jank here to make it so tunics still respond to left click toggling when being shop tracked
                if obj.CurrentStage == 0 or obj.CurrentStage == 3 then
                    local stage = active and 3 or 0
                    if obj.CurrentStage ~= stage then
                        obj.CurrentStage = stage
                        change = true
                    end
                end
            else
                if active ~= obj.Active then
                    obj.Active = active
                    change = true
                end
            end
        end
    end
    self.disable_invalidating = false
    if change then
        self:_soh_invalidate()
    end
end

function SoHCollectionState:_handle_event_based_items()
    local mapping = {
        {
            option_function = function()
                return not self.world:get_option("shuffle_deku_stick_bag")
            end,
            event = Events.CAN_FARM_STICKS,
            item = Items.PROGRESSIVE_STICK_CAPACITY
        },
        {
            option_function = function()
                return not self.world:get_option("shuffle_deku_nut_bag")
            end,
            event = Events.CAN_FARM_NUTS,
            item = Items.PROGRESSIVE_NUT_CAPACITY
        },
        {
            option_function = function()
                return self.world:get_option("shuffle_merchants") == Options.MERCHANTS_OFF or
                    self.world:get_option("shuffle_merchants") == Options.MERCHANTS_ALL_BUT_BEANS
            end,
            event = Events.CAN_BUY_BEANS,
            item = Items.MAGIC_BEAN_PACK
        }
    }
    for _, entry in pairs(mapping) do
        if entry.option_function() and self.event_items[entry.event] then
            Tracker:FindObjectForCode(entry.item).Active = self.event_items[entry.event]
        end
    end
end

function SoHCollectionState:_soh_update_age_reachable_regions()
    self._soh_stale = false
    local collected_events = 0
    repeat
        collected_events = 0
        LogicHelpers.clear_cache()
        for _, age in pairs({Ages.CHILD, Ages.ADULT}) do
            self._soh_age = age
            local start = self.world:get_region(Regions.ROOT)
            local reachable, blocked
            if age == Ages.CHILD then
                reachable = self._soh_child_reachable_regions
                blocked = self._soh_child_blocked_regions
            else
                reachable = self._soh_adult_reachable_regions
                blocked = self._soh_adult_blocked_regions
            end

            local queue = Deque()
            for region, is_blocked in pairs(blocked) do
                if is_blocked then
                    queue:append(region)
                end
            end
            --init on first call
            if not reachable[start] then
                reachable[start] = true
                self:_collect_events(start)
                for _, exit in pairs(start.exits) do
                    blocked[exit] = true
                end
                queue:extend(start.exits)
            end

            while not queue:is_empty() do
                local connection = queue:pop_front()
                local new_region = connection.connected_region
                if new_region ~= nil then
                    if reachable[new_region] then
                        blocked[connection] = nil
                    elseif connection:can_reach(self) then
                        reachable[new_region] = true
                        blocked[connection] = nil
                        for _, exit in pairs(new_region.exits) do
                            blocked[exit] = true
                        end
                        queue:extend(new_region.exits)
                    end
                end
            end

            for region, _ in pairs(reachable) do
                collected_events = collected_events + self:_collect_events(region)
            end
        end
    until collected_events == 0
    self:_handle_event_based_items()
    self:_handle_vanilla_shop_items()
end

function SoHCollectionState:_soh_can_reach_as_age(region, age)
    if self._soh_age == Ages.NULL then
        self._soh_age = age
        local can_reach = self.world:get_region(region.name):can_reach(self)
        self._soh_age = Ages.NULL
        return can_reach
    end
    return (self._soh_age == age)
end

function SoHCollectionState:count(item)
    if self.has_all_items then
        return 200
    end
    local bool_to_count = {[true] = 1, [false] = 0}
    if self.world.complete_event_item_list[item] then
        return bool_to_count[self.event_items[item]] or 0
    end
    local obj = Tracker:FindObjectForCode(item)
    if not obj then
        return 0
    end
    if obj.Type == "consumable" then
        return obj.AcquiredCount
    elseif obj.Type == "progressive" then
        return obj.CurrentStage
    elseif obj.Type == "progressive_toggle" then
        return Tracker:ProviderCountForCode(item)
    elseif obj.Type == "toggle" then
        return bool_to_count[obj.Active]
    elseif obj.Type == "static" then
        return 1
    else
        return bool_to_count[obj.Active]
    end
end

function SoHCollectionState:has_all(items)
    for _, item in pairs(items) do
        if not self:has(item) then
            return false
        end
    end
    return true
end

function SoHCollectionState:has_any(items)
    for _, item in pairs(items) do
        if self:has(item) then
            return true
        end
    end
    return false
end

function SoHCollectionState:has(item, amount)
    amount = amount or 1
    if progressive_item_map[item] then
        amount = progressive_item_map[item].count
        item = progressive_item_map[item].item
    end
    return self:count(item) >= amount
end

function SoHCollectionState:count_group(item_name_group)
    local total_count = 0
    for _, item in pairs(item_name_group) do
        total_count = total_count + self:count(item)
    end
    return total_count
end

function SoHCollectionState:count_group_unique(item_name_group)
    if self.has_all_items then
        return 200
    end
    local total_count = 0
    for _, item in pairs(item_name_group) do
        local count = self:count(item)
        if count > 0 then
            total_count = total_count + 1
        end
    end
    return total_count
end

function SoHCollectionState:get_heart_count()
    if self.has_all_items then
        return 200
    end
    local count = self.world:get_option("starting_hearts") + self:count(Items.HEART_CONTAINER)
    local pieces = self:count(Items.PIECE_OF_HEART) + self:count(Items.PIECE_OF_HEART_WINNER)
    return count + (pieces // 4)
end

return SoHCollectionState
