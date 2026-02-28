local Region = require("scripts/logic/base_classes/region")

local SoHRegion = {}
SoHRegion.__index = SoHRegion

setmetatable(
    SoHRegion,
    {
        __index = Region,
        __call = function(cls, ...)
            return cls.new(...)
        end
    }
)


function SoHRegion.new(name, world, entrances, exits, locations)
    local self = setmetatable(Region(name, world, entrances, exits, locations), SoHRegion)
    return self
end

-- override
function SoHRegion:can_reach(state)

    if state._soh_stale then
        local stored_age = state._soh_age
        state:_soh_update_age_reachable_regions()
        state._soh_age = stored_age
    end
    if state._soh_age == "child" then
        return state._soh_child_reachable_regions[self] or false
    elseif state._soh_age == "adult" then
        return state._soh_adult_reachable_regions[self] or false
    else
        return state._soh_child_reachable_regions[self] or state._soh_adult_reachable_regions[self] or false
    end
end

function SoHRegion:create_regions_and_locations(world)
    local region_data_table = {}
    for _, entry in pairs(Regions) do
        region_data_table[entry] = {connecting_regions = {}}
    end

    for region_name, data in pairs(region_data_table) do
        local region = SoHRegion(region_name, world)
        world.regions:append(region)
        region:add_exits(data.connecting_regions)
    end

    local region_module_paths = {
        "root",
        "overworld/kokiri_forest",
        "overworld/castle_grounds",
        "overworld/death_mountain_crater",
        "overworld/death_mountain_trail",
        "overworld/desert_colossus",
        "overworld/gerudo_fortress",
        "overworld/gerudo_valley",
        "overworld/goron_city",
        "overworld/graveyard",
        "overworld/haunted_wasteland",
        "overworld/hyrule_field",
        "overworld/kakariko",
        "overworld/lake_hylia",
        "overworld/lon_lon_ranch",
        "overworld/lost_woods",
        "overworld/market",
        "overworld/sacred_forest_meadow",
        "overworld/temple_of_time",
        "overworld/thieves_hideout",
        "overworld/zoras_domain",
        "overworld/zoras_fountain",
        "overworld/zoras_river",
        "dungeons/bottom_of_the_well",
        "dungeons/deku_tree",
        "dungeons/dodongos_cavern",
        "dungeons/fire_temple",
        "dungeons/forest_temple",
        "dungeons/ganons_castle",
        "dungeons/gerudo_training_ground",
        "dungeons/ice_cavern",
        "dungeons/water_temple",
        "dungeons/jabujabus_belly",
        "dungeons/shadow_temple",
        "dungeons/spirit_temple"
    }

    for _, region_module_path in pairs(region_module_paths) do
        local set_region_rules = require(string.format("scripts/logic/location_access/%s", region_module_path))
        set_region_rules(world)
    end
end

return SoHRegion
