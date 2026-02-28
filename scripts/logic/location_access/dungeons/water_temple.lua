local EventLocations = {
    WATER_TEMPLE_EAST_LOWER_WATER_LOW_FROM_HIGH = "Water Temple East Lower Water Low From High",
    WATER_TEMPLE_CENTRAL_PILLAR_UPPER_WATER_MIDDLE = "Water Temple Central Pillar Upper Water Middle",
    WATER_TEMPLE_HIGH_WATER_WATER_HIGH = "Water Temple High Water Water High",
    WATER_TEMPLE_BOSS_KEY_ROOM_FAIRY_POT = "Water Temple Boss Key Room Fairy Pot",
    WATER_TEMPLE_PRE_BOSS_ROOM_FAIRY_POT = "Water Temple Pre Boss Room Fairy Pot",
    WATER_TEMPLE_MORPHA = "Water Temple Morpha"
}

local LocalEvents = {
    WATER_LEVEL_LOW = "Water Level Low",
    WATER_LEVEL_MIDDLE = "Water Level Middle",
    WATER_LEVEL_HIGH = "Water Level High"
}

local function set_region_rules(world)
    --Water Temple Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_ENTRYWAY,
        world,
        {
            {
                Regions.WATER_TEMPLE_LOBBY,
                function(bundle)
                    return (LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            },
            {Regions.LH_FROM_WATER_TEMPLE, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Lobby
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_LOBBY,
        world,
        {
            {
                Locations.WATER_TEMPLE_MAIN_LEVEL2_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                            LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle) or
                            (LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle))))
                end
            },
            {
                Locations.WATER_TEMPLE_MAIN_LEVEL2_POT2,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                            LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle) or
                            (LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle))))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_LOBBY,
        world,
        {
            {Regions.WATER_TEMPLE_ENTRYWAY, function(bundle)
                    return true
                end},
            {
                Regions.WATER_TEMPLE_EAST_LOWER,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                        ((LogicHelpers.can_do_trick(Tricks.FEWER_TUNIC_REQUIREMENTS, bundle) or
                            LogicHelpers.can_use(Items.ZORA_TUNIC, bundle)) and
                            (LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                                (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                                    LogicHelpers.can_do_trick(Tricks.WATER_LONGSHOT_TORCH, bundle)))))
                end
            },
            {
                Regions.WATER_TEMPLE_NORTH_LOWER,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                        ((LogicHelpers.can_do_trick(Tricks.FEWER_TUNIC_REQUIREMENTS, bundle) or
                            LogicHelpers.can_use(Items.ZORA_TUNIC, bundle)) and
                            LogicHelpers.can_use(Items.IRON_BOOTS, bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_SOUTH_LOWER,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) and
                        LogicHelpers.has_explosives(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle)) and
                        (LogicHelpers.can_do_trick(Tricks.FEWER_TUNIC_REQUIREMENTS, bundle) or
                            LogicHelpers.can_use(Items.ZORA_TUNIC, bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_WEST_LOWER,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) and
                        LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                        (LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or
                            LogicHelpers.can_use(Items.IRON_BOOTS, bundle)) and
                        (LogicHelpers.can_do_trick(Tricks.FEWER_TUNIC_REQUIREMENTS, bundle) or
                            LogicHelpers.can_use(Items.ZORA_TUNIC, bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_CENTRAL_PILLAR_LOWER,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) and
                        LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 5, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_CENTRAL_PILLAR_UPPER,
                function(bundle)
                    return ((LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                        LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle)) and
                        (LogicHelpers.has_fire_source_with_torch(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_EAST_MIDDLE,
                function(bundle)
                    return ((LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                        LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle) or
                        (LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 16)) and
                        LogicHelpers.can_use(Items.LONGSHOT, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_WEST_MIDDLE,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_HIGH_WATER,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST, bundle) and
                                LogicHelpers.can_use(Items.BOMB_BAG, bundle) and
                                LogicHelpers.take_damage(bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_BLOCK_CORRIDOR,
                function(bundle)
                    return ((LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                        LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle)) and
                        (LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle)) and
                        (LogicHelpers.can_use(Items.LONGSHOT, bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.WATER_CENTRAL_BOW, bundle) and
                                (LogicHelpers.is_adult(bundle) or
                                    LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle)))))
                end
            },
            {
                Regions.WATER_TEMPLE_FALLING_PLATFORM_ROOM,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_HIGH, bundle) and
                        LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 4, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_PRE_BOSS_ROOM,
                function(bundle)
                    return ((LogicHelpers.has_item(LocalEvents.WATER_LEVEL_HIGH, bundle) and
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.HOVER_BOOST_SIMPLE, bundle) and
                            LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST_SIMPLE, bundle) and
                            LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)))
                end
            }
        }
    )

    --Water Temple East Lower
    --Events
    LogicHelpers.add_events(
        Regions.WATER_TEMPLE_EAST_LOWER,
        world,
        {
            {
                EventLocations.WATER_TEMPLE_EAST_LOWER_WATER_LOW_FROM_HIGH,
                LocalEvents.WATER_LEVEL_LOW,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_EAST_LOWER,
        world,
        {
            {
                Locations.WATER_TEMPLE_TORCH_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                            (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle))))
                end
            },
            {
                Locations.WATER_TEMPLE_TORCH_POT2,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                            (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle))))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_EAST_LOWER,
        world,
        {
            {
                Regions.WATER_TEMPLE_LOBBY,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                        ((LogicHelpers.can_do_trick(Tricks.FEWER_TUNIC_REQUIREMENTS, bundle) or
                            LogicHelpers.can_use(Items.ZORA_TUNIC, bundle)) and
                            LogicHelpers.can_use(Items.IRON_BOOTS, bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_MAP_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.WATER_LEVEL_HIGH, bundle)
                end
            },
            {
                Regions.WATER_TEMPLE_CRACKED_WALL,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle) or
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_HIGH, bundle) and
                            LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) and
                            ((LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                LogicHelpers.can_do_trick(Tricks.WATER_CRACKED_WALL_HOVERS, bundle)) or
                                LogicHelpers.can_do_trick(Tricks.WATER_CRACKED_WALL, bundle))))
                end
            },
            {
                Regions.WATER_TEMPLE_TORCH_ROOM,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) and
                        (LogicHelpers.has_fire_source_with_torch(bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle)))
                end
            }
        }
    )

    --Water Temple Map Room
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_MAP_ROOM,
        world,
        {
            {
                Locations.WATER_TEMPLE_MAP_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.SPIKE, EnemyDistance.CLOSE, true, 3)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_MAP_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_EAST_LOWER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.SPIKE, EnemyDistance.CLOSE, true, 3)
                end
            }
        }
    )

    --Water Temple Cracked Wall
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_CRACKED_WALL,
        world,
        {
            {
                Locations.WATER_TEMPLE_CRACKED_WALL_CHEST,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_CRACKED_WALL,
        world,
        {
            {Regions.WATER_TEMPLE_EAST_LOWER, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Torch Room
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_TORCH_ROOM,
        world,
        {
            {
                Locations.WATER_TEMPLE_TORCHES_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.SHELL_BLADE, EnemyDistance.CLOSE, true, 3)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_TORCH_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_EAST_LOWER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.SHELL_BLADE, EnemyDistance.CLOSE, true, 3)
                end
            }
        }
    )

    --Water Temple North Lower
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_NORTH_LOWER,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return true
                end},
            {
                Regions.WATER_TEMPLE_BOULDERS_LOWER,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.WATER_BK_REGION, bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))) and
                        LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 4, bundle))
                end
            }
        }
    )

    --Water Temple Boulders Lower
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_BOULDERS_LOWER,
        world,
        {
            {
                Regions.WATER_TEMPLE_NORTH_LOWER,
                function(bundle)
                    return LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 4, bundle)
                end
            },
            {Regions.WATER_TEMPLE_BLOCK_ROOM, function(bundle)
                    return true
                end},
            {
                Regions.WATER_TEMPLE_BOULDERS_UPPER,
                function(bundle)
                    return ((LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            LogicHelpers.can_do_trick(Tricks.WATER_NORTH_BASEMENT_LEDGE_JUMP, bundle))) or
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_NEAR_BOSS_KEY_CHEST_GS,
                function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            }
        }
    )

    --Water Temple Block Room
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_BLOCK_ROOM,
        world,
        {
            {
                Locations.WATER_TEMPLE_BASEMENT_BLOCK_PUZZLE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WATER_TEMPLE_BASEMENT_BLOCK_PUZZLE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_BLOCK_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_BOULDERS_LOWER,
                function(bundle)
                    return ((LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and LogicHelpers.has_explosives(bundle)) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_JETS_ROOM,
                function(bundle)
                    return ((LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and LogicHelpers.has_explosives(bundle)) or
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)))
                end
            }
        }
    )

    --Water Temple Jets Room
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_JETS_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_BLOCK_ROOM,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {Regions.WATER_TEMPLE_BOULDERS_UPPER, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Boulders Upper
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_BOULDERS_UPPER,
        world,
        {
            {Regions.WATER_TEMPLE_BOULDERS_LOWER, function(bundle)
                    return true
                end},
            {Regions.WATER_TEMPLE_JETS_ROOM, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end},
            {
                Regions.WATER_TEMPLE_BOSS_KEY_ROOM,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.WATER_BK_JUMP_DIVE, bundle))) and
                        LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 5, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_NEAR_BOSS_KEY_CHEST_GS,
                function(bundle)
                    return ((LogicHelpers.is_adult(bundle) and LogicHelpers.hookshot_or_boomerang(bundle)) or
                        (LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            }
        }
    )

    --Water Temple Near Boss Key Chest GS
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_NEAR_BOSS_KEY_CHEST_GS,
        world,
        {
            {Locations.WATER_TEMPLE_GS_NEAR_BOSS_KEY_CHEST, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Boss Key Room
    --Events
    LogicHelpers.add_events(
        Regions.WATER_TEMPLE_BOSS_KEY_ROOM,
        world,
        {
            {
                EventLocations.WATER_TEMPLE_BOSS_KEY_ROOM_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_BOSS_KEY_ROOM,
        world,
        {
            {Locations.WATER_TEMPLE_BOSS_KEY_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.WATER_TEMPLE_BOSS_KEY_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WATER_TEMPLE_BOSS_KEY_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_BOSS_KEY_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_BOULDERS_UPPER,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.WATER_BK_JUMP_DIVE, bundle)) or
                        LogicHelpers.is_child(bundle) or
                        LogicHelpers.has_item(Items.SILVER_SCALE, bundle)) and
                        LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 5, bundle))
                end
            }
        }
    )

    --Water Temple South Lower
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_SOUTH_LOWER,
        world,
        {
            {
                Locations.WATER_TEMPLE_GS_BEHIND_GATE,
                function(bundle)
                    return (LogicHelpers.can_jump_slash(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))))
                end
            },
            {
                Locations.WATER_TEMPLE_BEHIND_GATE_POT1,
                function(bundle)
                    return (LogicHelpers.can_jump_slash(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))))
                end
            },
            {
                Locations.WATER_TEMPLE_BEHIND_GATE_POT2,
                function(bundle)
                    return (LogicHelpers.can_jump_slash(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))))
                end
            },
            {
                Locations.WATER_TEMPLE_BEHIND_GATE_POT3,
                function(bundle)
                    return (LogicHelpers.can_jump_slash(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))))
                end
            },
            {
                Locations.WATER_TEMPLE_BEHIND_GATE_POT4,
                function(bundle)
                    return (LogicHelpers.can_jump_slash(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_SOUTH_LOWER,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end}
        }
    )

    --Water Temple West Lower
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_WEST_LOWER,
        world,
        {
            {
                Regions.WATER_TEMPLE_LOBBY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_DRAGON_ROOM,
                function(bundle)
                    return (LogicHelpers.can_jump_slash_except_hammer(bundle) or LogicHelpers.can_use_projectile(bundle))
                end
            }
        }
    )

    --Water Temple Dragon Room
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_DRAGON_ROOM,
        world,
        {
            {Regions.WATER_TEMPLE_WEST_LOWER, function(bundle)
                    return true
                end},
            {
                Regions.WATER_TEMPLE_DRAGON_ROOM_CHEST,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.HOOKSHOT, bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle)) or
                        (((LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.WATER_ADULT_DRAGON, bundle) and
                            (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                                LogicHelpers.can_use(Items.BOMBCHUS_5, bundle))) or
                            (LogicHelpers.is_child(bundle) and LogicHelpers.can_do_trick(Tricks.WATER_CHILD_DRAGON, bundle) and
                                (LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                                    LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                                    LogicHelpers.can_use(Items.BOMBCHUS_5, bundle)))) and
                            (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or
                                LogicHelpers.can_use(Items.IRON_BOOTS, bundle))))
                end
            }
        }
    )

    --Water Temple Central Pillar Lower
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_CENTRAL_PILLAR_LOWER,
        world,
        {
            {
                Regions.WATER_TEMPLE_LOBBY,
                function(bundle)
                    return LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 5, bundle)
                end
            },
            {
                Regions.WATER_TEMPLE_CENTRAL_PILLAR_UPPER,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {
                Regions.WATER_TEMPLE_CENTRAL_PILLAR_BASEMENT,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle) and
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 40)
                end
            }
        }
    )

    --Water Temple Central Pillar Upper
    --Events
    LogicHelpers.add_events(
        Regions.WATER_TEMPLE_CENTRAL_PILLAR_UPPER,
        world,
        {
            {
                EventLocations.WATER_TEMPLE_CENTRAL_PILLAR_UPPER_WATER_MIDDLE,
                LocalEvents.WATER_LEVEL_MIDDLE,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_CENTRAL_PILLAR_UPPER,
        world,
        {
            {
                Locations.WATER_TEMPLE_GS_CENTRAL_PILLAR,
                function(bundle)
                    return (LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                        (((LogicHelpers.can_do_trick(Tricks.WATER_FW_CENTRAL_GS, bundle) and
                            LogicHelpers.can_use(Items.FARORES_WIND, bundle) and
                            (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                                LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 5, bundle))) or
                            (LogicHelpers.can_do_trick(Tricks.WATER_IRONS_CENTRAL_GS, bundle) and
                                LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                                ((LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                                    LogicHelpers.can_use(Items.FAIRY_BOW, bundle)) or
                                    (LogicHelpers.can_use(Items.DINS_FIRE, bundle))))) and
                            LogicHelpers.has_item(LocalEvents.WATER_LEVEL_HIGH, bundle) and
                            LogicHelpers.hookshot_or_boomerang(bundle)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_CENTRAL_PILLAR_UPPER,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return true
                end},
            {Regions.WATER_TEMPLE_CENTRAL_PILLAR_LOWER, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Central Pillar Basement
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_CENTRAL_PILLAR_BASEMENT,
        world,
        {
            {
                Locations.WATER_TEMPLE_CENTRAL_PILLAR_CHEST,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 40)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_CENTRAL_PILLAR_BASEMENT,
        world,
        {
            {
                Regions.WATER_TEMPLE_CENTRAL_PILLAR_LOWER,
                function(bundle)
                    return (LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 16)
                end
            }
        }
    )

    --Water Temple East Middle
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_EAST_MIDDLE,
        world,
        {
            {
                Locations.WATER_TEMPLE_COMPASS_CHEST,
                function(bundle)
                    return LogicHelpers.can_use_projectile(bundle)
                end
            },
            {
                Locations.WATER_TEMPLE_NEAR_COMPASS_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WATER_TEMPLE_NEAR_COMPASS_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WATER_TEMPLE_NEAR_COMPASS_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_EAST_MIDDLE,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end}
        }
    )

    --Water Temple West Middle
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_WEST_MIDDLE,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return true
                end},
            {Regions.WATER_TEMPLE_HIGH_WATER, function(bundle)
                    return LogicHelpers.can_use_projectile(bundle)
                end}
        }
    )

    --Water Temple High Water
    --Events
    LogicHelpers.add_events(
        Regions.WATER_TEMPLE_HIGH_WATER,
        world,
        {
            {
                EventLocations.WATER_TEMPLE_HIGH_WATER_WATER_HIGH,
                LocalEvents.WATER_LEVEL_HIGH,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_HIGH_WATER,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Block Corridor
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_BLOCK_CORRIDOR,
        world,
        {
            {
                Locations.WATER_TEMPLE_CENTRAL_BOW_TARGET_CHEST,
                function(bundle)
                    return (LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                            LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle)))
                end
            },
            {
                Locations.WATER_TEMPLE_CENTRAL_BOW_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                            LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle)))
                end
            },
            {
                Locations.WATER_TEMPLE_CENTRAL_BOW_POT2,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                        (LogicHelpers.has_item(LocalEvents.WATER_LEVEL_LOW, bundle) or
                            LogicHelpers.has_item(LocalEvents.WATER_LEVEL_MIDDLE, bundle)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_BLOCK_CORRIDOR,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end}
        }
    )

    --Water Temple Falling Platform Room
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_FALLING_PLATFORM_ROOM,
        world,
        {
            {
                Locations.WATER_TEMPLE_GS_FALLING_PLATFORM_ROOM,
                function(bundle)
                    return (LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.WATER_RANG_FALLING_PLATFORM_GS, bundle) and
                            LogicHelpers.is_child(bundle) and
                            LogicHelpers.can_use(Items.BOOMERANG, bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.WATER_HOOKSHOT_FALLING_PLATFORM_GS, bundle) and
                            LogicHelpers.is_adult(bundle) and
                            LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_FALLING_PLATFORM_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_LOBBY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                        LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 4, bundle))
                end
            },
            {
                Regions.WATER_TEMPLE_DRAGON_PILLARS_ROOM,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                        LogicHelpers.small_keys(Items.WATER_TEMPLE_SMALL_KEY, 5, bundle))
                end
            }
        }
    )

    --Water Temple Dragon Pillars Room
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_DRAGON_PILLARS_ROOM,
        world,
        {
            {
                Locations.WATER_TEMPLE_LIKE_LIKE_POT1,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {
                Locations.WATER_TEMPLE_LIKE_LIKE_POT2,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_DRAGON_PILLARS_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_FALLING_PLATFORM_ROOM,
                function(bundle)
                    return LogicHelpers.can_use_projectile(bundle)
                end
            },
            {
                Regions.WATER_TEMPLE_DARK_LINK_ROOM,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            }
        }
    )

    --Water Temple Dark Link Room
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_DARK_LINK_ROOM,
        world,
        {
            {
                Regions.WATER_TEMPLE_DRAGON_PILLARS_ROOM,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.DARK_LINK)
                end
            },
            {
                Regions.WATER_TEMPLE_LONGSHOT_ROOM,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.DARK_LINK)
                end
            }
        }
    )

    --Water Temple Longshot Room
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_LONGSHOT_ROOM,
        world,
        {
            {Locations.WATER_TEMPLE_LONGSHOT_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_LONGSHOT_ROOM,
        world,
        {
            {Regions.WATER_TEMPLE_DARK_LINK_ROOM, function(bundle)
                    return true
                end},
            {
                Regions.WATER_TEMPLE_RIVER,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.SONG_OF_TIME, bundle))
                end
            }
        }
    )

    --Water Temple River
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_RIVER,
        world,
        {
            {
                Locations.WATER_TEMPLE_RIVER_CHEST,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle)) and
                        (LogicHelpers.is_adult(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            },
            {
                Locations.WATER_TEMPLE_GS_RIVER,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.WATER_RIVER_GS, bundle) and
                            LogicHelpers.can_use(Items.LONGSHOT, bundle)))
                end
            },
            {Locations.WATER_TEMPLE_RIVER_POT1, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.WATER_TEMPLE_RIVER_POT2, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {
                Locations.WATER_TEMPLE_RIVER_HEART1,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 16) or
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            },
            {
                Locations.WATER_TEMPLE_RIVER_HEART2,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 16) or
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            },
            {
                Locations.WATER_TEMPLE_RIVER_HEART3,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 16) or
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            },
            {
                Locations.WATER_TEMPLE_RIVER_HEART4,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 16) or
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_RIVER,
        world,
        {
            {
                Regions.WATER_TEMPLE_DRAGON_ROOM,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle)) and
                        (LogicHelpers.is_adult(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            },
            {
                Regions.WATER_TEMPLE_DRAGON_ROOM_CHEST,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                        ((LogicHelpers.can_do_trick(Tricks.WATER_ADULT_DRAGON, bundle) and
                            (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or
                                LogicHelpers.can_use(Items.IRON_BOOTS, bundle))) or
                            LogicHelpers.can_do_trick(Tricks.WATER_DRAGON_JUMP_DIVE, bundle)))
                end
            }
        }
    )

    --Water Temple Dragon Chest
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_DRAGON_ROOM_CHEST,
        world,
        {
            {Locations.WATER_TEMPLE_DRAGON_CHEST, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Pre Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.WATER_TEMPLE_PRE_BOSS_ROOM,
        world,
        {
            {
                EventLocations.WATER_TEMPLE_PRE_BOSS_ROOM_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_PRE_BOSS_ROOM,
        world,
        {
            {
                Locations.WATER_TEMPLE_MAIN_LEVEL1_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WATER_TEMPLE_MAIN_LEVEL1_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_PRE_BOSS_ROOM,
        world,
        {
            {Regions.WATER_TEMPLE_LOBBY, function(bundle)
                    return true
                end},
            {Regions.WATER_TEMPLE_BOSS_ENTRYWAY, function(bundle)
                    return true
                end}
        }
    )

    --Water Temple Boss Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_BOSS_ENTRYWAY,
        world,
        {
            {Regions.WATER_TEMPLE_PRE_BOSS_ROOM, function(bundle)
                    return false
                end},
            {
                Regions.WATER_TEMPLE_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(Items.WATER_TEMPLE_BOSS_KEY, bundle)
                end
            }
        }
    )

    --Water Temple Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.WATER_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                EventLocations.WATER_TEMPLE_MORPHA,
                Events.WATER_TEMPLE_COMPLETED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.MORPHA)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.WATER_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                Locations.WATER_TEMPLE_MORPHA_HEART_CONTAINER,
                function(bundle)
                    return LogicHelpers.has_item(Events.WATER_TEMPLE_COMPLETED, bundle)
                end
            },
            {
                Locations.MORPHA,
                function(bundle)
                    return LogicHelpers.has_item(Events.WATER_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WATER_TEMPLE_BOSS_ROOM,
        world,
        {
            {Regions.WATER_TEMPLE_BOSS_ENTRYWAY, function(bundle)
                    return false
                end},
            {
                Regions.LAKE_HYLIA,
                function(bundle)
                    return LogicHelpers.has_item(Events.WATER_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
end

return set_region_rules
