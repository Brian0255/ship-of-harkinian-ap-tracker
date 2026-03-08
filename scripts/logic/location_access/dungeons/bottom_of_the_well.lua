


local EventLocations = {
    BOTTOM_OF_THE_WELL_LOWERED_WATER = "Bottom of the Well Lowered Water",
    BOTTOM_OF_THE_WELL_NUT_POT = "Bottom of the Well Nut Pot",
    BOTTOM_OF_THE_WELL_STICK_POT = "Bottom of the Well Stick Pot",
    BOTTOM_OF_THE_WELL_BABAS_STICKS = "Bottom of the Well Deku Baba Sticks",
    BOTTOM_OF_THE_WELL_BABAS_NUTS = "Bottom of the Well Deku Baba Nuts"
}


local LocalEvents = {
    LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL = "Water was lowered in the Bottom of the Well"
}

local function set_region_rules(world)
    --Bottom of The Well Entryway
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_ENTRYWAY, world, {})
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_ENTRYWAY, world, {
        --Technically involves an fake wall, but passing it lensless is intended in vanilla and it is well telegraphed
        {Regions.BOTTOM_OF_THE_WELL_PERIMETER, function(bundle) return LogicHelpers.is_child(
            bundle) and LogicHelpers.can_pass_enemy(bundle, Enemies.BIG_SKULLTULA) end},
        --[Regions.BOTTOM_OF_THE_WELL_MQ_PERIMETER, function(bundle) return LogicHelpers.is_child(bundle),
        {Regions.KAK_WELL, function(bundle) return true end},
    })

    --Bottom of the Well Perimeter
    --Events
    LogicHelpers.add_events(Regions.BOTTOM_OF_THE_WELL_PERIMETER, world, {
        {EventLocations.BOTTOM_OF_THE_WELL_STICK_POT,
         Events.CAN_FARM_STICKS, function(bundle) return true end},
        {EventLocations.BOTTOM_OF_THE_WELL_NUT_POT,
         Events.CAN_FARM_NUTS, function(bundle) return true end},
        {EventLocations.BOTTOM_OF_THE_WELL_LOWERED_WATER, LocalEvents.LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL,
         function(bundle) return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_PERIMETER, world, {
        {Locations.BOTTOM_OF_THE_WELL_FRONT_CENTER_BOMBABLE_CHEST,
         function(bundle) return LogicHelpers.has_explosives(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_UNDERWATER_FRONT_CHEST, function(bundle) return LogicHelpers.has_item(
            LocalEvents.LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL, bundle) or LogicHelpers.can_open_underwater_chest(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_UNDERWATER_LEFT_CHEST, function(bundle) return LogicHelpers.has_item(
            LocalEvents.LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL, bundle) or LogicHelpers.can_open_underwater_chest(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_NEAR_ENTRANCE_POT1,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_NEAR_ENTRANCE_POT2,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_UNDERWATER_POT, function(bundle) return  (LogicHelpers.can_break_pots(bundle) and LogicHelpers.has_item(
            LocalEvents.LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL, bundle)) or LogicHelpers.can_use(Items.BOOMERANG, bundle)  end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_PERIMETER, world, {
        {Regions.BOTTOM_OF_THE_WELL_ENTRYWAY, function(bundle) return LogicHelpers.is_child(
            bundle) and LogicHelpers.can_pass_enemy(bundle, Enemies.BIG_SKULLTULA) end},
        {Regions.BOTTOM_OF_THE_WELL_BEHIND_FAKE_WALLS, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_SOUTHWEST_ROOM, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_KEESE_BEAMOS_ROOM, function(bundle) return LogicHelpers.is_child(
            bundle) and LogicHelpers.small_keys(Items.BOTTOM_OF_THE_WELL_SMALL_KEY, 3, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_COFFIN_ROOM, function(bundle) return LogicHelpers.has_item(
            LocalEvents.LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL, bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_DEAD_HAND_ROOM, function(bundle) return LogicHelpers.has_item(
            LocalEvents.LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL, bundle) and LogicHelpers.is_child(bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_BASEMENT, function(bundle) return true  end},
    })

    --Bottom of the Well Behind Fake Walls
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_BEHIND_FAKE_WALLS, world, {
        {Locations.BOTTOM_OF_THE_WELL_FRONT_LEFT_FAKE_WALL_CHEST, function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_RIGHT_BOTTOM_FAKE_WALL_CHEST, function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_COMPASS_CHEST, function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_CENTER_SKULLTULA_CHEST, function(bundle) return LogicHelpers.can_pass_enemy(
            bundle, Enemies.BIG_SKULLTULA) or LogicHelpers.take_damage(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BACK_LEFT_BOMBABLE_CHEST,
         function(bundle) return LogicHelpers.has_explosives(bundle)  end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_BEHIND_FAKE_WALLS, world, {
        {Regions.BOTTOM_OF_THE_WELL_PERIMETER, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_INNER_ROOMS, function(bundle) return LogicHelpers.small_keys(
            Items.BOTTOM_OF_THE_WELL_SMALL_KEY, 3, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_BASEMENT, function(bundle) return true end},
        {Regions.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
    })

    --Bottom of the Well Southwest Room
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_SOUTHWEST_ROOM, world, {
        {Locations.BOTTOM_OF_THE_WELL_LEFT_SIDE_POT1,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_LEFT_SIDE_POT2,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_LEFT_SIDE_POT3,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_SOUTHWEST_ROOM, world, {
        {Regions.BOTTOM_OF_THE_WELL_PERIMETER, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
    })

    --Bottom of the Well Keese-Beamos Room
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_KEESE_BEAMOS_ROOM, world, {
        {Locations.BOTTOM_OF_THE_WELL_FIRE_KEESE_CHEST, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_FIRE_KEESE_POT1, function(bundle) return LogicHelpers.can_break_pots(bundle)
         and LogicHelpers.can_do_trick(Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_KEESE_BEAMOS_ROOM, world, {
        {Regions.BOTTOM_OF_THE_WELL_PERIMETER, function(bundle) return LogicHelpers.is_child(bundle) and LogicHelpers.small_keys(Items.BOTTOM_OF_THE_WELL_SMALL_KEY,
         3, bundle) and LogicHelpers.can_do_trick(Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_LIKE_LIKE_CAGE, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
        {Regions.BOTTOM_OF_THE_WELL_BASEMENT_USEFUL_BOMB_FLOWERS, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
    })

    --Bottom of the Well Like-Like Cage
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_LIKE_LIKE_CAGE, world, {
        {Locations.BOTTOM_OF_THE_WELL_LIKE_LIKE_CHEST, function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_GS_LIKE_LIKE_CAGE, function(bundle) return LogicHelpers.can_get_enemy_drop(
            bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_LIKE_LIKE_CAGE, world, {
        {Regions.BOTTOM_OF_THE_WELL_KEESE_BEAMOS_ROOM, function(bundle) return true end},
    })

    --Bottom of the Well Inner Rooms
    --Events
    LogicHelpers.add_events(Regions.BOTTOM_OF_THE_WELL_INNER_ROOMS, world, {
        {EventLocations.BOTTOM_OF_THE_WELL_BABAS_STICKS, Events.CAN_FARM_STICKS,
         function(bundle) return LogicHelpers.can_get_deku_baba_sticks(bundle) end},
        {EventLocations.BOTTOM_OF_THE_WELL_BABAS_NUTS, Events.CAN_FARM_NUTS,
         function(bundle) return LogicHelpers.can_get_deku_baba_nuts(bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_INNER_ROOMS, world, {
        {Locations.BOTTOM_OF_THE_WELL_GS_WEST_INNER_ROOM, function(bundle) return LogicHelpers.can_get_enemy_drop(
            bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG) end},
        {Locations.BOTTOM_OF_THE_WELL_GS_EAST_INNER_ROOM, function(bundle) return LogicHelpers.can_get_enemy_drop(
            bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_INNER_ROOMS, world, {
        {Regions.BOTTOM_OF_THE_WELL_BEHIND_FAKE_WALLS, function(bundle) return LogicHelpers.small_keys(
            Items.BOTTOM_OF_THE_WELL_SMALL_KEY, 3, bundle) end},
    })

    --Bottom of the Well Coffin Room
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_COFFIN_ROOM, world, {
        {Locations.BOTTOM_OF_THE_WELL_FREESTANDING_KEY, function(bundle) return LogicHelpers.has_fire_source_with_torch(
            bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_COFFIN_ROOM_FRONT_LEFT_HEART, function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_COFFIN_ROOM_MIDDLE_RIGHT_HEART,
         function(bundle) return LogicHelpers.has_fire_source_with_torch(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},

    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_COFFIN_ROOM, world, {
        {Regions.BOTTOM_OF_THE_WELL_PERIMETER, function(bundle) return LogicHelpers.has_item(
            LocalEvents.LOWERED_WATER_INSIDE_BOTTOM_OF_THE_WELL, bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) end},
    })

    --Bottom of the Well Dead Hand Room
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_DEAD_HAND_ROOM, world, {
        {Locations.BOTTOM_OF_THE_WELL_LENS_OF_TRUTH_CHEST,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.DEAD_HAND) end},
        {Locations.BOTTOM_OF_THE_WELL_INVISIBLE_CHEST, function(bundle) return LogicHelpers.can_do_trick(
            Tricks.LENS_BOTW, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_DEAD_HAND_ROOM, world, {
        {Regions.BOTTOM_OF_THE_WELL_PERIMETER, function(bundle) return LogicHelpers.is_child(
            bundle) and LogicHelpers.can_kill_enemy(bundle, Enemies.DEAD_HAND) end},
    })

    --Bottom of the Well Basement
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_BASEMENT, world, {
        {Locations.BOTTOM_OF_THE_WELL_MAP_CHEST,
         function(bundle) return LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT1,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT2,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT3,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT4,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT5,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT6,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT7,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT8,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT9,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT10,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT11,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_POT12,
         function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_SUNS_SONG_FAIRY,
         function(bundle) return LogicHelpers.can_use(Items.SUNS_SONG, bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_GRASS1,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_GRASS2,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_GRASS3,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS1,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS2,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS3,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS4,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS5,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS6,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS7,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS8,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_BEHIND_ROCKS_GRASS9,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) and LogicHelpers.blast_or_smash(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_BASEMENT, world, {
        {Regions.BOTTOM_OF_THE_WELL_SOUTHWEST_ROOM, function(bundle) return LogicHelpers.is_child(
            bundle) and LogicHelpers.can_pass_enemy(bundle, Enemies.BIG_SKULLTULA) end},
        {Regions.BOTTOM_OF_THE_WELL_BASEMENT_USEFUL_BOMB_FLOWERS, function(bundle) return LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(
            Items.DINS_FIRE, bundle) or (LogicHelpers.can_use(Items.STICKS, bundle) and LogicHelpers.can_do_trick(Tricks.BOTW_BASEMENT, bundle)) end},
    })

    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_BASEMENT_USEFUL_BOMB_FLOWERS, world, {
        {Regions.BOTTOM_OF_THE_WELL_BASEMENT,
         function(bundle) return LogicHelpers.can_detonate_upright_bomb_flower(bundle) end},
    })

    --Bottom of the Well Basement Platform
    --Locations
   LogicHelpers.add_locations(Regions.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM, world, {
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM_LEFT_RUPEE, function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM_BACK_LEFT_RUPEE,
         function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM_MIDDLE_RUPEE, function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM_BACK_RIGHT_RUPEE,
         function(bundle) return true end},
        {Locations.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM_RIGHT_RUPEE, function(bundle) return true end},

    })
    --Connections
   LogicHelpers.connect_regions(Regions.BOTTOM_OF_THE_WELL_BASEMENT_PLATFORM, world, {
        {Regions.BOTTOM_OF_THE_WELL_BASEMENT, function(bundle) return true end},
    })
end

return set_region_rules