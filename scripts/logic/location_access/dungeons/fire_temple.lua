local EventLocations = {
    FIRE_TEMPLE_NEAR_BOSS_ROOM_FAIRY_POT = "Fire Temple Near Boss Room Fairy Pot",
    FIRE_TEMPLE_LOOP_HAMMER_SWITCH_ROOM_SWITCH = "Fire Temple Loop Hammer Switch Room Switch",
    FIRE_TEMPLE_FIRE_MAZE_UPPER_PLATFORM = "Fire Temple Fire Maze Upper Platform",
    FIRE_TEMPLE_VOLVAGIA = "Fire Temple Volvagia",
    FIRE_TEMPLE_SHORTCUT_SWITCH = "Fire Temple Shortcut Switch"
}

local LocalEvents = {
    FIRE_TEMPLE_LOOP_HAMMER_SWITCH_HIT = "Fire Temple Loop Hammer Switch Hit",
    FIRE_TEMPLE_FIRE_MAZE_UPPER_PLATFORM_HIT = "Fire Temple Fire Maze Upper Platform Hit",
    FIRE_TEMPLE_SHORTCUT_SWITCH_HIT = "Fire Temple Shortcut Switch Hit"
}

local function set_region_rules(world)
    --Fire Temple Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_ENTRYWAY,
        world,
        {
            {Regions.FIRE_TEMPLE_FIRST_ROOM, function(bundle)
                    return true
                end},
            {Regions.DMC_CENTRAL_LOCAL, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple First Room
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_FIRST_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_ENTRYWAY, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_NEAR_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 24
                end
            },
            {
                Regions.FIRE_TEMPLE_LOOP_ENEMIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) and
                        (LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 8, bundle) or not LogicHelpers.is_fire_loop_locked(bundle)))
                end
            },
            {Regions.FIRE_TEMPLE_LOOP_EXIT, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_BIG_LAVA_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 2, bundle) and
                        LogicHelpers.fire_timer(bundle) >= 24
                end
            }
        }
    )

    --Fire Temple Near Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.FIRE_TEMPLE_NEAR_BOSS_ROOM,
        world,
        {
            {
                EventLocations.FIRE_TEMPLE_NEAR_BOSS_ROOM_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_NEAR_BOSS_ROOM,
        world,
        {
            {Locations.FIRE_TEMPLE_NEAR_BOSS_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.FIRE_TEMPLE_NEAR_BOSS_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            },
            {
                Locations.FIRE_TEMPLE_NEAR_BOSS_POT2,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            },
            {
                Locations.FIRE_TEMPLE_NEAR_BOSS_POT3,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            },
            {
                Locations.FIRE_TEMPLE_NEAR_BOSS_POT4,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_NEAR_BOSS_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_FIRST_ROOM, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_BOSS_ENTRYWAY,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_do_trick(Tricks.FIRE_BOSS_DOOR_JUMP, bundle) or
                            LogicHelpers.has_item(LocalEvents.FIRE_TEMPLE_FIRE_MAZE_UPPER_PLATFORM_HIT, bundle) or
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)))
                end
            }
        }
    )

    --Fire Temple Loop Enemies
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_LOOP_ENEMIES,
        world,
        {
            {
                Regions.FIRE_TEMPLE_FIRST_ROOM,
                function(bundle)
                    return (LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 8, bundle) or
                        not LogicHelpers.is_fire_loop_locked(bundle))
                end
            },
            {
                Regions.FIRE_TEMPLE_LOOP_TILES,
                function(bundle)
                    return (LogicHelpers.can_kill_enemy(bundle, Enemies.TORCH_SLUG) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.FIRE_KEESE))
                end
            }
        }
    )

    --Fire Temple Loop Tiles
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_LOOP_TILES,
        world,
        {
            {Locations.FIRE_TEMPLE_GS_BOSS_KEY_LOOP, function(bundle)
                    return LogicHelpers.can_attack(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_LOOP_TILES,
        world,
        {
            {Regions.FIRE_TEMPLE_LOOP_ENEMIES, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_LOOP_FLARE_DANCER, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Loop Flare Dancer
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_LOOP_FLARE_DANCER,
        world,
        {
            {
                Locations.FIRE_TEMPLE_FLARE_DANCER_CHEST,
                function(bundle)
                    return (LogicHelpers.has_explosives(bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)) and
                        (LogicHelpers.is_adult(bundle) or LogicHelpers.can_ground_jump(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_LOOP_FLARE_DANCER,
        world,
        {
            {Regions.FIRE_TEMPLE_LOOP_TILES, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_LOOP_HAMMER_SWITCH,
                function(bundle)
                    return (LogicHelpers.can_kill_enemy(bundle, Enemies.FLARE_DANCER))
                end
            }
        }
    )

    --Fire Temple Loop Hammer Switch
    --Events
    LogicHelpers.add_events(
        Regions.FIRE_TEMPLE_LOOP_HAMMER_SWITCH,
        world,
        {
            {
                EventLocations.FIRE_TEMPLE_LOOP_HAMMER_SWITCH_ROOM_SWITCH,
                LocalEvents.FIRE_TEMPLE_LOOP_HAMMER_SWITCH_HIT,
                function(bundle)
                    return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_LOOP_HAMMER_SWITCH,
        world,
        {
            {Regions.FIRE_TEMPLE_LOOP_FLARE_DANCER, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_LOOP_GORON_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.FIRE_TEMPLE_LOOP_HAMMER_SWITCH_HIT, bundle)
                end
            }
        }
    )

    --Fire Temple Loop Goron Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_LOOP_GORON_ROOM,
        world,
        {
            {Locations.FIRE_TEMPLE_BOSS_KEY_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_LOOP_GORON_ROOM,
        world,
        {
            {
                Regions.FIRE_TEMPLE_LOOP_HAMMER_SWITCH,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.FIRE_TEMPLE_LOOP_HAMMER_SWITCH_HIT, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_LOOP_EXIT,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.FIRE_TEMPLE_LOOP_HAMMER_SWITCH_HIT, bundle)
                end
            }
        }
    )

    --Fire Temple Loop Exit
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_LOOP_EXIT,
        world,
        {
            {Regions.FIRE_TEMPLE_FIRST_ROOM, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_LOOP_GORON_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.FIRE_TEMPLE_LOOP_HAMMER_SWITCH_HIT, bundle)
                end
            }
        }
    )

    --Fire Temple Big Lava Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM,
        world,
        {
            {
                Locations.FIRE_TEMPLE_BIG_LAVA_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_BIG_LAVA_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_BIG_LAVA_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM,
        world,
        {
            {
                Regions.FIRE_TEMPLE_FIRST_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_NORTH_GORON, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_NORTH_TILES,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or
                            LogicHelpers.can_do_trick(Tricks.FIRE_SOT, bundle)))
                end
            },
            {
                Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_SOUTH_GORON,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_FIRE_PILLAR_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 3, bundle)
                end
            }
        }
    )

    --Fire Temple Big Lava Room North Goron
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_NORTH_GORON,
        world,
        {
            {Locations.FIRE_TEMPLE_BIG_LAVA_ROOM_LOWER_OPEN_DOOR_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_NORTH_GORON,
        world,
        {
            {Regions.FIRE_TEMPLE_BIG_LAVA_ROOM, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Big Lava Room North Tiles
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_NORTH_TILES,
        world,
        {
            {
                Locations.FIRE_TEMPLE_GS_SONG_OF_TIME_ROOM,
                function(bundle)
                    return ((LogicHelpers.is_adult(bundle) and LogicHelpers.can_attack(bundle)) or
                        LogicHelpers.hookshot_or_boomerang(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_NORTH_TILES,
        world,
        {
            {Regions.FIRE_TEMPLE_BIG_LAVA_ROOM, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Big Lava Room South Goron
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_SOUTH_GORON,
        world,
        {
            {Locations.FIRE_TEMPLE_BIG_LAVA_ROOM_BLOCKED_DOOR_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BIG_LAVA_ROOM_SOUTH_GORON,
        world,
        {
            {Regions.FIRE_TEMPLE_BIG_LAVA_ROOM, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Fire Pillar Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_FIRE_PILLAR_ROOM,
        world,
        {
            {
                Locations.FIRE_TEMPLE_FIRE_PILLAR_ROOM_LEFT_HEART,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 56
                end
            },
            {
                Locations.FIRE_TEMPLE_FIRE_PILLAR_ROOM_RIGHT_HEART,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 56
                end
            },
            {
                Locations.FIRE_TEMPLE_FIRE_PILLAR_ROOM_BACK_HEART,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 56
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_FIRE_PILLAR_ROOM,
        world,
        {
            {
                Regions.FIRE_TEMPLE_BIG_LAVA_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 3, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_SHORTCUT_ROOM,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 56 and
                        LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 4, bundle))
                end
            }
        }
    )

    --Fire Temple Shortcut Room
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_SHORTCUT_ROOM,
        world,
        {
            {
                Regions.FIRE_TEMPLE_FIRE_PILLAR_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 4, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_SHORTCUT_CLIMB,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.FIRE_TEMPLE_SHORTCUT_SWITCH_HIT, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or
                            LogicHelpers.can_do_trick(Tricks.FIRE_STRENGTH, bundle) or
                            LogicHelpers.can_ground_jump(bundle)) and
                        (LogicHelpers.has_explosives(bundle) or
                            LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT, Items.FAIRY_SLINGSHOT}, bundle))
                end
            }
        }
    )

    --Fire Temple Shortcut Climb
    --Events
    LogicHelpers.add_events(
        Regions.FIRE_TEMPLE_SHORTCUT_CLIMB,
        world,
        {
            {
                EventLocations.FIRE_TEMPLE_SHORTCUT_SWITCH,
                LocalEvents.FIRE_TEMPLE_SHORTCUT_SWITCH_HIT,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_SHORTCUT_CLIMB,
        world,
        {
            {Locations.FIRE_TEMPLE_BOULDER_MAZE_SHORTCUT_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_SHORTCUT_CLIMB,
        world,
        {
            {Regions.FIRE_TEMPLE_SHORTCUT_ROOM, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_BOULDER_MAZE_UPPER, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Boulder Maze Lower
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER,
        world,
        {
            {Locations.FIRE_TEMPLE_BOULDER_MAZE_LOWER_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.FIRE_TEMPLE_GS_BOULDER_MAZE,
                function(bundle)
                    return (LogicHelpers.has_explosives(bundle) and
                        (LogicHelpers.is_adult(bundle) or LogicHelpers.hookshot_or_boomerang(bundle)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER,
        world,
        {
            {Regions.FIRE_TEMPLE_SHORTCUT_ROOM, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER_SIDE_ROOM, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_EAST_CENTRAL_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 5, bundle)
                end
            },
            {Regions.FIRE_TEMPLE_BOULDER_MAZE_UPPER, function(bundle)
                    return false
                end}
        }
    )

    --Fire Temple Boulder Maze Lower Side Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER_SIDE_ROOM,
        world,
        {
            {Locations.FIRE_TEMPLE_BOULDER_MAZE_SIDE_ROOM_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER_SIDE_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple East Central Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_EAST_CENTRAL_ROOM,
        world,
        {
            {Locations.FIRE_TEMPLE_EAST_CENTRAL_ROOM_LEFT_HEART, function(bundle)
                    return true
                end},
            {Locations.FIRE_TEMPLE_EAST_CENTRAL_ROOM_RIGHT_HEART, function(bundle)
                    return true
                end},
            {Locations.FIRE_TEMPLE_EAST_CENTRAL_ROOM_MIDDLE_HEART, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_EAST_CENTRAL_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_BIG_LAVA_ROOM, function(bundle)
                    return LogicHelpers.take_damage(bundle)
                end},
            {
                Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 5, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_FIRE_WALL_CHASE,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 6, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_MAP_REGION,
                function(bundle)
                    return (LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle))
                end
            }
        }
    )

    --Fire Temple Fire Wall Chase
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_FIRE_WALL_CHASE,
        world,
        {
            {
                Locations.FIRE_TEMPLE_FIRE_WALL_CHASE_EAST_PILLAR_HEART,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 24 and
                        (LogicHelpers.is_adult(bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)))
                end
            },
            {
                Locations.FIRE_TEMPLE_FIRE_WALL_CHASE_WEST_PILLAR_HEART,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 24 and
                        (LogicHelpers.is_adult(bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)))
                end
            },
            {
                Locations.FIRE_TEMPLE_FIRE_WALL_CHASE_EXIT_PLATFORM_HEART,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 24
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_FIRE_WALL_CHASE,
        world,
        {
            {
                Regions.FIRE_TEMPLE_EAST_CENTRAL_ROOM,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 24 and
                        LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 6, bundle))
                end
            },
            {Regions.FIRE_TEMPLE_MAP_REGION, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end},
            {
                Regions.FIRE_TEMPLE_BOULDER_MAZE_UPPER,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 24 and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_CORRIDOR,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 24 and LogicHelpers.is_adult(bundle) and
                        LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 7, bundle)
                end
            }
        }
    )

    --Fire Temple Map Region
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_MAP_REGION,
        world,
        {
            {Locations.FIRE_TEMPLE_MAP_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_MAP_REGION,
        world,
        {
            {Regions.FIRE_TEMPLE_EAST_CENTRAL_ROOM, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Boulder Maze Upper
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BOULDER_MAZE_UPPER,
        world,
        {
            {Locations.FIRE_TEMPLE_BOULDER_MAZE_UPPER_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BOULDER_MAZE_UPPER,
        world,
        {
            {Regions.FIRE_TEMPLE_SHORTCUT_CLIMB, function(bundle)
                    return LogicHelpers.has_explosives(bundle)
                end},
            {Regions.FIRE_TEMPLE_BOULDER_MAZE_LOWER, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_FIRE_WALL_CHASE, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_SCARECROW_ROOM,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SCARECROW, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.FIRE_SCARECROW, bundle) and LogicHelpers.is_adult(bundle) and
                            LogicHelpers.can_use(Items.LONGSHOT, bundle)))
                end
            }
        }
    )

    --Fire Temple Scarecrow Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_SCARECROW_ROOM,
        world,
        {
            {
                Locations.FIRE_TEMPLE_GS_SCARECROW_CLIMB,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle) or
                        LogicHelpers.can_use_any(
                            {Items.FAIRY_SLINGSHOT, Items.BOOMERANG, Items.FAIRY_BOW, Items.HOOKSHOT, Items.DINS_FIRE},
                            bundle
                        ) or
                        LogicHelpers.has_explosives(bundle)
                end
            }
        }
    )

    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_SCARECROW_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_BOULDER_MAZE_UPPER, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_EAST_PEAK, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple East Peak
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_EAST_PEAK,
        world,
        {
            {Locations.FIRE_TEMPLE_SCARECROW_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.FIRE_TEMPLE_GS_SCARECROW_TOP,
                function(bundle)
                    return LogicHelpers.can_use_projectile(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_EAST_PEAK,
        world,
        {
            {Regions.FIRE_TEMPLE_SCARECROW_ROOM, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_EAST_CENTRAL_ROOM, function(bundle)
                    return LogicHelpers.take_damage(bundle)
                end}
        }
    )

    --Fire Temple Corridor
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_CORRIDOR,
        world,
        {
            {
                Regions.FIRE_TEMPLE_FIRE_WALL_CHASE,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 7, bundle)
                end
            },
            {Regions.FIRE_TEMPLE_FIRE_MAZE_ROOM, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Fire Maze Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_FIRE_MAZE_ROOM,
        world,
        {
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_LEFT_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_LEFT_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_LEFT_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_LEFT_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_FIRE_MAZE_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_CORRIDOR, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_FIRE_MAZE_UPPER,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_ground_jump(bundle)
                end
            },
            {Regions.FIRE_TEMPLE_FIRE_MAZE_SIDE_ROOM, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_WEST_CENTRAL_LOWER,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 8, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_LATE_FIRE_MAZE,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.FIRE_FLAME_MAZE, bundle)
                end
            }
        }
    )

    --Fire Temple Fire Maze Upper
    --Events
    LogicHelpers.add_events(
        Regions.FIRE_TEMPLE_FIRE_MAZE_UPPER,
        world,
        {
            {
                EventLocations.FIRE_TEMPLE_FIRE_MAZE_UPPER_PLATFORM,
                LocalEvents.FIRE_TEMPLE_FIRE_MAZE_UPPER_PLATFORM_HIT,
                function(bundle)
                    return (LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_FIRE_MAZE_UPPER,
        world,
        {
            {
                Regions.FIRE_TEMPLE_NEAR_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            },
            {Regions.FIRE_TEMPLE_FIRE_MAZE_ROOM, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_WEST_CENTRAL_UPPER,
                function(bundle)
                    return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            }
        }
    )

    --Fire Temple Fire Maze Side Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_FIRE_MAZE_SIDE_ROOM,
        world,
        {
            {Locations.FIRE_TEMPLE_COMPASS_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_FIRE_MAZE_SIDE_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_FIRE_MAZE_ROOM, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple West Central Lower
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_WEST_CENTRAL_LOWER,
        world,
        {
            {
                Regions.FIRE_TEMPLE_FIRE_MAZE_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FIRE_TEMPLE_SMALL_KEY, 8, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_WEST_CENTRAL_UPPER,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.SONG_OF_TIME, bundle))
                end
            },
            {Regions.FIRE_TEMPLE_LATE_FIRE_MAZE, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple West Central Upper
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_WEST_CENTRAL_UPPER,
        world,
        {
            {
                Locations.FIRE_TEMPLE_HIGHEST_GORON_CHEST,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or
                        LogicHelpers.can_do_trick(Tricks.RUSTED_SWITCHES, bundle)) and
                        LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_WEST_CENTRAL_UPPER,
        world,
        {
            {Regions.FIRE_TEMPLE_BOSS_ENTRYWAY, function(bundle)
                    return false
                end},
            {Regions.FIRE_TEMPLE_FIRE_MAZE_UPPER, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_WEST_CENTRAL_LOWER, function(bundle)
                    return true
                end}
        }
    )

    --Fire Temple Late Fire Maze
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_LATE_FIRE_MAZE,
        world,
        {
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_RIGHT_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_RIGHT_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_RIGHT_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_FLAME_MAZE_RIGHT_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_LATE_FIRE_MAZE,
        world,
        {
            {Regions.FIRE_TEMPLE_FIRE_MAZE_ROOM, function(bundle)
                    return false
                end},
            {Regions.FIRE_TEMPLE_WEST_CENTRAL_LOWER, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_UPPER_FLARE_DANCER,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle)
                end
            }
        }
    )

    --Fire Temple Upper Flare Dancer
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_UPPER_FLARE_DANCER,
        world,
        {
            {
                Regions.FIRE_TEMPLE_LATE_FIRE_MAZE,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.FLARE_DANCER)
                end
            },
            {
                Regions.FIRE_TEMPLE_WEST_CLIMB,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.FLARE_DANCER)
                end
            }
        }
    )

    --Fire Temple West Climb
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_WEST_CLIMB,
        world,
        {
            {Regions.FIRE_TEMPLE_UPPER_FLARE_DANCER, function(bundle)
                    return true
                end},
            {Regions.FIRE_TEMPLE_WEST_PEAK, function(bundle)
                    return LogicHelpers.can_use_projectile(bundle)
                end}
        }
    )

    --Fire Temple West Peak
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_WEST_PEAK,
        world,
        {
            {Locations.FIRE_TEMPLE_MEGATON_HAMMER_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_WEST_PEAK,
        world,
        {
            {
                Regions.FIRE_TEMPLE_WEST_CENTRAL_UPPER,
                function(bundle)
                    return LogicHelpers.take_damage(bundle)
                end
            },
            {Regions.FIRE_TEMPLE_WEST_CLIMB, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_HAMMER_RETURN_PATH,
                function(bundle)
                    return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            }
        }
    )

    --Fire Temple Hammer Return Path
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_HAMMER_RETURN_PATH,
        world,
        {
            {
                Locations.FIRE_TEMPLE_AFTER_HAMMER_SMALL_CRATE1,
                function(bundle)
                    return LogicHelpers.can_break_small_crates(bundle)
                end
            },
            {
                Locations.FIRE_TEMPLE_AFTER_HAMMER_SMALL_CRATE2,
                function(bundle)
                    return LogicHelpers.can_break_small_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_HAMMER_RETURN_PATH,
        world,
        {
            {
                Regions.FIRE_TEMPLE_ABOVE_FIRE_MAZE,
                function(bundle)
                    return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            }
        }
    )

    --Fire Temple Above Fire Maze
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_ABOVE_FIRE_MAZE,
        world,
        {
            {Regions.FIRE_TEMPLE_HAMMER_RETURN_PATH, function(bundle)
                    return true
                end},
            {
                Regions.FIRE_TEMPLE_FIRE_MAZE_UPPER,
                function(bundle)
                    return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            }
        }
    )

    --Fire Temple Boss Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BOSS_ENTRYWAY,
        world,
        {
            {Regions.FIRE_TEMPLE_NEAR_BOSS_ROOM, function(bundle)
                    return false
                end},
            {
                Regions.FIRE_TEMPLE_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(Items.FIRE_TEMPLE_BOSS_KEY, bundle)
                end
            }
        }
    )

    --Fire Temple Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.FIRE_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                EventLocations.FIRE_TEMPLE_VOLVAGIA,
                Events.FIRE_TEMPLE_COMPLETED,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 64 and LogicHelpers.can_kill_enemy(bundle, Enemies.VOLVAGIA)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FIRE_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                Locations.FIRE_TEMPLE_VOLVAGIA_HEART_CONTAINER,
                function(bundle)
                    return LogicHelpers.has_item(Events.FIRE_TEMPLE_COMPLETED, bundle)
                end
            },
            {
                Locations.VOLVAGIA,
                function(bundle)
                    return LogicHelpers.has_item(Events.FIRE_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FIRE_TEMPLE_BOSS_ROOM,
        world,
        {
            {Regions.FIRE_TEMPLE_BOSS_ENTRYWAY, function(bundle)
                    return false
                end},
            {
                Regions.DMC_CENTRAL_LOCAL,
                function(bundle)
                    return LogicHelpers.has_item(Events.FIRE_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
end

return set_region_rules
