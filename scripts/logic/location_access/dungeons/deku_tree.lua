


local EventLocations = {
    DEKU_TREE_LOBBY_BABA_STICKS = "Deku Tree Lobby Baba Sticks",
    DEKU_TREE_LOBBY_BABA_NUTS = "Deku Tree Lobby Baba Nuts",
    DEKU_TREE_COMPASS_BABA_STICKS = "Deku Tree Compass Room Baba Sticks",
    DEKU_TREE_COMPASS_BABA_NUTS = "Deku Tree Compass Room Baba Nuts",
    DEKU_TREE_BASEMENT_LOWER_BABA_STICKS = "Deku Tree Basement Lower Baba Sticks",
    DEKU_TREE_BASEMENT_LOWER_BABA_NUTS = "Deku Tree Basement Lower Baba Nuts",
    DEKU_TREE_BASEMENT_TORCH_ROOM_BABA_STICKS = "Deku Tree Basement Torch Room Baba Sticks",
    DEKU_TREE_BASEMENT_TORCH_ROOM_BABA_NUTS = "Deku Tree Torch Room Baba Nuts",
    DEKU_TREE_BASEMENT_BACK_LOBBY_BABA_STICKS = "Deku Tree Basement Back Lobby Baba Sticks",
    DEKU_TREE_BASEMENT_BACK_LOBBY_BABA_NUTS = "Deku Tree Basement Back Lobby Baba Nuts",
    DEKU_TREE_BASEMENT_UPPER_BABA_STICKS = "Deku Tree Basement Upper Baba Sticks",
    DEKU_TREE_BASEMENT_UPPER_BABA_NUTS = "Deku Tree Basement Upper Baba Nuts",
    DEKU_TREE_BASEMENT_UPPER_BLOCK = "Deku Tree Basement Upper Push Block",
    DEKU_TREE_QUEEN_GOHMA = "Deku Tree Queen Gohma",
}


local LocalEvents = {
    DEKU_TREE_BASEMENT_UPPER_BLOCK_PUSHED = "Deku Tree Basement Upper Block Pushed"
}

local function set_region_rules(world)
    --Deku Tree Entryway
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_ENTRYWAY, world, {
        {Regions.DEKU_TREE_LOBBY, function(bundle) return true end},
        {Regions.KF_OUTSIDE_DEKU_TREE, function(bundle) return true end},
    })

    --Deku Lobby
    --Events
    LogicHelpers.add_events(Regions.DEKU_TREE_LOBBY, world, {
        {EventLocations.DEKU_TREE_LOBBY_BABA_STICKS, Events.CAN_FARM_STICKS,
         function(bundle) return LogicHelpers.can_get_deku_baba_sticks(bundle) end},
        {EventLocations.DEKU_TREE_LOBBY_BABA_NUTS, Events.CAN_FARM_NUTS,
         function(bundle) return LogicHelpers.can_get_deku_baba_nuts(bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_LOBBY, world, {
        {Locations.DEKU_TREE_MAP_CHEST, function(bundle) return true end},
        {Locations.DEKU_TREE_LOBBY_LOWER_HEART, function(bundle) return true end},
        {Locations.DEKU_TREE_LOBBY_UPPER_HEART,
         function(bundle) return LogicHelpers.can_pass_enemy(bundle, Enemies.BIG_SKULLTULA) end},
        {Locations.DEKU_TREE_LOBBY_GRASS1, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_LOBBY_GRASS2, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_LOBBY_GRASS3, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_LOBBY_GRASS4, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_LOBBY_GRASS5, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_LOBBY, world, {
        {Regions.DEKU_TREE_ENTRYWAY, function(bundle) return true end},
        {Regions.DEKU_TREE_2F_MIDDLE_ROOM, function(bundle) return true end},
        {Regions.DEKU_TREE_COMPASS_ROOM, function(bundle) return true end},
        {Regions.DEKU_TREE_BASEMENT_LOWER, function(bundle) return LogicHelpers.can_attack(
            bundle) or LogicHelpers.can_use(Items.NUTS, bundle) end},
    })

    --Deku F2 middle room
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_2F_MIDDLE_ROOM, world, {
        {Regions.DEKU_TREE_LOBBY, function(bundle) return LogicHelpers.can_reflect_nuts(
            bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) end},
        {Regions.DEKU_TREE_SLINGSHOT_ROOM, function(bundle) return LogicHelpers.can_reflect_nuts(
            bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) end},
    })

    --Deku slingshot room
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_SLINGSHOT_ROOM, world, {
        {Locations.DEKU_TREE_SLINGSHOT_CHEST, function(bundle) return true end},
        {Locations.DEKU_TREE_SLINGSHOT_ROOM_SIDE_CHEST, function(bundle) return true end},
        {Locations.DEKU_TREE_SLINGSHOT_GRASS1, function(bundle) return LogicHelpers.can_cut_shrubs(
            bundle) and LogicHelpers.can_reflect_nuts(bundle) end},
        {Locations.DEKU_TREE_SLINGSHOT_GRASS2, function(bundle) return LogicHelpers.can_cut_shrubs(
            bundle) and LogicHelpers.can_reflect_nuts(bundle) end},
        {Locations.DEKU_TREE_SLINGSHOT_GRASS3, function(bundle) return LogicHelpers.can_cut_shrubs(
            bundle) and LogicHelpers.can_reflect_nuts(bundle) end},
        {Locations.DEKU_TREE_SLINGSHOT_GRASS4, function(bundle) return LogicHelpers.can_cut_shrubs(
            bundle) and LogicHelpers.can_reflect_nuts(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_SLINGSHOT_ROOM, world, {
        {Regions.DEKU_TREE_2F_MIDDLE_ROOM, function(bundle) return LogicHelpers.can_use(
            Items.FAIRY_SLINGSHOT, bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) end},
    })

    --Deku compass room
    --Events
    LogicHelpers.add_events(Regions.DEKU_TREE_COMPASS_ROOM, world, {
        {EventLocations.DEKU_TREE_COMPASS_BABA_STICKS, Events.CAN_FARM_STICKS,
         function(bundle) return LogicHelpers.can_get_deku_baba_sticks(bundle) end},
        {EventLocations.DEKU_TREE_COMPASS_BABA_NUTS, Events.CAN_FARM_NUTS,
         function(bundle) return LogicHelpers.can_get_deku_baba_nuts(bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_COMPASS_ROOM, world, {
        {Locations.DEKU_TREE_COMPASS_CHEST, function(bundle) return true end},
        {Locations.DEKU_TREE_COMPASS_ROOM_SIDE_CHEST, function(bundle) return true end},
        {Locations.DEKU_TREE_GS_COMPASS_ROOM,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA) end},
        {Locations.DEKU_TREE_COMPASS_GRASS1, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_COMPASS_GRASS2, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_COMPASS_ROOM, world, {
        {Regions.DEKU_TREE_LOBBY, function(bundle) return LogicHelpers.has_fire_source_with_torch(bundle) end},
    })

    --Deku Basement Lower
    --Events
    LogicHelpers.add_events(Regions.DEKU_TREE_BASEMENT_LOWER, world, {
        {EventLocations.DEKU_TREE_BASEMENT_LOWER_BABA_STICKS,
         Events.CAN_FARM_STICKS, function(bundle) return LogicHelpers.can_get_deku_baba_sticks(bundle) end},
        {EventLocations.DEKU_TREE_BASEMENT_LOWER_BABA_NUTS,
         Events.CAN_FARM_NUTS, function(bundle) return LogicHelpers.can_get_deku_baba_nuts(bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_BASEMENT_LOWER, world, {
        {Locations.DEKU_TREE_BASEMENT_CHEST, function(bundle) return true end},
        {Locations.DEKU_TREE_GS_BASEMENT_GATE, function(bundle) return LogicHelpers.can_kill_enemy(
            bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.SHORT_JUMPSLASH) end},
        {Locations.DEKU_TREE_GS_BASEMENT_VINES, function(bundle) return LogicHelpers.can_kill_enemy(
            bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.SHORT_JUMPSLASH) end},
        {Locations.DEKU_TREE_BASEMENT_GRASS1,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_BASEMENT_GRASS2,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_LOWER, world, {
        {Regions.DEKU_TREE_LOBBY, function(bundle) return true end},
        {Regions.DEKU_TREE_BASEMENT_SCRUB_ROOM, function(bundle) return LogicHelpers.has_fire_source_with_torch(
            bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},
        {Regions.DEKU_TREE_BASEMENT_UPPER, function(bundle) return LogicHelpers.is_adult(bundle) or LogicHelpers.can_do_trick(Tricks.DEKU_B1_SKIP, bundle)
            or LogicHelpers.has_item(LocalEvents.DEKU_TREE_BASEMENT_UPPER_BLOCK_PUSHED, bundle) or LogicHelpers.can_ground_jump(bundle) end},
    })

    --Deku basement shrub room
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_BASEMENT_SCRUB_ROOM, world, {
        {Locations.DEKU_TREE_EYE_SWITCH_GRASS1,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_EYE_SWITCH_GRASS2,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_EYE_SWITCH_GRASS3,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_EYE_SWITCH_GRASS4,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_SCRUB_ROOM, world, {
        {Regions.DEKU_TREE_BASEMENT_LOWER, function(bundle) return true end},
        {Regions.DEKU_TREE_BASEMENT_WATER_ROOM_FRONT,
         function(bundle) return LogicHelpers.can_hit_eye_targets(bundle) end},
    })

    --Deku basement water room front
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_WATER_ROOM_FRONT, world, {
        {Regions.DEKU_TREE_BASEMENT_SCRUB_ROOM, function(bundle) return true end},
        {Regions.DEKU_TREE_BASEMENT_WATER_ROOM_BACK, function(bundle) return LogicHelpers.has_item(
            Items.BRONZE_SCALE, bundle) or LogicHelpers.can_do_trick(Tricks.DEKU_B1_BACKFLIP_OVER_SPIKED_LOG, bundle) end},
    })

    --Deku basement water room back
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_BASEMENT_WATER_ROOM_BACK, world, {
        {Locations.DEKU_TREE_SPIKE_ROLLER_GRASS1,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_SPIKE_ROLLER_GRASS2,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_WATER_ROOM_BACK, world, {
        {Regions.DEKU_TREE_BASEMENT_WATER_ROOM_FRONT, function(bundle) return LogicHelpers.has_item(
            Items.BRONZE_SCALE, bundle) or LogicHelpers.can_do_trick(Tricks.DEKU_B1_BACKFLIP_OVER_SPIKED_LOG, bundle) end},
        {Regions.DEKU_TREE_BASEMENT_TORCH_ROOM, function(bundle) return true end},
    })

    --Deku tree basement torch room
    --Events
    LogicHelpers.add_events(Regions.DEKU_TREE_BASEMENT_TORCH_ROOM, world, {
        {EventLocations.DEKU_TREE_BASEMENT_TORCH_ROOM_BABA_STICKS,
         Events.CAN_FARM_STICKS, function(bundle) return LogicHelpers.can_get_deku_baba_sticks(bundle) end},
        {EventLocations.DEKU_TREE_BASEMENT_TORCH_ROOM_BABA_NUTS,
         Events.CAN_FARM_NUTS, function(bundle) return LogicHelpers.can_get_deku_baba_nuts(bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_BASEMENT_TORCH_ROOM, world, {
        {Locations.DEKU_TREE_TORCHES_GRASS1, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_TORCHES_GRASS2, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_TORCH_ROOM, world, {
        {Regions.DEKU_TREE_BASEMENT_WATER_ROOM_BACK, function(bundle) return LogicHelpers.has_fire_source_with_torch(
            bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},
        {Regions.DEKU_TREE_BASEMENT_BACK_LOBBY, function(bundle) return LogicHelpers.has_fire_source_with_torch(
            bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},
    })

    --Deku basement back lobby
    --Events
    LogicHelpers.add_events(Regions.DEKU_TREE_BASEMENT_BACK_LOBBY, world, {
        {EventLocations.DEKU_TREE_BASEMENT_BACK_LOBBY_BABA_STICKS,
         Events.CAN_FARM_STICKS, function(bundle) return LogicHelpers.can_get_deku_baba_sticks(bundle) end},
        {EventLocations.DEKU_TREE_BASEMENT_BACK_LOBBY_BABA_NUTS,
         Events.CAN_FARM_NUTS, function(bundle) return LogicHelpers.can_get_deku_baba_nuts(bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_BASEMENT_BACK_LOBBY, world, {
        {Locations.DEKU_TREE_LARVAE_GRASS1, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_LARVAE_GRASS2, function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_BACK_LOBBY, world, {
        {Regions.DEKU_TREE_BASEMENT_TORCH_ROOM, function(bundle) return true end},
        {Regions.DEKU_TREE_BASEMENT_BACK_ROOM, function(bundle) return (
            LogicHelpers.has_fire_source_with_torch(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle))  end},
        {Regions.DEKU_TREE_BASEMENT_UPPER, function(bundle) return (
            LogicHelpers.has_fire_source_with_torch(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle))  end},
    })

    --Deku basement back room
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_BASEMENT_BACK_ROOM, world, {
        {Locations.DEKU_TREE_GS_BASEMENT_BACK_ROOM,
         function(bundle) return LogicHelpers.hookshot_or_boomerang(bundle) end},

    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_BACK_ROOM, world, {
        {Regions.DEKU_TREE_BASEMENT_BACK_LOBBY, function(bundle) return true end},
    })

    --Deku basement upper
    --Events
    LogicHelpers.add_events(Regions.DEKU_TREE_BASEMENT_UPPER, world, {
        {EventLocations.DEKU_TREE_BASEMENT_UPPER_BABA_STICKS,
         Events.CAN_FARM_STICKS, function(bundle) return LogicHelpers.can_get_deku_baba_sticks(bundle) end},
        {EventLocations.DEKU_TREE_BASEMENT_UPPER_BABA_NUTS,
         Events.CAN_FARM_NUTS, function(bundle) return LogicHelpers.can_get_deku_baba_nuts(bundle) end},
        {EventLocations.DEKU_TREE_BASEMENT_UPPER_BLOCK,
         LocalEvents.DEKU_TREE_BASEMENT_UPPER_BLOCK_PUSHED, function(bundle) return true end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BASEMENT_UPPER, world, {
        {Regions.DEKU_TREE_BASEMENT_LOWER, function(bundle) return true end},
        {Regions.DEKU_TREE_BASEMENT_BACK_LOBBY, function(bundle) return LogicHelpers.is_child(bundle) end},
        {Regions.DEKU_TREE_OUTSIDE_BOSS_ROOM, function(bundle) return LogicHelpers.has_fire_source_with_torch(bundle) or
        (LogicHelpers.can_do_trick(Tricks.DEKU_B1_BOW_WEBS, bundle) and LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.FAIRY_BOW, bundle)) end}
    })

    --Deku outside boss room
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_OUTSIDE_BOSS_ROOM, world, {
        {Locations.DEKU_TREE_FINAL_ROOM_LEFT_FRONT_HEART, function(bundle) return LogicHelpers.has_item(Items.BRONZE_SCALE,
         bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) end},
        {Locations.DEKU_TREE_FINAL_ROOM_LEFT_BACK_HEART, function(bundle) return LogicHelpers.has_item(Items.BRONZE_SCALE,
         bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) end},
        {Locations.DEKU_TREE_FINAL_ROOM_RIGHT_HEART, function(bundle) return LogicHelpers.has_item(Items.BRONZE_SCALE,
         bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) end},
        {Locations.DEKU_TREE_BEFORE_BOSS_GRASS1, function(bundle) return LogicHelpers.can_cut_shrubs(
            bundle) and LogicHelpers.has_fire_source_with_torch(bundle) end},
        {Locations.DEKU_TREE_BEFORE_BOSS_GRASS2, function(bundle) return LogicHelpers.can_cut_shrubs(
            bundle) and LogicHelpers.has_fire_source_with_torch(bundle) end},
        {Locations.DEKU_TREE_BEFORE_BOSS_GRASS3, function(bundle) return LogicHelpers.can_cut_shrubs(
            bundle) and LogicHelpers.has_fire_source_with_torch(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_OUTSIDE_BOSS_ROOM, world, {
        {Regions.DEKU_TREE_BASEMENT_UPPER, function(bundle) return true end},
        {Regions.DEKU_TREE_BOSS_ENTRYWAY, function(bundle) return (LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
            and LogicHelpers.can_reflect_nuts(bundle) end},
    })

    --Skipping master quest for now

    --Deku Boss room entryway
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BOSS_ENTRYWAY, world, {
        {Regions.DEKU_TREE_BOSS_ROOM, function(bundle) return true end},
    })

    --Deku boss exit
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BOSS_EXIT, world, {
        {Regions.DEKU_TREE_OUTSIDE_BOSS_ROOM, function(bundle) return true end},
        --skipping mq connection
    })

    --Deku Tree boss room
    --Events
    LogicHelpers.add_events(Regions.DEKU_TREE_BOSS_ROOM, world, {
        {EventLocations.DEKU_TREE_QUEEN_GOHMA, Events.DEKU_TREE_COMPLETED,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.GOHMA) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.DEKU_TREE_BOSS_ROOM, world, {
        {Locations.QUEEN_GOHMA, function(bundle) return LogicHelpers.has_item(
            Events.DEKU_TREE_COMPLETED, bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_HEART_CONTAINER,
         function(bundle) return LogicHelpers.has_item(Events.DEKU_TREE_COMPLETED, bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS1,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS2,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS3,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS4,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS5,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS6,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS7,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
        {Locations.DEKU_TREE_QUEEN_GOHMA_GRASS8,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.DEKU_TREE_BOSS_ROOM, world, {
        {Regions.DEKU_TREE_BOSS_EXIT, function(bundle) return true end},
        {Regions.KF_OUTSIDE_DEKU_TREE, function(bundle) return LogicHelpers.has_item(
            Events.DEKU_TREE_COMPLETED, bundle) end},
    })

end

return set_region_rules
