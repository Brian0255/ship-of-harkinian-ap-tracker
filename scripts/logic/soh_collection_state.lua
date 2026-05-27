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
    [Items.GORON_TUNIC] = {slot_data_name = "Buy Goron Tunic", is_tunic_or_shield = true},
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

function SoHCollectionState:set_glitched_state(glitched)
    local value = glitched and 1 or 0
    self._current_item_count_cache = not glitched and self._in_logic_item_count_cache or self._glitched_item_count_cache
    self._current_item_count_cache[Items.GLITCHED] = value
    self.is_glitched = glitched
end

function SoHCollectionState.new(world)
    local self = {}
    setmetatable(self, SoHCollectionState)

    self.world = world

    self.has_all_items = false

    self._in_logic_item_count_cache = {}
    self._glitched_item_count_cache = {}

    self.is_glitched = false

    self._current_item_count_cache = self._in_logic_item_count_cache

    self._soh_stale = true
    self._soh_child_reachable_regions = {}
    self._soh_adult_reachable_regions = {}
    self._soh_child_blocked_regions = {}
    self._soh_adult_blocked_regions = {}
    self._soh_child_event_regions = {}
    self._soh_adult_event_regions = {}
    self._soh_age = Ages.NULL

    self._soh_age_region_tables = {}

    self.event_items = {}

    self.disable_invalidating = false

    self.event_based_item_mapping = {
        [Events.CAN_FARM_STICKS] = {
            option_function = function()
                return not self.world:get_option("shuffle_deku_stick_bag")
            end,
            item = Items.PROGRESSIVE_STICK_CAPACITY
        },
        [Events.CAN_FARM_NUTS] = {
            option_function = function()
                return not self.world:get_option("shuffle_deku_nut_bag")
            end,
            item = Items.PROGRESSIVE_NUT_CAPACITY
        },
        [Events.CAN_BUY_BEANS] = {
            option_function = function()
                return (self.world:get_option("shuffle_merchants") == Options.MERCHANTS_OFF or
                    self.world:get_option("shuffle_merchants") == Options.MERCHANTS_ALL_BUT_BEANS) and
                    (not self.world:get_option("start_with_magic_beans"))
            end,
            item = Items.MAGIC_BEAN_PACK
        }
    }

    self.token_types_unshuffled = {
        [TokenTypes.DUNGEON] = false,
        [TokenTypes.OVERWORLD] = false
    }
    self.vanilla_skulltulas_in_logic = 0
    self.vanilla_skulltulas_out_of_logic = 0

    self:_init_event_item_cache()

    return self
end

function SoHCollectionState:_init_event_item_cache()
    for event_item, _ in pairs(self.world.complete_event_item_list) do
        self._current_item_count_cache[event_item] = 0
    end
end

function SoHCollectionState:_clear_event_items()
    for event_item, _ in pairs(self.event_items) do
        self._in_logic_item_count_cache[event_item] = 0
        self._glitched_item_count_cache[event_item] = 0
    end
    self.event_items = {}
end

function SoHCollectionState:_soh_invalidate()
    if self.disable_invalidating then
        return
    end
    self._soh_child_reachable_regions = {}
    self._soh_adult_reachable_regions = {}
    self._soh_child_blocked_regions = {}
    self._soh_adult_blocked_regions = {}
    self._soh_child_event_regions = {}
    self._soh_adult_event_regions = {}
    self._soh_age_region_tables = {
        [Ages.CHILD] = {
            reachable = self._soh_child_reachable_regions,
            blocked = self._soh_child_blocked_regions,
            event_regions = self._soh_child_event_regions
        },
        [Ages.ADULT] = {
            reachable = self._soh_adult_reachable_regions,
            blocked = self._soh_adult_blocked_regions,
            event_regions = self._soh_adult_event_regions
        }
    }
    self:_clear_event_items()
    self.vanilla_skulltulas_in_logic = 0
    self.vanilla_skulltulas_out_of_logic = 0
    self._soh_stale = true
end

function SoHCollectionState:_collect_events(region)
    local total = 0
    for _, event in pairs(region.events) do
        if not self.event_items[event.event_item] then
            if event.access_rule(self) then
                total = total + 1
                self.event_items[event.event_item] = true
                self._current_item_count_cache[event.event_item] = 1
                if self.event_based_item_mapping[event.event_item] then
                    local entry = self.event_based_item_mapping[event.event_item]
                    if entry.option_function() then
                        self._current_item_count_cache[entry.item] = 1
                    end
                end
            end
        end
    end
    return total
end

local shields_tunics = {
    Items.DEKU_SHIELD,
    Items.HYLIAN_SHIELD,
    Items.GORON_TUNIC,
    Items.ZORA_TUNIC
}

function SoHCollectionState:_update_event_based_items(activate_linked_item)
    for event, data in pairs(self.event_based_item_mapping) do
        if data.option_function() then
            local event_on = self.event_items[event]
            self._current_item_count_cache[data.item] = event_on and 1 or 0
            if activate_linked_item then
                Tracker:FindObjectForCode(data.item).Active = event_on
            end
        end
    end
    for _, item in pairs(shields_tunics) do
        local can_buy = self.event_items[item] == true
        local current_stage = self._current_item_count_cache[item]
        local new_stage = current_stage
        if new_stage ~= 1 or can_buy then
            new_stage = can_buy and 2 or 0
        end
        self._current_item_count_cache[item] = new_stage
        if activate_linked_item then
            Tracker:FindObjectForCode(item).CurrentStage = new_stage
        end
    end
end

function SoHCollectionState:_run_BFS_pass(glitched)
    local collected_events = 0
    local shop_change = false

    for _, age in pairs({Ages.CHILD, Ages.ADULT}) do
        self._soh_age = age
        local age_region_tables = self._soh_age_region_tables[age]
        local reachable, blocked, event_regions =
            age_region_tables.reachable,
            age_region_tables.blocked,
            age_region_tables.event_regions

        local queue = Deque()
        for region, is_blocked in pairs(blocked) do
            if is_blocked then
                queue:append(region)
            end
        end

        -- init on first call for non-glitched pass
        if not glitched then
            local start = self.world:get_region(Regions.ROOT)
            if not reachable[start] then
                reachable[start] = ACCESS_NORMAL
                self:_collect_events(start)
                for _, exit in pairs(start.exits) do
                    blocked[exit] = true
                end
                queue:extend(start.exits)
            end
        end

        while not queue:is_empty() do
            local connection = queue:pop_front()
            local new_region = connection.connected_region
            if new_region ~= nil then
                if reachable[new_region] and reachable[new_region] > ACCESS_NONE then
                    blocked[connection] = nil
                elseif connection:can_reach(self) > ACCESS_NONE then
                    reachable[new_region] = glitched and ACCESS_SEQUENCEBREAK or ACCESS_NORMAL
                    blocked[connection] = nil
                    for _, exit in pairs(new_region.exits) do
                        blocked[exit] = true
                    end
                    if self.world.regions.event_containing_regions[new_region.name] then
                        event_regions[new_region.name] = new_region
                    end
                    queue:extend(new_region.exits)
                end
            end
        end

        for _, region in pairs(event_regions) do
            collected_events = collected_events + self:_collect_events(region)
        end
    end

    return collected_events, shop_change
end

function SoHCollectionState:_update_vanilla_skulltula_counts()
    self.token_types_unshuffled[TokenTypes.OVERWORLD] = self.world:is_token_type_vanilla(TokenTypes.OVERWORLD)
    self.token_types_unshuffled[TokenTypes.DUNGEON] = self.world:is_token_type_vanilla(TokenTypes.DUNGEON)
    for location_name, token_type in pairs(VanillaSkulltulaMapping) do
        local location = self.world:get_location(location_name)
        if self.token_types_unshuffled[token_type] and location then
            local access = location:can_reach(self, { Ages.CHILD, Ages.ADULT })
            if access == ACCESS_NORMAL then
                self.vanilla_skulltulas_in_logic = self.vanilla_skulltulas_in_logic + 1
            elseif access == ACCESS_SEQUENCEBREAK then
                self.vanilla_skulltulas_out_of_logic = self.vanilla_skulltulas_out_of_logic + 1
            end
        end
    end
end

function SoHCollectionState:_update_masks()
    local masks = Tracker:FindObjectForCode("child_masks")
    if masks == nil then
        return
    end
    local stage = 0
    if self.event_items[Events.CAN_BORROW_MASK_OF_TRUTH] then
        stage = 2
    elseif self.event_items[Events.CAN_BORROW_SKULL_MASK] then
        stage = 1
    end
    masks.CurrentStage = stage
end

function SoHCollectionState:_soh_update_age_reachable_regions()
    self:set_glitched_state(false)
    self._soh_stale = false
    self.disable_invalidating = true
    --clear out event/shop based items so the BFS can update them from a fresh state
    --otherwise the edge case where the linked item gets removed in the BFS loop is very bad
    self:_update_event_based_items()

    local collected_events = 0
    local shop_change = false
    repeat
        collected_events, shop_change = self:_run_BFS_pass(false)
    until collected_events == 0 and not shop_change

    self:_update_event_based_items(true)
    self:_update_masks()

    self._glitched_item_count_cache = {}
    for k, v in pairs(self._in_logic_item_count_cache) do
        self._glitched_item_count_cache[k] = v
    end

    self:set_glitched_state(true)

    repeat
        collected_events, shop_change = self:_run_BFS_pass(true)
    until collected_events == 0 and not shop_change

    self:set_glitched_state(false)
    self:_update_vanilla_skulltula_counts()

    self.disable_invalidating = false
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

local bool_to_count = {[true] = 1, [false] = 0}

function SoHCollectionState:on_item_changed(item, force_count)
    local obj = Tracker:FindObjectForCode(item)
    local count = 0
    if not obj then
        return 0
    end
    if obj.Type == "consumable" then
        count = obj.AcquiredCount
    elseif obj.Type == "progressive" then
        count = obj.CurrentStage
    elseif obj.Type == "progressive_toggle" then
        count = Tracker:ProviderCountForCode(item)
    elseif obj.Type == "toggle" then
        count = bool_to_count[obj.Active]
    elseif obj.Type == "static" then
        count = 1
    else
        count = bool_to_count[obj.Active]
    end
    self._current_item_count_cache[item] = force_count or count
end

local has_all_items_override = {}
for k, _ in pairs(TrickCodeToTrick) do
    has_all_items_override[k] = true
end
has_all_items_override[Items.GLITCHED] = true

function SoHCollectionState:count(item)
    if self.has_all_items and not has_all_items_override[item] then
        return 200
    end
    if self._current_item_count_cache[item] == nil then
        self:on_item_changed(item)
    end
    return self._current_item_count_cache[item] or 0
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

--just a note, this does not work with has_all_items for child/adult only calcs
--not used in the code base anywhere, but something to keep in mind
function SoHCollectionState:count_group(item_name_group)
    local total_count = 0
    for _, item in pairs(item_name_group) do
        total_count = total_count + self:count(item)
    end
    return total_count
end

function SoHCollectionState:count_group_unique(item_name_group)
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
