local variant = Tracker.ActiveVariantUID

require("scripts/utils")

-- Logic
require("scripts/logic/enums")
require("scripts/logic/logic_helpers")

local SoHCollectionState = require("scripts/logic/soh_collection_state")
local SoHRegion = require("scripts/logic/soh_region")
local World = require("scripts/logic/base_classes/world")
local world = World()

SoHRegion:create_regions_and_locations(world)
SOH_COLLECTION_STATE = SoHCollectionState(world)

-- Maps
if Tracker.ActiveVariantUID == "maps-u" then
    Tracker:AddMaps("maps/maps-u.json")
else
    Tracker:AddMaps("maps/maps.json")
end

Tracker:AddItems("items/items.json")
Tracker:AddItems("items/settings_main.json")
Tracker:AddItems("items/settings_tricks.json")

Tracker:AddLocations("locations/Bottom of the Well.json")
Tracker:AddLocations("locations/Death Mountain Crater.json")
Tracker:AddLocations("locations/Death Mountain Trail.json")
Tracker:AddLocations("locations/Deku Tree.json")
Tracker:AddLocations("locations/Desert Colossus.json")
Tracker:AddLocations("locations/Dodongo's Cavern.json")
Tracker:AddLocations("locations/Fire Temple.json")
Tracker:AddLocations("locations/Forest Temple.json")
Tracker:AddLocations("locations/Ganon's Castle.json")
Tracker:AddLocations("locations/Gerudo Fortress.json")
Tracker:AddLocations("locations/Gerudo Training Ground.json")
Tracker:AddLocations("locations/Gerudo Valley.json")
Tracker:AddLocations("locations/Goron City.json")
Tracker:AddLocations("locations/Graveyard.json")
Tracker:AddLocations("locations/Haunted Wasteland.json")
Tracker:AddLocations("locations/Hyrule Castle.json")
Tracker:AddLocations("locations/Hyrule Field.json")
Tracker:AddLocations("locations/Ice Cavern.json")
Tracker:AddLocations("locations/Jabu Jabu's Belly.json")
Tracker:AddLocations("locations/Kakariko Village.json")
Tracker:AddLocations("locations/Kokiri Forest.json")
Tracker:AddLocations("locations/Lake Hylia.json")
Tracker:AddLocations("locations/Lon Lon Ranch.json")
Tracker:AddLocations("locations/Lost Woods.json")
Tracker:AddLocations("locations/Market.json")
Tracker:AddLocations("locations/Outside Ganon's Castle.json")
Tracker:AddLocations("locations/Sacred Forest Meadow.json")
Tracker:AddLocations("locations/Shadow Temple.json")
Tracker:AddLocations("locations/Spirit Temple.json")
Tracker:AddLocations("locations/Temple of Time.json")
Tracker:AddLocations("locations/Water Temple.json")
Tracker:AddLocations("locations/Zora's Domain.json")
Tracker:AddLocations("locations/Zora's Fountain.json")
Tracker:AddLocations("locations/Zora's River.json")
Tracker:AddLocations("locations/Overworld.json")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.26.0" then
    require("scripts/autotracking")
end

Tracker:AddLayouts("layouts/settings_grid.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/settings_popup.json")
Tracker:AddLayouts("layouts/songs_and_medallions.json")
Tracker:AddLayouts("layouts/dungeon_items.json")
Tracker:AddLayouts("layouts/overworld_keys.json")
Tracker:AddLayouts("layouts/map_tools.json")
Tracker:AddLayouts("layouts/tabs.json")
Tracker:AddLayouts("layouts/tracker.json")
--Tracker:AddLayouts("layouts/broadcast.json")

local text = {"DT", "DC", "JJB", "FoT", "FiT", "WT", "ShT", "SpT", "Free"}

local function medallion_changed(medallion)
    local m = Tracker:FindObjectForCode(medallion)
    if m ~= nil then
        ---@cast m JsonItem
        m.BadgeText = " " .. text[m.CurrentStage + 1] .. " "
    end
end

local function on_hookshot_changed()
    local h = Tracker:FindObjectForCode("progressive_hookshot")
    if h ~= nil then
        ---@cast h JsonItem
        local h_text = ""
        if h.Active then
            if h.CurrentStage == 1 then
                h_text = "H"
            else
                h_text = "L"
            end
        end
        h.BadgeText = h_text
    end
end

local prog_items_init = {"weird_egg", "progressive_scale", "progressive_wallet", "child_masks"}
for _, item in ipairs(prog_items_init) do
    local obj = Tracker:FindObjectForCode(item)
    if obj ~= nil then
        obj.Active = true
    end
end

local medallions_stones = {
    "kokiris_emerald",
    "gorons_ruby",
    "zoras_sapphire",
    "forest_medallion",
    "fire_medallion",
    "water_medallion",
    "shadow_medallion",
    "spirit_medallion",
    "light_medallion"
}

local dungeon_label_to_text = {
    dungeon_label_DT = "DT",
    dungeon_label_DC = "DC",
    dungeon_label_JJB = "JJB",
    dungeon_label_FoT = "FoT",
    dungeon_label_FiT = "FiT",
    dungeon_label_WT = "WT",
    dungeon_label_ShT = "ShT",
    dungeon_label_SpT = "SpT",
    dungeon_label_BotW = "BotW",
    dungeon_label_GF = "GF",
    dungeon_label_GTG = "GTG",
    dungeon_label_GC = "GC"
}

local child_trade_affecting = {
    ["setting_complete_mask_quest"] = true,
    ["setting_skip_child_zelda"] = true,
    [Items.WEIRD_EGG] = true,
    [Items.KOKIRIS_EMERALD] = true,
    [Items.GORONS_RUBY] = true,
    [Items.ZORAS_SAPPHIRE] = true,
    [Items.SARIAS_SONG] = true,
    [Items.PROGRESSIVE_OCARINA] = true,
    [Items.PROGRESSIVE_WALLET] = true,
    [Items.MASK_SHOP_KEY] = true
}

local function on_child_trade_related_item_changed()
    --stateChanged runs first, no reason to call Invalidate and double call the most expensive function potentially
    SOH_COLLECTION_STATE:_soh_update_age_reachable_regions()
    local masks = Tracker:FindObjectForCode("child_masks")
    if masks == nil then
        return
    end
    ---@cast masks JsonItem
    if SOH_COLLECTION_STATE.event_items[Events.CAN_BORROW_MASK_OF_TRUTH] then
        masks.CurrentStage = 2
        masks.Active = true
    elseif SOH_COLLECTION_STATE.event_items[Events.CAN_BORROW_SKULL_MASK] then
        masks.CurrentStage = 1
        masks.Active = true
    else
        masks.CurrentStage = 0
        masks.Active = false
    end
end

local function init_overlay_text(code, initial_text, font_size)
    local obj = Tracker:FindObjectForCode(code)
    if obj ~= nil then
        ---@cast obj JsonItem
        obj:SetOverlayBackground("#000000")
        obj:SetOverlayFontSize(font_size or 12)
        obj.BadgeText = initial_text or ""
    end
end

for _, m in pairs(medallions_stones) do
    ScriptHost:AddWatchForCode(m .. " changed", m, medallion_changed)
    init_overlay_text(m)
    medallion_changed(m)
end

for dungeon_label_code, initial_text in pairs(dungeon_label_to_text) do
    init_overlay_text(dungeon_label_code, initial_text)
end

init_overlay_text("progressive_hookshot")

local function on_state_changed()
    SOH_COLLECTION_STATE:_soh_invalidate()
end

local function on_special_bottle_changed(bottle_code)
    --[[
    local obj = Tracker:FindObjectForCode(bottle_code)
    local total_bottles = Tracker:FindObjectForCode("empty_bottle")
    if obj == nil or total_bottles == nil then
        return
    end
    local add = -1
    if obj.Active then
        add = 1
    end
    total_bottles.AcquiredCount = total_bottles.AcquiredCount + add
    --]]
end

local function on_gerudo_card_related_changed()
    --AP world pushes precollected Gerudo card if it's not shuffled and carpenters are free, mimic that behavior
    local card_shuffled = SOH_COLLECTION_STATE.world:get_option("shuffle_gerudo_membership_card")
    local carpenters = SOH_COLLECTION_STATE.world:get_option("fortress_carpenters")
    if not card_shuffled and carpenters == Options.CARPENTERS_FREE then
        local obj = Tracker:FindObjectForCode("gerudo_membership_card")
        if obj ~= nil then
            ---@cast obj JsonItem
            obj.Active = true
        end
    end
end

local function on_show_checks_changed(code)
    local item = Tracker:FindObjectForCode(code)
    if item == nil then
        return
    end
    SETTING_SHOW_CHECKS = item.CurrentStage
end

ScriptHost:AddWatchForCode("state changed", "*", on_state_changed)
ScriptHost:AddWatchForCode("rutos letter changed", "bottle_with_rutos_letter", on_special_bottle_changed)
ScriptHost:AddWatchForCode("big poe changed", "bottle_with_big_poe", on_special_bottle_changed)
ScriptHost:AddWatchForCode("hookshot changed", "progressive_hookshot", on_hookshot_changed)
ScriptHost:AddWatchForCode("show checks changed", "setting_show_checks", on_show_checks_changed)
ScriptHost:AddWatchForCode("gerudo card shuffle changed", "setting_shuffle_gerudo_membership_card", on_gerudo_card_related_changed)
ScriptHost:AddWatchForCode("carpenter setting changed", "setting_fortress_carpenters", on_gerudo_card_related_changed)

for key, _ in pairs(child_trade_affecting) do
    ScriptHost:AddWatchForCode(key .. " for child trade changed", key, on_child_trade_related_item_changed)
end

world:_compute_child_adult_only_regions(SOH_COLLECTION_STATE)
