ACCESS_NONE = AccessibilityLevel.None
ACCESS_PARTIAL = AccessibilityLevel.Partial
ACCESS_INSPECT = AccessibilityLevel.Inspect
ACCESS_SEQUENCEBREAK = AccessibilityLevel.SequenceBreak
ACCESS_NORMAL = AccessibilityLevel.Normal
ACCESS_CLEARED = AccessibilityLevel.Cleared

local SoHLocation = require("scripts/logic/soh_location")
require("scripts/logic/item_data")

LogicHelpers = {}

local rule_wrapper = {}
rule_wrapper.__index = rule_wrapper

setmetatable(
    rule_wrapper,
    {
        __call = function(cls, ...)
            return cls.new(...)
        end
    }
)

function rule_wrapper.new(parent_region, rule, world)
    local self = {}
    setmetatable(self, rule_wrapper)

    self.parent_region = parent_region
    self.rule = rule
    self.world = world

    return self
end

function rule_wrapper.wrap(parent_region, rule, world)
    local wrapper = rule_wrapper(parent_region, rule, world)
    return function(state)
        return wrapper:evaluate(state)
    end
end

function rule_wrapper:evaluate(state)
    return self.rule({state, self.parent_region, self.world})
end

local bombchu_sources = {
    [Items.BOMBCHU_BAG] = true,
    [Items.BOMBCHUS_5] = true,
    [Items.BOMBCHUS_10] = true,
    [Items.BOMBCHUS_20] = true
}

local adult_trade_items = {
    [Items.POCKET_EGG] = true,
    [Items.COJIRO] = true,
    [Items.ODD_MUSHROOM] = true,
    [Items.ODD_POTION] = true,
    [Items.POACHERS_SAW] = true,
    [Items.BROKEN_GORONS_SWORD] = true,
    [Items.PRESCRIPTION] = true,
    [Items.EYEBALL_FROG] = true,
    [Items.WORLDS_FINEST_EYEDROPS] = true
}

local no_rules_bottles = {
    [Items.EMPTY_BOTTLE] = true,
    [Items.BOTTLE_WITH_MILK] = true,
    [Items.BOTTLE_WITH_RED_POTION] = true,
    [Items.BOTTLE_WITH_GREEN_POTION] = true,
    [Items.BOTTLE_WITH_BLUE_POTION] = true,
    [Items.BOTTLE_WITH_FAIRY] = true,
    [Items.BOTTLE_WITH_FISH] = true,
    [Items.BOTTLE_WITH_BLUE_FIRE] = true,
    [Items.BOTTLE_WITH_BUGS] = true
}

local other_bottles = {
    [Items.BOTTLE_WITH_MILK] = true,
    [Items.BOTTLE_WITH_POE] = true,
    [Items.BOTTLE_WITH_RED_POTION] = true,
    [Items.EMPTY_BOTTLE] = true
}

local wallet_capacities = {
    {item = Items.CHILD_WALLET, capacity = 99},
    {item = Items.ADULT_WALLET, capacity = 200},
    {item = Items.GIANT_WALLET, capacity = 500},
    {item = Items.TYCOON_WALLET, capacity = 999}
}

local ocarina_buttons_required = {
    [Items.ZELDAS_LULLABY] = {
        Items.OCARINA_CLEFT_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CUP_BUTTON
    },
    [Items.EPONAS_SONG] = {
        Items.OCARINA_CLEFT_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CUP_BUTTON
    },
    [Items.PRELUDE_OF_LIGHT] = {
        Items.OCARINA_CLEFT_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CUP_BUTTON
    },
    [Items.SARIAS_SONG] = {
        Items.OCARINA_CLEFT_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    },
    [Items.SUNS_SONG] = {
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CUP_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    },
    [Items.SONG_OF_TIME] = {
        Items.OCARINA_A_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    },
    [Items.BOLERO_OF_FIRE] = {
        Items.OCARINA_A_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    },
    [Items.REQUIEM_OF_SPIRIT] = {
        Items.OCARINA_A_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    },
    [Items.SONG_OF_STORMS] = {
        Items.OCARINA_A_BUTTON,
        Items.OCARINA_CUP_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    },
    [Items.MINUET_OF_FOREST] = {
        Items.OCARINA_A_BUTTON,
        Items.OCARINA_CLEFT_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CUP_BUTTON
    },
    [Items.SERENADE_OF_WATER] = {
        Items.OCARINA_A_BUTTON,
        Items.OCARINA_CLEFT_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    },
    [Items.NOCTURNE_OF_SHADOW] = {
        Items.OCARINA_A_BUTTON,
        Items.OCARINA_CLEFT_BUTTON,
        Items.OCARINA_CRIGHT_BUTTON,
        Items.OCARINA_CDOWN_BUTTON
    }
}

--lookup table for some of the can_kill_enemy logic
local enemies = {
    guards = {[Enemies.GERUDO_GUARD] = true, [Enemies.BREAK_ROOM_GUARD] = true},
    small = {[Enemies.GOHMA_LARVA] = true, [Enemies.MAD_SCRUB] = true, [Enemies.DEKU_BABA] = true},
    keese = {[Enemies.KEESE] = true, [Enemies.FIRE_KEESE] = true},
    wolves_and_walls = {[Enemies.WOLFOS] = true, [Enemies.WHITE_WOLFOS] = true, [Enemies.WALLMASTER] = true},
    undead = {[Enemies.GIBDO] = true, [Enemies.REDEAD] = true},
    like_like_and_floor = {[Enemies.LIKE_LIKE] = true, [Enemies.FLOORMASTER] = true},
    knuckle_octo = {[Enemies.IRON_KNUCKLE] = true, [Enemies.BIG_OCTO] = true}
}

local passable_enemies_for_free = {
    [Enemies.GOLD_SKULLTULA] = true,
    [Enemies.GOHMA_LARVA] = true,
    [Enemies.LIZALFOS] = true,
    [Enemies.DODONGO] = true,
    [Enemies.MAD_SCRUB] = true,
    [Enemies.KEESE] = true,
    [Enemies.FIRE_KEESE] = true,
    [Enemies.BLUE_BUBBLE] = true,
    [Enemies.DEAD_HAND] = true,
    [Enemies.DEKU_BABA] = true,
    [Enemies.WITHERED_DEKU_BABA] = true,
    [Enemies.STALFOS] = true,
    [Enemies.FLARE_DANCER] = true,
    [Enemies.WOLFOS] = true,
    [Enemies.WHITE_WOLFOS] = true,
    [Enemies.FLOORMASTER] = true,
    [Enemies.MEG] = true,
    [Enemies.ARMOS] = true,
    [Enemies.FREEZARD] = true,
    [Enemies.SPIKE] = true,
    [Enemies.DARK_LINK] = true,
    [Enemies.ANUBIS] = true,
    [Enemies.WALLMASTER] = true,
    [Enemies.PURPLE_LEEVER] = true,
    [Enemies.OCTOROK] = true
}

local key_to_ring = {
    [Items.FOREST_TEMPLE_SMALL_KEY] = Items.FOREST_TEMPLE_KEY_RING,
    [Items.FIRE_TEMPLE_SMALL_KEY] = Items.FIRE_TEMPLE_KEY_RING,
    [Items.WATER_TEMPLE_SMALL_KEY] = Items.WATER_TEMPLE_KEY_RING,
    [Items.BOTTOM_OF_THE_WELL_SMALL_KEY] = Items.BOTTOM_OF_THE_WELL_KEY_RING,
    [Items.SHADOW_TEMPLE_SMALL_KEY] = Items.SHADOW_TEMPLE_KEY_RING,
    [Items.GERUDO_FORTRESS_SMALL_KEY] = Items.GERUDO_FORTRESS_KEY_RING,
    [Items.TRAINING_GROUND_SMALL_KEY] = Items.TRAINING_GROUND_KEY_RING,
    [Items.SPIRIT_TEMPLE_SMALL_KEY] = Items.SPIRIT_TEMPLE_KEY_RING,
    [Items.GANONS_CASTLE_SMALL_KEY] = Items.GANONS_CASTLE_KEY_RING
}

local dungeon_events = {
    Events.DEKU_TREE_COMPLETED,
    Events.DODONGOS_CAVERN_COMPLETED,
    Events.JABU_JABUS_BELLY_COMPLETED,
    Events.FOREST_TEMPLE_COMPLETED,
    Events.FIRE_TEMPLE_COMPLETED,
    Events.WATER_TEMPLE_COMPLETED,
    Events.SPIRIT_TEMPLE_COMPLETED,
    Events.SHADOW_TEMPLE_COMPLETED
}

function LogicHelpers.add_locations(parent_region, world, locations)
    for _, location in pairs(locations) do
        local locationName = location[1]
        local locationRule = location[2] or function(bundle)
                return true
            end
        world:get_region(parent_region):add_locations({locationName}, SoHLocation)
        world:get_location(locationName).access_rule = rule_wrapper.wrap(parent_region, locationRule, world)
    end
end

function LogicHelpers.connect_regions(parent_region, world, child_regions)
    for _, region in pairs(child_regions) do
        local regionName = region[1]
        local regionRule = region[2] or function(bundle)
                return true
            end
        local wrapped_rule = rule_wrapper.wrap(parent_region, regionRule, world)
        world:get_region(parent_region):connect(world:get_region(regionName), nil, wrapped_rule)
    end
end

function LogicHelpers.add_events(parent_region, world, events)
    for _, event in pairs(events) do
        local event_location = event[1]
        local event_item = event[2]
        local event_rule = event[3] or function(bundle)
                return true
            end
        world:get_region(parent_region):add_event_locations({event_location}, SoHLocation)
        world:get_location(event_location).access_rule = rule_wrapper.wrap(parent_region, event_rule, world)
        world:get_location(event_location):set_event_item(event_item)
        world.complete_event_item_list[event_item] = true
    end
end

function LogicHelpers.can_use(item, bundle)
    if not LogicHelpers.has_item(item, bundle) then
        return false
    end

    local data = ItemData.item_data_table
    if data[item] then
        if data[item].adult_only and not LogicHelpers.is_adult(bundle) then
            return false
        end

        if data[item].child_only and not LogicHelpers.is_child(bundle) then
            return false
        end

        if data[item].item_type == ItemType.MAGIC and not LogicHelpers.has_item(Items.PROGRESSIVE_MAGIC_METER, bundle) then
            return false
        end

        if data[item].item_type == ItemType.SONG then
            return LogicHelpers.can_play_song(item, bundle)
        end
    end

    local arrow_types = {[Items.FIRE_ARROW] = true, [Items.ICE_ARROW] = true, [Items.LIGHT_ARROW] = true}

    if arrow_types[item] then
        return LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
    end

    if bombchu_sources[item] then
        return LogicHelpers.bombchu_refill(bundle)
    end

    if item == Items.FISHING_POLE then
        return LogicHelpers.has_item(Items.CHILD_WALLET, bundle)
    end

    if item == Items.EPONA then
        return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.EPONAS_SONG, bundle)
    end

    return true
end

function LogicHelpers.can_use_any(names, bundle)
    for _, name in pairs(names) do
        if LogicHelpers.can_use(name, bundle) then
            return true
        end
    end
    return false
end

function LogicHelpers.has_item(item, bundle, count)
    count = count or 1
    local state = bundle[1]
    local world = bundle[3]

    if item == Items.STICKS then
        return state:has_all({Events.CAN_FARM_STICKS, Items.DEKU_STICK_BAG})
    end

    if bombchu_sources[item] then
        return LogicHelpers.bombchus_enabled(bundle)
    end

    if item == Items.NUTS then
        return state:has_all({Events.CAN_FARM_NUTS, Items.DEKU_NUT_BAG})
    end

    --AP checks for Can Buy Beans event but I think it's less confusing from a tracker POV to omit that
    if item == Items.MAGIC_BEAN then
        return state:has_any({Items.MAGIC_BEAN_PACK})
    end

    if item == Items.DEKU_SHIELD then
        --normally checks Items.CAN_BUY_DEKU_SHIELD but for a tracker it makes more sense to just directly check the shield
        return state:has(Items.DEKU_SHIELD)
    end

    if item == Items.HYLIAN_SHIELD then
        --same as deku shield
        return state:has(Items.HYLIAN_SHIELD)
    end

    if item == Items.GORON_TUNIC then
        return state:has_any({Items.BUY_GORON_TUNIC, Items.GORON_TUNIC})
    end

    if item == Items.ZORA_TUNIC then
        return state:has_any({Items.BUY_ZORA_TUNIC, Items.ZORA_TUNIC})
    end

    if item == Items.SCARECROW then
        return LogicHelpers.scarecrows_song(bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle)
    end

    if item == Items.DISTANT_SCARECROW then
        return LogicHelpers.scarecrows_song(bundle) and LogicHelpers.can_use(Items.LONGSHOT, bundle)
    end

    if item == Items.FISHING_POLE then
        return (not world:get_option("shuffle_fishing_pole") or state:has(Items.FISHING_POLE))
    end

    if item == Items.EPONA then
        return state:has(Events.FREED_EPONA)
    end

    if adult_trade_items[item] then
        return not world:get_option("shuffle_adult_trade_items") or state:has(item)
    end

    if item == Items.BOTTLE_WITH_BLUE_FIRE then
        return LogicHelpers.has_bottle(bundle) and (state:has(Events.CAN_ACCESS_BLUE_FIRE) or state:has(Items.BUY_BLUE_FIRE))
    end

    if item == Items.BOTTLE_WITH_BLUE_POTION then
        return LogicHelpers.has_bottle(bundle) and state:has(Items.BUY_BLUE_POTION)
    end

    if item == Items.BOTTLE_WITH_BUGS then
        return LogicHelpers.has_bottle(bundle) and (state:has(Events.CAN_ACCESS_BUGS) or state:has(Items.BUY_BOTTLE_BUG))
    end

    if item == Items.BOTTLE_WITH_FAIRY then
        return LogicHelpers.has_bottle(bundle) and
            (state:has(Events.CAN_ACCESS_FAIRIES) or state:has(Items.BUY_FAIRYS_SPIRIT))
    end

    if item == Items.BOTTLE_WITH_FISH then
        return LogicHelpers.has_bottle(bundle) and (state:has(Events.CAN_ACCESS_FISH) or state:has(Items.BUY_FISH))
    end

    if item == Items.BOTTLE_WITH_GREEN_POTION then
        return LogicHelpers.has_bottle(bundle) and state:has(Items.BUY_GREEN_POTION)
    end

    if other_bottles[item] then
        return LogicHelpers.has_bottle(bundle)
    end

    return state:has(item, count)
end

function LogicHelpers.merchant_shuffled(location_name, bundle)
    local world = bundle[3]
    local option = world:get_option("shuffle_merchants")
    if option == Options.MERCHANTS_ALL then
        return true
    end
    if location_name == Locations.ZR_MAGIC_BEAN_SALESMAN then
        return option == Options.MERCHANTS_BEAN_MERCHANT_ONLY
    else
        return option == Options.MERCHANTS_ALL_BUT_BEANS
    end
end

function LogicHelpers.can_afford_item(item_group, item, bundle)
    if bundle[3][item_group] == nil then
        return false
    end
    local price = bundle[3][item_group][item]
    price = price or 0
    return LogicHelpers.can_afford_price(price, bundle)
end

function LogicHelpers.can_afford_price(price, bundle)
    for _, wallet_info in pairs(wallet_capacities) do
        if wallet_info.capacity >= price then
            return LogicHelpers.has_item(wallet_info.item, bundle)
        end
    end
    return false
end

function LogicHelpers.scarecrows_song(bundle)
    local state = bundle[1]
    local world = bundle[3]
    local scarecrow_skipped_and_song_playable =
        world:get_option("skip_scarecrows_song") and LogicHelpers.has_item(Items.FAIRY_OCARINA, bundle) and
        LogicHelpers.ocarina_button_count(bundle) >= 2
    local not_skipped_but_unlocked =
        LogicHelpers.has_item(Events.CHILD_SCARECROW_UNLOCKED, bundle) and
        LogicHelpers.has_item(Events.ADULT_SCARECROW_UNLOCKED, bundle)
    return scarecrow_skipped_and_song_playable or not_skipped_but_unlocked
end

function LogicHelpers.has_bottle(bundle)
    return LogicHelpers.has_bottle_count(bundle, 1)
end

function LogicHelpers.has_bottle_count(bundle, target_count)
    local state = bundle[1]
    local count = 0
    for bottle, _ in pairs(no_rules_bottles) do
        count = count + state:count(bottle)
        if count >= target_count then
            return true
        end
    end
    if state:has(Events.DELIVER_LETTER) then
        count = count + state:count(Items.BOTTLE_WITH_RUTOS_LETTER)
        if count >= target_count then
            return true
        end
    end
    if state:has(Events.CAN_EMPTY_BIG_POES) then
        count = count + state:count(Items.BOTTLE_WITH_BIG_POE)
        if count >= target_count then
            return true
        end
    end
    return false
end

function LogicHelpers.bombchu_refill(bundle)
    local state = bundle[1]
    local world = bundle[3]
    return state:has_any({Items.BUY_BOMBCHUS10, Items.BUY_BOMBCHUS20, Events.COULD_PLAY_BOWLING, Events.CARPET_MERCHANT}) or
        world:get_option("bombchu_drops")
end

function LogicHelpers.bombchus_enabled(bundle)
    local state = bundle[1]
    local world = bundle[3]
    if world:get_option("bombchu_bag") ~= Options.BOMBCHU_BAG_NONE then
        return state:has(Items.BOMBCHU_BAG)
    end
    return state:has(Items.BOMB_BAG)
end

function LogicHelpers.can_play_song(song, bundle)
    local state = bundle[1]
    local world = bundle[3]
    if not (LogicHelpers.has_item(Items.FAIRY_OCARINA, bundle) and LogicHelpers.has_item(song, bundle)) then
        return false
    end
    if not world:get_option("shuffle_ocarina_buttons") then
        return true
    else
        return state:has_all(ocarina_buttons_required[song])
    end
end

function LogicHelpers.has_explosives(bundle)
    return LogicHelpers.can_use_any({Items.BOMB_BAG, Items.BOMBCHU_BAG}, bundle)
end

function LogicHelpers.blast_or_smash(bundle)
    return LogicHelpers.has_explosives(bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
end

function LogicHelpers.blue_fire(bundle)
    local world = bundle[3]
    local blue_fire_bottle =
        LogicHelpers.has_bottle(bundle) and
        (LogicHelpers.has_item(Events.CAN_ACCESS_BLUE_FIRE, bundle) or LogicHelpers.has_item(Items.BUY_BLUE_FIRE, bundle))
    local ice_arrows = LogicHelpers.can_use(Items.ICE_ARROW, bundle) and world:get_option("blue_fire_arrows")
    return blue_fire_bottle or ice_arrows
end

function LogicHelpers.can_use_sword(bundle)
    return LogicHelpers.can_use_any({Items.KOKIRI_SWORD, Items.MASTER_SWORD, Items.BIGGORONS_SWORD}, bundle)
end

function LogicHelpers.has_projectile(bundle, age)
    if LogicHelpers.has_explosives(bundle) then
        return true
    end

    age = age or Ages.NULL
    if age == Ages.CHILD then
        return LogicHelpers.can_use_any({Items.FAIRY_SLINGSHOT, Items.BOOMERANG}, bundle)
    elseif age == Ages.ADULT then
        return LogicHelpers.can_use_any({Items.HOOKSHOT, Items.FAIRY_BOW}, bundle)
    else
        return LogicHelpers.can_use_any({Items.FAIRY_SLINGSHOT, Items.BOOMERANG, Items.HOOKSHOT, Items.FAIRY_BOW}, bundle)
    end
end

function LogicHelpers.can_use_projectile(bundle)
    return LogicHelpers.has_projectile(bundle)
end

function LogicHelpers.can_break_mud_walls(bundle)
    return LogicHelpers.blast_or_smash(bundle) or
        (LogicHelpers.can_do_trick(Tricks.BLUE_FIRE_MUD_WALLS, bundle) and LogicHelpers.blue_fire(bundle))
end

function LogicHelpers.can_get_deku_baba_sticks(bundle)
    return LogicHelpers.can_use_sword(bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)
end

function LogicHelpers.can_get_deku_baba_nuts(bundle)
    return LogicHelpers.can_use_any({Items.FAIRY_SLINGSHOT, Items.FAIRY_BOW, Items.DINS_FIRE}, bundle) or
        LogicHelpers.can_jump_slash(bundle) or
        LogicHelpers.has_explosives(bundle)
end

function LogicHelpers.is_adult(bundle)
    local state = bundle[1]
    local parent_region = bundle[2]
    return state:_soh_can_reach_as_age(parent_region, Ages.ADULT)
end

function LogicHelpers.at_day(bundle)
    return (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Events.CHILD_CAN_PASS_TIME, bundle)) or
        (LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Events.ADULT_CAN_PASS_TIME, bundle))
end

function LogicHelpers.at_night(bundle)
    return (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Events.CHILD_CAN_PASS_TIME, bundle)) or
        (LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Events.ADULT_CAN_PASS_TIME, bundle))
end

function LogicHelpers.is_child(bundle)
    local state = bundle[1]
    local parent_region = bundle[2]
    return state:_soh_can_reach_as_age(parent_region, Ages.CHILD)
end

function LogicHelpers.starting_age(bundle)
    local world = bundle[3]
    local age = world:get_option("starting_age")
    return (age == Options.STARTING_AGE_CHILD and LogicHelpers.is_child(bundle)) or
        (age == Options.STARTING_AGE_ADULT and LogicHelpers.is_adult(bundle))
end

function LogicHelpers.can_damage(bundle)
    return LogicHelpers.can_jump_slash(bundle) or LogicHelpers.has_explosives(bundle) or
        LogicHelpers.can_use_any({Items.FAIRY_SLINGSHOT, Items.FAIRY_BOW, Items.DINS_FIRE}, bundle)
end

function LogicHelpers.can_attack(bundle)
    return LogicHelpers.can_damage(bundle) or LogicHelpers.can_use_any({Items.BOOMERANG, Items.HOOKSHOT}, bundle)
end

function LogicHelpers.can_standing_shield(bundle)
    return (LogicHelpers.can_use_any({Items.MIRROR_SHIELD, Items.DEKU_SHIELD}, bundle)) or
        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HYLIAN_SHIELD, bundle))
end

function LogicHelpers.can_shield(bundle)
    return LogicHelpers.can_use_any({Items.MIRROR_SHIELD, Items.HYLIAN_SHIELD, Items.DEKU_SHIELD}, bundle)
end

function LogicHelpers.take_damage(bundle)
    return LogicHelpers.can_use_any({Items.BOTTLE_WITH_FAIRY, Items.NAYRUS_LOVE}, bundle) or
        LogicHelpers.effective_health(bundle) ~= 1
end

function LogicHelpers.can_do_trick(trick, bundle)
    local state = bundle[1]
    local world = bundle[3]
    if trick == nil or state.has_all_items then
        return false
    end
    return world:get_option("enable_all_tricks") or state:has(trick) or LogicHelpers.has_item(Items.GLITCHED, bundle)
end

function LogicHelpers.can_get_nighttime_gs(bundle)
    local world = bundle[3]
    return LogicHelpers.at_night(bundle) and
        (not world:get_option("skulls_sun_song") or LogicHelpers.can_use(Items.SUNS_SONG, bundle))
end

function LogicHelpers.can_break_pots(bundle)
    return true
end

function LogicHelpers.can_break_crates(bundle)
    return true
end

function LogicHelpers.can_break_small_crates(bundle)
    return true
end

function LogicHelpers.can_bonk_trees(bundle)
    return true
end

function LogicHelpers.can_hit_eye_targets(bundle)
    return LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle)
end

function LogicHelpers.can_stun_deku(bundle)
    return LogicHelpers.can_attack(bundle) or LogicHelpers.can_use(Items.NUTS, bundle) or
        LogicHelpers.can_reflect_nuts(bundle)
end

function LogicHelpers.can_reflect_nuts(bundle)
    return LogicHelpers.can_use(Items.DEKU_SHIELD, bundle) or
        (LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.HYLIAN_SHIELD, bundle))
end

function LogicHelpers.has_fire_source_with_torch(bundle)
    return LogicHelpers.has_fire_source(bundle) or LogicHelpers.can_use(Items.STICKS, bundle)
end

function LogicHelpers.has_fire_source(bundle)
    return LogicHelpers.can_use_any({Items.DINS_FIRE, Items.FIRE_ARROW}, bundle)
end

function LogicHelpers.can_jump_slash_except_hammer(bundle)
    return LogicHelpers.can_use(Items.STICKS, bundle) or LogicHelpers.can_use_sword(bundle)
end

function LogicHelpers.can_jump_slash(bundle)
    return LogicHelpers.can_jump_slash_except_hammer(bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
end

function LogicHelpers.call_gossip_fairy_except_suns(bundle)
    return LogicHelpers.can_use_any({Items.ZELDAS_LULLABY, Items.EPONAS_SONG, Items.SONG_OF_TIME}, bundle)
end

function LogicHelpers.call_gossip_fairy(bundle)
    return LogicHelpers.call_gossip_fairy_except_suns(bundle) or LogicHelpers.can_use(Items.SUNS_SONG, bundle)
end

function LogicHelpers.can_break_lower_hives(bundle)
    return LogicHelpers.can_break_upper_beehives(bundle) or LogicHelpers.can_use(Items.BOMB_BAG, bundle)
end

function LogicHelpers.can_break_upper_beehives(bundle)
    local world = bundle[3]
    return (LogicHelpers.hookshot_or_boomerang(bundle) or
        (LogicHelpers.can_do_trick(Tricks.BOMBCHU_BEEHIVES, bundle) and LogicHelpers.can_use(Items.BOMBCHU_BAG, bundle)) or
        (world:get_option("slingbow_break_beehives") and
            (LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle))))
end

function LogicHelpers.can_open_storms_grotto(bundle)
    return (LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
        (LogicHelpers.has_item(Items.STONE_OF_AGONY, bundle) or
            LogicHelpers.can_do_trick(Tricks.GROTTOS_WITHOUT_AGONY, bundle)))
end

function LogicHelpers.can_hit_at_range(bundle, distance, wall_or_floor, in_water)
    if distance == nil then
        distance = EnemyDistance.CLOSE
    end
    if wall_or_floor == nil then
        wall_or_floor = true
    end
    in_water = in_water or false
    if distance == EnemyDistance.CLOSE and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) then
        return true
    end
    if distance <= EnemyDistance.SHORT_JUMPSLASH and LogicHelpers.can_use(Items.KOKIRI_SWORD, bundle) then
        return true
    end
    if distance <= EnemyDistance.MASTER_SWORD_JUMPSLASH and LogicHelpers.can_use(Items.MASTER_SWORD, bundle) then
        return true
    end
    if distance <= EnemyDistance.LONG_JUMPSLASH and LogicHelpers.can_use_any({Items.BIGGORONS_SWORD, Items.STICKS}, bundle) then
        return true
    end
    if distance <= EnemyDistance.BOMB_THROW and (not in_water and LogicHelpers.can_use(Items.BOMB_BAG, bundle)) then
        return true
    end
    if
        distance <= EnemyDistance.HOOKSHOT and
            (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                (wall_or_floor and LogicHelpers.can_use(Items.BOMBCHUS_5, bundle)))
     then
        return true
    end
    if distance <= EnemyDistance.LONGSHOT and LogicHelpers.can_use(Items.LONGSHOT, bundle) then
        return true
    end
    if distance <= EnemyDistance.FAR and LogicHelpers.can_use_any({Items.FAIRY_SLINGSHOT, Items.FAIRY_BOW}, bundle) then
        return true
    end
    return false
end

function LogicHelpers.can_kill_enemy(bundle, enemy, distance, wall_or_floor, quantity, timer, in_water)
    if distance == nil then
        distance = EnemyDistance.CLOSE
    end
    if wall_or_floor == nil then
        wall_or_floor = true
    end
    if quantity == nil then
        quantity = 1
    end
    timer = timer or false
    in_water = in_water or false

    if enemies.guards[enemy] then
        return false
    end

    if enemy == Enemies.GOLD_SKULLTULA then
        return (LogicHelpers.can_hit_at_range(bundle, distance, wall_or_floor, in_water) or
            (distance <= EnemyDistance.LONGSHOT and wall_or_floor and LogicHelpers.can_use(Items.BOMBCHUS_5, bundle)) or
            (distance <= EnemyDistance.BOOMERANG and LogicHelpers.can_use_any({Items.DINS_FIRE, Items.BOOMERANG}, bundle)))
    end

    if enemy == Enemies.BIG_SKULLTULA then
        return (LogicHelpers.can_hit_at_range(bundle, distance, wall_or_floor, in_water) or
            (distance <= EnemyDistance.BOOMERANG and LogicHelpers.can_use(Items.DINS_FIRE, bundle)))
    end

    if enemies.small[enemy] then
        return LogicHelpers.can_attack(bundle)
    end

    if enemy == Enemies.DODONGO then
        return (LogicHelpers.can_use_sword(bundle) or
            LogicHelpers.can_use_any({Items.MEGATON_HAMMER, Items.FAIRY_SLINGSHOT, Items.FAIRY_BOW}, bundle) or
            (quantity <= 5 and LogicHelpers.can_use(Items.STICKS, bundle)) or
            LogicHelpers.has_explosives(bundle))
    end

    if enemy == Enemies.LIZALFOS then
        return (LogicHelpers.can_jump_slash(bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle) or
            LogicHelpers.has_explosives(bundle))
    end

    if enemies.keese[enemy] then
        return (LogicHelpers.can_hit_at_range(bundle, distance, wall_or_floor, in_water) or
            (distance == EnemyDistance.CLOSE and LogicHelpers.can_use(Items.KOKIRI_SWORD, bundle)) or
            (distance <= EnemyDistance.BOOMERANG and LogicHelpers.can_use(Items.BOOMERANG, bundle)) or
            (distance == EnemyDistance.SHORT_JUMPSLASH and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)))
    end

    if enemy == Enemies.BLUE_BUBBLE then
        return LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
            ((LogicHelpers.can_jump_slash_except_hammer(bundle) or LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)) and
                (LogicHelpers.can_use(Items.NUTS, bundle) or LogicHelpers.hookshot_or_boomerang(bundle) or
                    LogicHelpers.can_standing_shield(bundle)))
    end

    if enemy == Enemies.DEAD_HAND then
        return LogicHelpers.can_use_sword(bundle) or
            (LogicHelpers.can_use(Items.STICKS, bundle) and LogicHelpers.can_do_trick(Tricks.BOTW_CHILD_DEADHAND, bundle))
    end

    if enemy == Enemies.WITHERED_DEKU_BABA then
        return LogicHelpers.can_attack(bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)
    end

    if enemies.like_like_and_floor[enemy] then
        return LogicHelpers.can_damage(bundle)
    end

    if enemy == Enemies.STALFOS then
        if
            distance <= EnemyDistance.SHORT_JUMPSLASH and
                LogicHelpers.can_use_any({Items.MEGATON_HAMMER, Items.KOKIRI_SWORD}, bundle)
         then
            return true
        end
        if distance <= EnemyDistance.MASTER_SWORD_JUMPSLASH and LogicHelpers.can_use(Items.MASTER_SWORD, bundle) then
            return true
        end
        if
            (distance <= EnemyDistance.LONG_JUMPSLASH and
                (LogicHelpers.can_use(Items.BIGGORONS_SWORD, bundle) or
                    (quantity <= 1 and LogicHelpers.can_use(Items.STICKS, bundle))))
         then
            return true
        end
        if
            distance <= EnemyDistance.BOMB_THROW and quantity <= 2 and not timer and not in_water and
                (LogicHelpers.can_use(Items.NUTS, bundle) or LogicHelpers.hookshot_or_boomerang(bundle)) and
                LogicHelpers.can_use(Items.BOMB_BAG, bundle)
         then
            return true
        end
        if distance <= EnemyDistance.HOOKSHOT and wall_or_floor and LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) then
            return true
        end
        if distance <= EnemyDistance.FAR and LogicHelpers.can_use(Items.FAIRY_BOW, bundle) then
            return true
        end
        return false
    end

    if enemy == Enemies.IRON_KNUCKLE then
        return (LogicHelpers.can_use_sword(bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) or
            LogicHelpers.has_explosives(bundle))
    end

    if enemy == Enemies.FLARE_DANCER then
        return (LogicHelpers.can_use_any({Items.MEGATON_HAMMER, Items.HOOKSHOT}, bundle) or
            (LogicHelpers.has_explosives(bundle) and
                (LogicHelpers.can_jump_slash_except_hammer(bundle) or
                    LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT, Items.BOOMERANG}, bundle))))
    end

    if enemies.wolves_and_walls[enemy] then
        return (LogicHelpers.can_jump_slash(bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT, Items.BOMBCHUS_5, Items.DINS_FIRE}, bundle) or
            (LogicHelpers.can_use(Items.BOMB_BAG, bundle) and
                LogicHelpers.can_use_any({Items.NUTS, Items.HOOKSHOT, Items.BOOMERANG}, bundle)))
    end

    if enemy == Enemies.GERUDO_WARRIOR then
        return LogicHelpers.can_jump_slash(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
            (LogicHelpers.can_do_trick(Tricks.GF_WARRIOR_WITH_DIFFICULT_WEAPON, bundle) and
                LogicHelpers.can_use_any({Items.FAIRY_SLINGSHOT, Items.BOMBCHUS_5}, bundle))
    end

    if enemies.undead[enemy] then
        return LogicHelpers.can_jump_slash(bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle)
    end

    if enemy == Enemies.MEG then
        return LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT}, bundle) or LogicHelpers.has_explosives(bundle)
    end

    if enemy == Enemies.ARMOS then
        return (LogicHelpers.blast_or_smash(bundle) or
            LogicHelpers.can_use_any({Items.MASTER_SWORD, Items.BIGGORONS_SWORD, Items.STICKS, Items.FAIRY_BOW}, bundle) or
            (LogicHelpers.can_use_any({Items.NUTS, Items.HOOKSHOT, Items.BOOMERANG}, bundle) and
                LogicHelpers.can_use_any({Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle)))
    end

    if enemy == Enemies.GREEN_BUBBLE then
        return (LogicHelpers.can_jump_slash(bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle) or
            LogicHelpers.has_explosives(bundle))
    end

    if enemy == Enemies.DINOLFOS then
        return LogicHelpers.can_jump_slash(bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle) or
            (not timer and LogicHelpers.can_use(Items.BOMBCHUS_5, bundle))
    end

    if enemy == Enemies.TORCH_SLUG then
        return LogicHelpers.can_jump_slash(bundle) or LogicHelpers.has_explosives(bundle) or
            LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
    end

    if enemy == Enemies.FREEZARD then
        return (LogicHelpers.can_use_any(
            {
                Items.MASTER_SWORD,
                Items.BIGGORONS_SWORD,
                Items.MEGATON_HAMMER,
                Items.STICKS,
                Items.HOOKSHOT,
                Items.DINS_FIRE,
                Items.FIRE_ARROW
            },
            bundle
        ) or LogicHelpers.has_explosives(bundle))
    end

    if enemy == Enemies.SHELL_BLADE then
        return (LogicHelpers.can_jump_slash(bundle) or LogicHelpers.has_explosives(bundle) or
            LogicHelpers.can_use_any({Items.HOOKSHOT, Items.FAIRY_BOW, Items.DINS_FIRE}, bundle))
    end

    if enemy == Enemies.SPIKE then
        return (LogicHelpers.can_use_any(
            {
                Items.MASTER_SWORD,
                Items.BIGGORONS_SWORD,
                Items.MEGATON_HAMMER,
                Items.STICKS,
                Items.HOOKSHOT,
                Items.FAIRY_BOW,
                Items.DINS_FIRE
            },
            bundle
        ) or LogicHelpers.has_explosives(bundle))
    end

    if enemy == Enemies.STINGER then
        return (LogicHelpers.can_hit_at_range(bundle, distance, wall_or_floor, in_water) or
            (distance == EnemyDistance.SHORT_JUMPSLASH and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)))
    end

    if enemy == Enemies.BIG_OCTO then
        return LogicHelpers.can_use_any({Items.KOKIRI_SWORD, Items.STICKS, Items.MASTER_SWORD}, bundle)
    end

    if enemy == Enemies.GOHMA then
        return LogicHelpers.has_boss_soul(Items.GOHMAS_SOUL, bundle) and LogicHelpers.can_jump_slash(bundle) and
            (LogicHelpers.can_use_any({Items.NUTS, Items.FAIRY_SLINGSHOT, Items.FAIRY_BOW}, bundle) or
                LogicHelpers.hookshot_or_boomerang(bundle))
    end

    if enemy == Enemies.KING_DODONGO then
        return (LogicHelpers.has_boss_soul(Items.KING_DODONGOS_SOUL, bundle) and LogicHelpers.can_jump_slash(bundle) and
            (LogicHelpers.can_use_any({Items.BOMB_BAG, Items.GORONS_BRACELET}, bundle) or
                (LogicHelpers.can_do_trick(Tricks.DC_DODONGO_CHU, bundle) and LogicHelpers.is_adult(bundle) and
                    LogicHelpers.can_use(Items.BOMBCHUS_5, bundle))))
    end

    if enemy == Enemies.BARINADE then
        return (LogicHelpers.has_boss_soul(Items.BARINADES_SOUL, bundle) and LogicHelpers.can_use(Items.BOOMERANG, bundle) and
            LogicHelpers.can_jump_slash_except_hammer(bundle))
    end

    if enemy == Enemies.PHANTOM_GANON then
        return (LogicHelpers.has_boss_soul(Items.PHANTOM_GANONS_SOUL, bundle) and LogicHelpers.can_use_sword(bundle) and
            LogicHelpers.can_use_any({Items.HOOKSHOT, Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle))
    end

    if enemy == Enemies.VOLVAGIA then
        return LogicHelpers.has_boss_soul(Items.VOLVAGIAS_SOUL, bundle) and
            LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
    end

    if enemy == Enemies.MORPHA then
        return (LogicHelpers.has_boss_soul(Items.MORPHAS_SOUL, bundle) and
            (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                (LogicHelpers.can_do_trick(Tricks.WATER_MORPHA_WITHOUT_HOOKSHOT, bundle) and
                    LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))) and
            (LogicHelpers.can_use_sword(bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)))
    end

    if enemy == Enemies.BONGO_BONGO then
        return LogicHelpers.has_boss_soul(Items.BONGO_BONGOS_SOUL, bundle) and
            (LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) or LogicHelpers.can_do_trick(Tricks.LENS_BONGO, bundle)) and
            LogicHelpers.can_use_sword(bundle) and
            (LogicHelpers.can_use_any({Items.HOOKSHOT, Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle) or
                LogicHelpers.can_do_trick(Tricks.SHADOW_BONGO, bundle))
    end

    if enemy == Enemies.TWINROVA then
        return LogicHelpers.has_boss_soul(Items.TWINROVAS_SOUL, bundle) and LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) and
            (LogicHelpers.can_use_sword(bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle))
    end

    if enemy == Enemies.GANONDORF then
        return LogicHelpers.has_boss_soul(Items.GANONS_SOUL, bundle) and LogicHelpers.can_use(Items.LIGHT_ARROW, bundle) and
            LogicHelpers.can_use_sword(bundle)
    end

    if enemy == Enemies.GANON then
        return LogicHelpers.has_boss_soul(Items.GANONS_SOUL, bundle) and LogicHelpers.can_use(Items.MASTER_SWORD, bundle)
    end

    if enemy == Enemies.DARK_LINK then
        return LogicHelpers.can_jump_slash(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
    end

    if enemy == Enemies.ANUBIS then
        return LogicHelpers.has_fire_source(bundle)
    end

    if enemy == Enemies.BEAMOS then
        return LogicHelpers.has_explosives(bundle)
    end

    if enemy == Enemies.PURPLE_LEEVER then
        return LogicHelpers.can_use_any({Items.MASTER_SWORD, Items.BIGGORONS_SWORD}, bundle)
    end

    if enemy == Enemies.TENTACLE then
        return LogicHelpers.can_use(Items.BOOMERANG, bundle)
    end

    if enemy == Enemies.BARI then
        return (LogicHelpers.hookshot_or_boomerang(bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.STICKS, Items.MEGATON_HAMMER, Items.DINS_FIRE}, bundle) or
            LogicHelpers.has_explosives(bundle) or
            (LogicHelpers.take_damage(bundle) and LogicHelpers.can_use_sword(bundle)))
    end

    if enemy == Enemies.SHABOM then
        return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.NUTS, Items.DINS_FIRE, Items.ICE_ARROW}, bundle) or
            LogicHelpers.can_jump_slash(bundle))
    end

    if enemy == Enemies.OCTOROK then
        return (LogicHelpers.can_reflect_nuts(bundle) or LogicHelpers.hookshot_or_boomerang(bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT, Items.BOMB_BAG}, bundle) or
            (wall_or_floor and LogicHelpers.can_use(Items.BOMBCHUS_5, bundle)))
    end

    return false
end

function LogicHelpers.has_boss_soul(soul, bundle)
    local world = bundle[3]
    local soulsanity = world:get_option("shuffle_boss_souls")
    if soulsanity == Options.BOSS_SOULS_OFF then
        return true
    end
    if soul == Items.GANONS_SOUL and soulsanity == Options.BOSS_SOULS_ON then
        return true
    end
    return LogicHelpers.has_item(soul, bundle)
end

function LogicHelpers.can_pass_enemy(bundle, enemy, distance, wall_or_floor)
    distance = distance or EnemyDistance.CLOSE
    if wall_or_floor == nil then
        wall_or_floor = true
    end

    if enemy == Enemies.GERUDO_GUARD then
        return (LogicHelpers.can_do_trick(Tricks.PASS_GUARDS_WITH_NOTHING, bundle) or
            LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT}, bundle))
    end

    if enemy == Enemies.BREAK_ROOM_GUARD then
        return (LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle) or
            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT}, bundle))
    end

    if enemy == Enemies.BIG_SKULLTULA then
        return (LogicHelpers.can_kill_enemy(bundle, enemy, distance, wall_or_floor) or
            LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle))
    end

    if enemy == Enemies.LIKE_LIKE then
        return (LogicHelpers.can_kill_enemy(bundle, enemy, distance, wall_or_floor) or
            LogicHelpers.can_use_any({Items.HOOKSHOT, Items.BOOMERANG}, bundle))
    end

    if enemies.undead[enemy] then
        return (LogicHelpers.can_kill_enemy(bundle, enemy, distance, wall_or_floor) or
            LogicHelpers.can_use_any({Items.HOOKSHOT, Items.SUNS_SONG}, bundle))
    end

    if enemies.knuckle_octo[enemy] then
        return LogicHelpers.can_kill_enemy(bundle, enemy, distance, wall_or_floor)
    end

    if enemy == Enemies.GREEN_BUBBLE then
        return (LogicHelpers.can_kill_enemy(bundle, enemy, distance, wall_or_floor) or LogicHelpers.take_damage(bundle) or
            LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG, Items.HOOKSHOT}, bundle))
    end
end

function LogicHelpers.can_cut_shrubs(bundle)
    return (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_explosives(bundle) or
        LogicHelpers.can_use_any({Items.BOOMERANG, Items.GORONS_BRACELET, Items.MEGATON_HAMMER}, bundle))
end

function LogicHelpers.hookshot_or_boomerang(bundle)
    return LogicHelpers.can_use_any({Items.HOOKSHOT, Items.BOOMERANG}, bundle)
end

function LogicHelpers.can_open_underwater_chest(bundle)
    return (LogicHelpers.can_do_trick(Tricks.OPEN_UNDERWATER_CHEST, bundle) and
        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
        LogicHelpers.can_use(Items.HOOKSHOT, bundle))
end

function LogicHelpers.can_open_overworld_door(key, bundle)
    local world = bundle[3]
    if not world:get_option("lock_overworld_doors") then
        return true
    end
    return LogicHelpers.has_item(Items.SKELETON_KEY, bundle) or LogicHelpers.has_item(key, bundle)
end

function LogicHelpers.small_keys(key, required_amount, bundle)
    local state = bundle[1]
    if key == Items.FIRE_TEMPLE_SMALL_KEY and not LogicHelpers.is_fire_loop_locked(bundle) then
        required_amount = required_amount - 1
    end
    return (state:has_any({Items.SKELETON_KEY, key_to_ring[key]}) or state:has(key, required_amount))
end

function LogicHelpers.can_get_enemy_drop(bundle, enemy, distance, above_link)
    distance = distance or EnemyDistance.CLOSE
    above_link = above_link or false

    if not LogicHelpers.can_kill_enemy(bundle, enemy, distance) then
        return false
    end

    if distance <= EnemyDistance.MASTER_SWORD_JUMPSLASH then
        return true
    end

    if enemy == Enemies.GOLD_SKULLTULA then
        if distance <= EnemyDistance.BOOMERANG and LogicHelpers.can_use(Items.BOOMERANG, bundle) then
            return true
        end
        if distance <= EnemyDistance.HOOKSHOT and LogicHelpers.can_use(Items.HOOKSHOT, bundle) then
            return true
        end
        if distance <= EnemyDistance.LONGSHOT and LogicHelpers.can_use(Items.LONGSHOT, bundle) then
            return true
        end
        return false
    elseif enemy == Enemies.KEESE then
        return true
    elseif enemy == Enemies.FIRE_KEESE then
        return true
    else
        return above_link or (distance <= EnemyDistance.BOOMERANG and LogicHelpers.can_use(Items.BOOMERANG, bundle))
    end
end

function LogicHelpers.can_detonate_bomb_flowers(bundle)
    return LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.DINS_FIRE}, bundle) or LogicHelpers.has_explosives(bundle)
end

function LogicHelpers.can_detonate_upright_bomb_flower(bundle)
    return (LogicHelpers.can_detonate_bomb_flowers(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or
        (LogicHelpers.can_do_trick(Tricks.BLUE_FIRE_MUD_WALLS, bundle) and LogicHelpers.blue_fire(bundle) and
            (LogicHelpers.effective_health(bundle) ~= 1 or LogicHelpers.can_use(Items.NAYRUS_LOVE))))
end

function LogicHelpers.item_group_count(bundle, item_group_key)
    local state = bundle[1]
    return state:count_group_unique(ItemData.item_name_groups[item_group_key])
end

function LogicHelpers.ocarina_button_count(bundle)
    local world = bundle[3]
    if world:get_option("shuffle_ocarina_buttons") then
        return LogicHelpers.item_group_count(bundle, "Ocarina Buttons")
    end
    return 5
end

function LogicHelpers.stone_count(bundle)
    return LogicHelpers.item_group_count(bundle, "Stones")
end

function LogicHelpers.medallion_count(bundle)
    return LogicHelpers.item_group_count(bundle, "Medallions")
end

function LogicHelpers.dungeon_count(bundle)
    local count = 0
    for _, dungeon in pairs(dungeon_events) do
        if LogicHelpers.has_item(dungeon, bundle) then
            count = count + 1
        end
    end
    return count
end

function LogicHelpers.can_spawn_soil_skull(bundle)
    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.BOTTLE_WITH_BUGS, bundle)
end

function LogicHelpers.fire_timer(bundle)
    if LogicHelpers.can_use(Items.GORON_TUNIC, bundle) then
        return 255
    end
    if LogicHelpers.can_do_trick(Tricks.FEWER_TUNIC_REQUIREMENTS, bundle) then
        return LogicHelpers.hearts(bundle) * 8
    end
    return 0
end

function LogicHelpers.hearts(bundle)
    local state = bundle[1]
    return state:get_heart_count()
end

function LogicHelpers.water_timer(bundle)
    if LogicHelpers.can_use(Items.ZORA_TUNIC, bundle) then
        return 255
    end
    if LogicHelpers.can_do_trick(Tricks.FEWER_TUNIC_REQUIREMENTS, bundle) then
        return LogicHelpers.hearts(bundle) * 8
    end
    return 0
end

function LogicHelpers.can_open_bomb_grotto(bundle)
    return LogicHelpers.blast_or_smash(bundle) and
        (LogicHelpers.has_item(Items.STONE_OF_AGONY, bundle) or
            LogicHelpers.can_do_trick(Tricks.GROTTOS_WITHOUT_AGONY, bundle))
end

function LogicHelpers.trade_quest_step(item, bundle)
    local world = bundle[3]
    if not world:get_option("shuffle_adult_trade_items") then
        return LogicHelpers.has_item(Items.CLAIM_CHECK, bundle)
    end

    if item == Items.POCKET_EGG then
        return LogicHelpers.has_item(Items.POCKET_EGG, bundle) or LogicHelpers.trade_quest_step(Items.COJIRO, bundle)
    end

    if item == Items.COJIRO then
        return LogicHelpers.has_item(Items.COJIRO, bundle) or LogicHelpers.trade_quest_step(Items.ODD_MUSHROOM, bundle)
    end

    if item == Items.ODD_MUSHROOM then
        return LogicHelpers.has_item(Items.ODD_MUSHROOM, bundle) or LogicHelpers.trade_quest_step(Items.ODD_POTION, bundle)
    end

    if item == Items.ODD_POTION then
        return LogicHelpers.has_item(Items.ODD_POTION, bundle) or LogicHelpers.trade_quest_step(Items.POACHERS_SAW, bundle)
    end

    if item == Items.POACHERS_SAW then
        return LogicHelpers.has_item(Items.POACHERS_SAW, bundle) or
            LogicHelpers.trade_quest_step(Items.BROKEN_GORONS_SWORD, bundle)
    end

    if item == Items.BROKEN_GORONS_SWORD then
        return LogicHelpers.has_item(Items.BROKEN_GORONS_SWORD, bundle) or
            LogicHelpers.trade_quest_step(Items.PRESCRIPTION, bundle)
    end

    if item == Items.PRESCRIPTION then
        return LogicHelpers.has_item(Items.PRESCRIPTION, bundle) or
            LogicHelpers.trade_quest_step(Items.WORLDS_FINEST_EYEDROPS, bundle)
    end

    if item == Items.WORLDS_FINEST_EYEDROPS then
        return LogicHelpers.has_item(Items.WORLDS_FINEST_EYEDROPS, bundle) or
            LogicHelpers.trade_quest_step(Items.CLAIM_CHECK, bundle)
    end

    if item == Items.CLAIM_CHECK then
        return LogicHelpers.has_item(Items.CLAIM_CHECK, bundle)
    end

    return false
end

function LogicHelpers.can_build_rainbow_bridge(bundle)
    local world = bundle[3]
    local greg_reward = 0
    if
        LogicHelpers.has_item(Items.GREG_THE_GREEN_RUPEE, bundle) and
        world:get_option("rainbow_bridge_greg_modifier") == Options.BRIDGE_GREG_MODIFIER_REWARD
    then
        greg_reward = 1
    end

    local bridge_setting = world:get_option("rainbow_bridge")

    local settings_functions = {
        [Options.BRIDGE_OPEN] = function()
            return true
        end,
        [Options.BRIDGE_VANILLA] = function()
            return LogicHelpers.has_item(Items.SHADOW_MEDALLION, bundle) and
                LogicHelpers.has_item(Items.SPIRIT_MEDALLION, bundle) and
                LogicHelpers.can_use(Items.LIGHT_ARROW, bundle)
        end,
        [Options.BRIDGE_STONES] = function()
            return ((LogicHelpers.stone_count(bundle) + greg_reward) >= world:get_option("rainbow_bridge_stones_required"))
        end,
        [Options.BRIDGE_MEDALLIONS] = function()
            return ((LogicHelpers.medallion_count(bundle) + greg_reward) >=
                world:get_option("rainbow_bridge_medallions_required"))
        end,
        [Options.BRIDGE_REWARDS] = function()
            return ((LogicHelpers.stone_count(bundle) + LogicHelpers.medallion_count(bundle) + greg_reward) >=
                world:get_option("rainbow_bridge_dungeon_rewards_required"))
        end,
        [Options.BRIDGE_DUNGEONS] = function()
            return ((LogicHelpers.dungeon_count(bundle) + greg_reward) >=
                world:get_option("rainbow_bridge_dungeons_required"))
        end,
        [Options.BRIDGE_TOKENS] = function()
            return (LogicHelpers.get_gs_count(bundle) >= world:get_option("rainbow_bridge_skull_tokens_required"))
        end,
        [Options.BRIDGE_GREG] = function()
            return LogicHelpers.has_item(Items.GREG_THE_GREEN_RUPEE, bundle)
        end
    }

    return settings_functions[bridge_setting]()
end

function LogicHelpers.get_gs_count(bundle)
    local state = bundle[1]
    return state:count(Items.GOLD_SKULLTULA_TOKEN)
end

function LogicHelpers.can_trigger_lacs(bundle)
    local world = bundle[3]

    local greg_reward = 0
    if
        LogicHelpers.has_item(Items.GREG_THE_GREEN_RUPEE, bundle) and
            world:get_option("ganons_castle_boss_key_greg_modifier") == Options.GANONS_BOSS_KEY_GREG_MODIFIER_REWARD
     then
        greg_reward = 1
    end

    local gbk_setting = world:get_option("ganons_castle_boss_key")

    local shadow_spirit_medallion = function()
        return LogicHelpers.has_item(Items.SHADOW_MEDALLION, bundle) and
            LogicHelpers.has_item(Items.SPIRIT_MEDALLION, bundle)
    end

    local settings_functions = {
        [Options.GANONS_BOSS_KEY_VANILLA] = shadow_spirit_medallion,
        [Options.GANONS_BOSS_KEY_ANYWHERE] = shadow_spirit_medallion,
        [Options.GANONS_BOSS_KEY_LACS_VANILLA] = shadow_spirit_medallion,
        [Options.GANONS_BOSS_KEY_LACS_STONES] = function()
            return ((LogicHelpers.stone_count(bundle) + greg_reward) >=
                world:get_option("ganons_castle_boss_key_stones_required"))
        end,
        [Options.GANONS_BOSS_KEY_LACS_MEDALLIONS] = function()
            return ((LogicHelpers.medallion_count(bundle) + greg_reward) >=
                world:get_option("ganons_castle_boss_key_medallions_required"))
        end,
        [Options.GANONS_BOSS_KEY_LACS_DUNGEON_REWARDS] = function()
            return ((LogicHelpers.stone_count(bundle) + LogicHelpers.medallion_count(bundle) + greg_reward) >=
                world:get_option("ganons_castle_boss_key_dungeon_rewards_required"))
        end,
        [Options.GANONS_BOSS_KEY_LACS_DUNGEONS] = function()
            return ((LogicHelpers.dungeon_count(bundle) + greg_reward) >=
                world:get_option("ganons_castle_boss_key_dungeons_required"))
        end,
        [Options.GANONS_BOSS_KEY_LACS_TOKENS] = function()
            return (LogicHelpers.get_gs_count(bundle) >= world:get_option("ganons_castle_boss_key_skull_tokens_required"))
        end
    }

    return settings_functions[gbk_setting]()
end

function LogicHelpers.effective_health(bundle)
    return 2
end

function LogicHelpers.is_fire_loop_locked(bundle)
    local world = bundle[3]
    local small_key_shuffle = world:get_option("small_key_shuffle")
    return small_key_shuffle == Options.SMALL_KEY_SHUFFLE_ANYWHERE or
        small_key_shuffle == Options.SMALL_KEY_SHUFFLE_OVERWORLD or
        small_key_shuffle == Options.SMALL_KEY_SHUFFLE_ANY_DUNGEON
end

function LogicHelpers.can_ground_jump(bundle, has_bomb_flower)
    has_bomb_flower = has_bomb_flower or false
end

function LogicHelpers.can_clear_stalagmite(bundle)
    return LogicHelpers.can_jump_slash(bundle) or LogicHelpers.has_explosives(bundle)
end

function REACHABLE(location_name)
    local actual_name = Locations[location_name]
    local location = SOH_COLLECTION_STATE.world:get_location(actual_name)
    if location == nil then
        print(string.format("Could not find location with name: %s", location_name))
        return
    end
    if location:can_reach(SOH_COLLECTION_STATE) then
        return ACCESS_NORMAL
    end
    return ACCESS_NONE
end

function OPTION_OCARINA_SHUFFLE()
    --Non-shuffled places vanilla item, item still exists in the MW
    return true
end

function OPTION_POTS_OVERWORLD()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_pots")
    return option == Options.POTS_OVERWORLD or option == Options.POTS_ALL
end

function OPTION_POTS_DUNGEON()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_pots")
    return option == Options.POTS_DUNGEON or option == Options.POTS_ALL
end

function OPTION_SKULLS_OVERWORLD()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_skull_tokens")
    return option == Options.TOKEN_SHUFFLE_OVERWORLD or option == Options.TOKEN_SHUFFLE_ALL
end

function OPTION_SKULLS_DUNGEON()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_skull_tokens")
    return option == Options.TOKEN_SHUFFLE_DUNGEON or option == Options.TOKEN_SHUFFLE_ALL
end

function OPTION_GRASS_OVERWORLD()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_grass")
    return option == Options.GRASS_OVERWORLD or option == Options.GRASS_ALL
end

function OPTION_GRASS_DUNGEON()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_grass")
    return option == Options.GRASS_DUNGEON or option == Options.GRASS_ALL
end

function OPTION_FISH_OVERWORLD()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_fish")
    return option == Options.FISH_OVERWORLD or option == Options.GRASS_ALL
end

function OPTION_FISH_POND()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_fish")
    return option == Options.FISH_POND or option == Options.FISH_ALL
end

function OPTION_BEEHIVES()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_beehives")
end

function OPTION_FROG_SONG_RUPEES()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_frog_song_rupees")
end

function OPTION_STONE_FAIRIES()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_stone_fairies")
end

function OPTION_FAIRY_SPOTS()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_song_fairies")
end

function OPTION_BEAN_FAIRIES()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_bean_fairies")
end

function OPTION_FOUNTAIN_FAIRIES()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_fountain_fairies")
end

function OPTION_TREES()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_trees")
end

function OPTION_CRATES_OVERWORLD()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_crates")
    return option == Options.CRATES_OVERWORLD or option == Options.CRATES_ALL
end

function OPTION_CRATES_DUNGEON()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_crates")
    return option == Options.CRATES_DUNGEON or option == Options.CRATES_ALL
end

function OPTION_COWS()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_cows")
end

function OPTION_BEANS_MERCHANT()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_merchants")
    return option == Options.MERCHANTS_ALL or option == Options.MERCHANTS_BEAN_MERCHANT_ONLY
end

function OPTION_NON_BEANS_MERCHANTS()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_merchants")
    return option == Options.MERCHANTS_ALL or option == Options.MERCHANTS_ALL_BUT_BEANS
end

function OPTION_SCRUBS_NON_ONE_TIME()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_scrubs")
    return option == Options.SCRUBS_ALL
end

function OPTION_SCRUBS_ONE_TIME()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_scrubs")
    return option == Options.SCRUBS_ALL or option == Options.SCRUBS_ONE_TIME_ONLY
end

function SHOP_ITEM_ACTIVE(amount)
    if not SOH_COLLECTION_STATE.world:get_option("shuffle_shops") then
        return false
    end
    return (8 - tonumber(amount)) < SOH_COLLECTION_STATE.world:get_option("shuffle_shops_item_amount")
end

function OPTION_FREESTANDING_ITEMS_OVERWORLD()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_freestanding_items")
    return option == Options.FREESTANDING_OVERWORLD or option == Options.FREESTANDING_ALL
end

function OPTION_FREESTANDING_ITEMS_DUNGEON()
    local option = SOH_COLLECTION_STATE.world:get_option("shuffle_freestanding_items")
    return option == Options.FREESTANDING_DUNGEON or option == Options.FREESTANDING_ALL
end

function OPTION_ADULT_TRADE_SHUFFLE()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_adult_trade_items")
end

function OPTION_SONG_SHUFFLE()
    --Non-shuffled places vanilla item, item still exists in the MW
    return true
end

function OPTION_100_SKULLS_REWARD()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_100_gs_reward")
end

function OPTION_MASTER_SWORD_SHUFFLED()
    return SOH_COLLECTION_STATE.world:get_option("shuffle_master_sword")
end

function OPTION_ZELDAS_LETTER_SHUFFLED()
    return not SOH_COLLECTION_STATE.world:get_option("skip_child_zelda")
end

function OPTION_WEIRD_EGG_SHUFFLED()
    return not SOH_COLLECTION_STATE.world:get_option("skip_child_zelda") --and
    --SOH_COLLECTION_STATE.world:get_option("shuffle_weird_egg")
end

function OPTION_1_TORCH_CELL_KEY_EXISTS()
    return SOH_COLLECTION_STATE.world:get_option("fortress_carpenters") <= Options.CARPENTERS_FAST
end

function OPTION_NON_1_TORCH_CELL_KEYS_EXIST()
    return SOH_COLLECTION_STATE.world:get_option("fortress_carpenters") == Options.CARPENTERS_NORMAL
end

function OPTION_CARPENTERS_NOT_FREE()
    return SOH_COLLECTION_STATE.world:get_option("fortress_carpenters") ~= Options.CARPENTERS_FREE
end

function AGE_CHECK(location_name)
    local child_only = SOH_COLLECTION_STATE.world.regions.child_only_locations
    local adult_only = SOH_COLLECTION_STATE.world.regions.adult_only_locations
    local actual_name = Locations[location_name]
    if child_only[actual_name] and SETTING_SHOW_CHECKS == ShowChecks.ADULT then
        return false
    end
    if adult_only[actual_name] and SETTING_SHOW_CHECKS == ShowChecks.CHILD then
        return false
    end
    return true
end
