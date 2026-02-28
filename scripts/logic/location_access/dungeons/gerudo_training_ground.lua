


local function set_region_rules(world)
    --Gerudo Training Ground Entryway
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_ENTRYWAY, world, {
        {Regions.GERUDO_TRAINING_GROUND_LOBBY, function(bundle) return true end},
        {Regions.GF_EXITING_GTG, function(bundle) return true end},
    })

    --Gerudo Training Ground Lobby
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_LOBBY, world, {
        {Locations.GERUDO_TRAINING_GROUND_LOBBY_LEFT_CHEST,
         function(bundle) return LogicHelpers.can_hit_eye_targets(bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_LOBBY_RIGHT_CHEST,
         function(bundle) return LogicHelpers.can_hit_eye_targets(bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_STALFOS_CHEST,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 2, true) end},
        {Locations.GERUDO_TRAINING_GROUND_BEAMOS_CHEST,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.BEAMOS) and LogicHelpers.can_kill_enemy(bundle, Enemies.DINOLFOS,
                                                                                  EnemyDistance.CLOSE, true, 2, true) end},
        {Locations.GERUDO_TRAINING_GROUND_ENTRANCE_SONG_OF_STORMS_FAIRY,
         function(bundle) return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_BEAMOS_EAST_HEART, function(bundle) return true end},
        {Locations.GERUDO_TRAINING_GROUND_BEAMOS_SOUTH_HEART, function(bundle) return true end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_LOBBY, world, {
        {Regions.GERUDO_TRAINING_GROUND_ENTRYWAY, function(bundle) return true end},
        {Regions.GERUDO_TRAINING_GROUND_HEAVY_BLOCK_ROOM,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 2, true) and (
             LogicHelpers.can_use(Items.HOOKSHOT, bundle) or LogicHelpers.can_do_trick(Tricks.GTG_WITHOUT_HOOKSHOT, bundle)) end},
        {Regions.GERUDO_TRAINING_GROUND_LAVA_ROOM,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.BEAMOS) and LogicHelpers.can_kill_enemy(bundle, Enemies.DINOLFOS,
                                                                                  EnemyDistance.CLOSE, true, 2, true) end},
        {Regions.GERUDO_TRAINING_GROUND_CENTRAL_MAZE, function(bundle) return true end},
    })

    --Gerudo Training Ground Central Maze
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_CENTRAL_MAZE, world, {
        {Locations.GERUDO_TRAINING_GROUND_HIDDEN_CEILING_CHEST,
         function(bundle) return LogicHelpers.small_keys(Items.TRAINING_GROUND_SMALL_KEY, 3, bundle) and (
             LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) or LogicHelpers.can_do_trick(Tricks.LENS_GTG, bundle)) end},
        {Locations.GERUDO_TRAINING_GROUND_MAZE_PATH_FIRST_CHEST,
         function(bundle) return LogicHelpers.small_keys(Items.TRAINING_GROUND_SMALL_KEY, 4, bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_MAZE_PATH_SECOND_CHEST,
         function(bundle) return LogicHelpers.small_keys(Items.TRAINING_GROUND_SMALL_KEY, 6, bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_MAZE_PATH_THIRD_CHEST,
         function(bundle) return LogicHelpers.small_keys(Items.TRAINING_GROUND_SMALL_KEY, 7, bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_MAZE_PATH_FINAL_CHEST,
         function(bundle) return LogicHelpers.small_keys(Items.TRAINING_GROUND_SMALL_KEY, 9, bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_CENTRAL_MAZE, world, {
        {Regions.GERUDO_TRAINING_GROUND_CENTRAL_MAZE_RIGHT,
         function(bundle) return LogicHelpers.small_keys(Items.TRAINING_GROUND_SMALL_KEY, 9, bundle) end},
    })

    --Gerudo Training Ground Central Maze Right
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_CENTRAL_MAZE_RIGHT, world, {
        {Locations.GERUDO_TRAINING_GROUND_FREESTANDING_KEY, function(bundle) return true end},
        {Locations.GERUDO_TRAINING_GROUND_MAZE_RIGHT_SIDE_CHEST, function(bundle) return true end},
        {Locations.GERUDO_TRAINING_GROUND_MAZE_RIGHT_CENTRAL_CHEST, function(bundle) return true end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_CENTRAL_MAZE_RIGHT, world, {
        {Regions.GERUDO_TRAINING_GROUND_HAMMER_ROOM,
         function(bundle) return LogicHelpers.can_use(Items.HOOKSHOT, bundle) end},
        {Regions.GERUDO_TRAINING_GROUND_LAVA_ROOM, function(bundle) return true end},
    })

    --Gerudo Training Ground Lava Room
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_LAVA_ROOM, world, {
        {Locations.GERUDO_TRAINING_GROUND_UNDERWATER_SILVER_RUPEE_CHEST,
         function(bundle) return LogicHelpers.can_use(Items.HOOKSHOT, bundle) and LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) and LogicHelpers.can_use(
             Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 24 end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_LAVA_ROOM, world, {
        {Regions.GERUDO_TRAINING_GROUND_CENTRAL_MAZE_RIGHT,
         function(bundle) return LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or LogicHelpers.is_child(bundle) end},
        {Regions.GERUDO_TRAINING_GROUND_HAMMER_ROOM, function(bundle) return LogicHelpers.can_use(Items.LONGSHOT, bundle) or (
            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle)) end},
    })

    --Gerudo Training Ground Hammer Room
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_HAMMER_ROOM, world, {
        {Locations.GERUDO_TRAINING_GROUND_HAMMER_ROOM_CLEAR_CHEST,
         function(bundle) return LogicHelpers.can_attack(bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_HAMMER_ROOM_SWITCH_CHEST,
         function(bundle) return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) or (
             LogicHelpers.take_damage(bundle) and LogicHelpers.can_do_trick(Tricks.FLAMING_CHESTS, bundle)) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_HAMMER_ROOM, world, {
        {Regions.GERUDO_TRAINING_GROUND_EYE_STATUE_LOWER, function(bundle) return LogicHelpers.can_use(
            Items.MEGATON_HAMMER, bundle) and LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},
        {Regions.GERUDO_TRAINING_GROUND_LAVA_ROOM, function(bundle) return true end},
    })

    --Gerudo Training Ground Eye Statue Lower
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_EYE_STATUE_LOWER, world, {
        {Locations.GERUDO_TRAINING_GROUND_EYE_STATUE_CHEST,
         function(bundle) return LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_EYE_STATUE_LOWER, world, {
        {Regions.GERUDO_TRAINING_GROUND_HAMMER_ROOM, function(bundle) return true end},
    })

    --Gerudo Training Ground Eye Statue Upper
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_EYE_STATUE_UPPER, world, {
        {Locations.GERUDO_TRAINING_GROUND_NEAR_SCARECROW_CHEST,
         function(bundle) return LogicHelpers.can_use(Items.FAIRY_BOW, bundle) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_EYE_STATUE_UPPER, world, {
        {Regions.GERUDO_TRAINING_GROUND_EYE_STATUE_LOWER, function(bundle) return true end},
    })

    --Gerudo Training Ground Heavy Block Room
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_HEAVY_BLOCK_ROOM, world, {
        {Locations.GERUDO_TRAINING_GROUND_BEFORE_HEAVY_BLOCK_CHEST,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS, EnemyDistance.CLOSE, true, 4, true) end},
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GERUDO_TRAINING_GROUND_HEAVY_BLOCK_ROOM, world, {
        {Regions.GERUDO_TRAINING_GROUND_EYE_STATUE_UPPER,
         function(bundle) return (LogicHelpers.can_do_trick(Tricks.LENS_GTG, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)) and (
             LogicHelpers.can_use(Items.HOOKSHOT, bundle) or (
                 LogicHelpers.is_adult(bundle) and (
                     LogicHelpers.can_do_trick(Tricks.GTG_FAKE_WALL, bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))) or LogicHelpers.can_ground_jump(bundle)) end},
        {Regions.GERUDO_TRAINING_GROUND_LIKE_LIKE_ROOM,
         function(bundle) return (LogicHelpers.can_do_trick(Tricks.LENS_GTG, bundle) or LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)) and (
             LogicHelpers.can_use(Items.HOOKSHOT, bundle) or (
                 LogicHelpers.is_adult(bundle) and (
                     LogicHelpers.can_do_trick(Tricks.GTG_FAKE_WALL, bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) or LogicHelpers.can_ground_jump(bundle))) and LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) end},
    })

    --Gerudo Training Ground Like Like Room
    --Locations
   LogicHelpers.add_locations(Regions.GERUDO_TRAINING_GROUND_LIKE_LIKE_ROOM, world, {
        {Locations.GERUDO_TRAINING_GROUND_HEAVY_BLOCK_FIRST_CHEST,
         function(bundle) return LogicHelpers.can_jump_slash_except_hammer(bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_HEAVY_BLOCK_SECOND_CHEST,
         function(bundle) return LogicHelpers.can_jump_slash_except_hammer(bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_HEAVY_BLOCK_THIRD_CHEST,
         function(bundle) return LogicHelpers.can_jump_slash_except_hammer(bundle) end},
        {Locations.GERUDO_TRAINING_GROUND_HEAVY_BLOCK_FOURTH_CHEST,
         function(bundle) return LogicHelpers.can_jump_slash_except_hammer(bundle) end},
    })

    end

return set_region_rules