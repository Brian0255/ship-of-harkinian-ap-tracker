local EventLocations = {
    FOREST_TEMPLE_MEG = "Forest Temple Meg",
    FOREST_TEMPLE_JOELLE = "Forest Temple Joelle",
    FOREST_TEMPLE_AMY = "Forest Temple Amy",
    FOREST_TEMPLE_BETH = "Forest Temple Beth",
    FOREST_TEMPLE_LOWER_STALFOS_FAIRY_POT = "Forest Temple Lower Stalfos Fairy Pot",
    FOREST_TEMPLE_NW_OUTDOORS_LOWER_DEKU_BABA_STICKS = "Forest Temple NW Outdoors Lower Deku Baba Sticks",
    FOREST_TEMPLE_NW_OUTDOORS_LOWER_DEKU_BABA_NUTS = "Forest Temple NW Outdoors Lower Deku Baba Nuts",
    FOREST_TEMPLE_NW_OUTDOORS_UPPER_DEKU_BABA_STICKS = "Forest Temple NW Outdoors Upper Deku Baba Sticks",
    FOREST_TEMPLE_NW_OUTDOORS_UPPER_DEKU_BABA_NUTS = "Forest Temple NW Outdoors Upper Deku Baba Nuts",
    FOREST_TEMPLE_NE_OUTDOORS_UPPER_DEKU_BABA_STICKS = "Forest Temple NE Outdoors Upper Deku Baba Sticks",
    FOREST_TEMPLE_NE_OUTDOORS_UPPER_DEKU_BABA_NUTS = "Forest Temple NE Outdoors Upper Deku Baba Nuts",
    FOREST_TEMPLE_NE_OUTDOORS_LOWER_DEKU_BABA_STICKS = "Forest Temple NE Outdoors Lower Deku Baba Sticks",
    FOREST_TEMPLE_NE_OUTDOORS_LOWER_DEKU_BABA_NUTS = "Forest Temple NE Outdoors Lower Deku Baba Nuts",
    FOREST_TEMPLE_NE_OUTDOORS_UPPER_DRAIN_WELL = "Forest Temple NE Outdoors Upper Drain Well",
    FOREST_TEMPLE_PHANTOM_GANON = "Forest Temple Phantom Ganon"
}

local LocalEvents = {
    DEFEATED_MEG = "Defeated Meg",
    DEFEATED_JOELLE = "Defeated Joelle",
    DEFEATED_AMY = "Defeated Amy",
    DEFEATED_BETH = "Defeated Beth",
    DRAINED_WELL = "Drained the Well"
}

local function set_region_rules(world)
    --Forest Temple Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_ENTRYWAY,
        world,
        {
            --Todo: Change this when we have IsVanilla vs. IsMQ
            {
                Regions.FOREST_TEMPLE_FIRST_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.SACRED_FOREST_MEADOW,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple First Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_FIRST_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_FIRST_ROOM_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.FOREST_TEMPLE_GS_FIRST_ROOM,
                function(bundle)
                    return ((LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.BOMB_BAG, bundle)) or
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                        LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                        LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                        LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.FOREST_FIRST_GS, bundle) and
                            (LogicHelpers.can_jump_slash_except_hammer(bundle) or
                                (LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.BOMB_BAG, bundle)))))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_FIRST_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_ENTRYWAY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_SOUTH_CORRIDOR,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple South Corridor
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_SOUTH_CORRIDOR,
        world,
        {
            {
                Regions.FOREST_TEMPLE_FIRST_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_LOBBY,
                function(bundle)
                    return (LogicHelpers.can_pass_enemy(bundle, Enemies.BIG_SKULLTULA))
                end
            }
        }
    )

    --Foest Temple Lobby
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_LOBBY,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_MEG,
                LocalEvents.DEFEATED_MEG,
                function(bundle)
                    return (LogicHelpers.has_item(LocalEvents.DEFEATED_JOELLE, bundle) and
                        LogicHelpers.has_item(LocalEvents.DEFEATED_BETH, bundle) and
                        LogicHelpers.has_item(LocalEvents.DEFEATED_AMY, bundle) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.MEG))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_LOBBY,
        world,
        {
            {
                Locations.FOREST_TEMPLE_GS_LOBBY,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_LOBBY_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_LOBBY_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_LOBBY_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_LOBBY_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_LOBBY_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_LOBBY_POT6,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_LOBBY,
        world,
        {
            {
                Regions.FOREST_TEMPLE_SOUTH_CORRIDOR,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NORTH_CORRIDOR,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_LOWER,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or LogicHelpers.is_child(bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_OUTDOORS_LOWER,
                function(bundle)
                    return (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                        LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_WEST_CORRIDOR,
                function(bundle)
                    return (LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 1, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_EAST_CORRIDOR,
                function(bundle)
                    return false
                end
            },
            {
                Regions.FOREST_TEMPLE_BOSS_REGION,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DEFEATED_MEG, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_BOSS_ENTRYWAY,
                function(bundle)
                    return false
                end
            }
        }
    )

    --Forest Temple North Corridor
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NORTH_CORRIDOR,
        world,
        {
            {
                Regions.FOREST_TEMPLE_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_LOWER_STALFOS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple Lower Stalfos
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_LOWER_STALFOS,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_LOWER_STALFOS_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_LOWER_STALFOS,
        world,
        {
            {
                Locations.FOREST_TEMPLE_FIRST_STALFOS_CHEST,
                function(bundle)
                    return (LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 2))
                end
            },
            {
                Locations.FOREST_TEMPLE_LOWER_STALFOS_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_LOWER_STALFOS_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_LOWER_STALFOS,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NORTH_CORRIDOR,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple NW Outdoors Lower
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_NW_OUTDOORS_LOWER,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_NW_OUTDOORS_LOWER_DEKU_BABA_STICKS,
                Events.CAN_FARM_STICKS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_sticks(bundle)
                end
            },
            {
                EventLocations.FOREST_TEMPLE_NW_OUTDOORS_LOWER_DEKU_BABA_NUTS,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_nuts(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NW_OUTDOORS_LOWER,
        world,
        {
            {
                Regions.FOREST_TEMPLE_LOBBY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_TIME, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_COURTYARD_SKULLTULA_ISLAND,
                function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_UPPER,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                        ((LogicHelpers.can_do_trick(Tricks.HOVER_BOOST_SIMPLE, bundle) and
                            LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST_SIMPLE, bundle) and
                            LogicHelpers.has_explosives(bundle)) or
                            (LogicHelpers.can_do_trick(Tricks.GROUND_JUMP_HARD, bundle) and
                                LogicHelpers.can_ground_jump(bundle))))
                end
            },
            {
                Regions.FOREST_TEMPLE_MAP_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_WELL,
                function(bundle)
                    return ((LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)) or
                        LogicHelpers.has_item(LocalEvents.DRAINED_WELL, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_BOSS_ENTRYWAY,
                function(bundle)
                    return false
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_COURTYARD_HEARTS,
                function(bundle)
                    return (LogicHelpers.can_use(Items.BOOMERANG, bundle) and
                        LogicHelpers.can_do_trick(Tricks.FOREST_OUTDOORS_HEARTS_BOOMERANG, bundle))
                end
            }
        }
    )

    --Forest Temple NW Outdoors Upper
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_NW_OUTDOORS_UPPER,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_NW_OUTDOORS_UPPER_DEKU_BABA_STICKS,
                Events.CAN_FARM_STICKS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_sticks(bundle)
                end
            },
            {
                EventLocations.FOREST_TEMPLE_NW_OUTDOORS_UPPER_DEKU_BABA_NUTS,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_nuts(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NW_OUTDOORS_UPPER,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_LOWER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_COURTYARD_SKULLTULA_ISLAND,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_BELOW_BOSS_KEY_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_FLOORMASTER_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_BLOCK_PUSH_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_COURTYARD_HEARTS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple NW COURTYARD_HEARTS
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_NW_COURTYARD_HEARTS,
        world,
        {
            {
                Locations.FOREST_TEMPLE_WEST_COURTYARD_RIGHT_HEART,
                function(bundle)
                    return true
                end
            },
            {
                Locations.FOREST_TEMPLE_WEST_COURTYARD_LEFT_HEART,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple Courtyard Skulltula Island
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_NW_COURTYARD_SKULLTULA_ISLAND,
        world,
        {
            {
                Locations.FOREST_TEMPLE_GS_LEVEL_ISLAND_COURTYARD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple NE Outdoors Lower
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_NE_OUTDOORS_LOWER,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_NE_OUTDOORS_LOWER_DEKU_BABA_STICKS,
                Events.CAN_FARM_STICKS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_sticks(bundle)
                end
            },
            {
                EventLocations.FOREST_TEMPLE_NE_OUTDOORS_LOWER_DEKU_BABA_NUTS,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_nuts(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NE_OUTDOORS_LOWER,
        world,
        {
            {
                Regions.FOREST_TEMPLE_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_OUTDOORS_UPPER,
                function(bundle)
                    return (LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.FOREST_VINES, bundle) and
                            LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            },
            {
                Regions.FOREST_TEMPLE_WELL,
                function(bundle)
                    return ((LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)) or
                        LogicHelpers.has_item(LocalEvents.DRAINED_WELL, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_FALLING_ROOM,
                function(bundle)
                    return false
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_COURTYARD_SKULLTULA_ISLAND,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOOKSHOT, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_COURTYARD_SKULLTULA_ISLAND_GS,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.FOREST_OUTDOORS_EAST_GS, bundle) and
                            LogicHelpers.can_use(Items.BOOMERANG, bundle)))
                end
            }
        }
    )

    --Forest Temple NE Outdoors Upper
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_NE_OUTDOORS_UPPER,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_NE_OUTDOORS_UPPER_DRAIN_WELL,
                LocalEvents.DRAINED_WELL,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.FOREST_TEMPLE_NE_OUTDOORS_UPPER_DEKU_BABA_STICKS,
                Events.CAN_FARM_STICKS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_sticks(bundle)
                end
            },
            {
                EventLocations.FOREST_TEMPLE_NE_OUTDOORS_UPPER_DEKU_BABA_NUTS,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return LogicHelpers.can_get_deku_baba_nuts(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NE_OUTDOORS_UPPER,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NE_OUTDOORS_LOWER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_MAP_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_FALLING_ROOM,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.FOREST_DOORFRAME, bundle) and
                        LogicHelpers.can_jump_slash_except_hammer(bundle) and
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                        LogicHelpers.can_use(Items.SCARECROW, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_COURTYARD_SKULLTULA_ISLAND,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.FOREST_OUTDOORS_LEDGE, bundle) and
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))
                end
            }
        }
    )

    --Forest Temple NE Courtyard Skulltula Island
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_NE_COURTYARD_SKULLTULA_ISLAND,
        world,
        {
            {
                Locations.FOREST_TEMPLE_RAISED_ISLAND_COURTYARD_CHEST,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple NE Courtyard Skulltula Island GS
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_NE_COURTYARD_SKULLTULA_ISLAND_GS,
        world,
        {
            {
                Locations.FOREST_TEMPLE_GS_RAISED_ISLAND_COURTYARD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple Map Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_MAP_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_MAP_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.BLUE_BUBBLE)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_MAP_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_LOWER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.BLUE_BUBBLE)
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_OUTDOORS_UPPER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.BLUE_BUBBLE)
                end
            }
        }
    )

    --Forest Temple Well
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_WELL,
        world,
        {
            {
                Locations.FOREST_TEMPLE_WELL_CHEST,
                function(bundle)
                    return ((LogicHelpers.can_open_underwater_chest(bundle) and LogicHelpers.water_timer(bundle) >= 8) or
                        LogicHelpers.has_item(LocalEvents.DRAINED_WELL, bundle))
                end
            },
            {
                Locations.FOREST_TEMPLE_WELL_WEST_HEART,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 8) or
                        LogicHelpers.has_item(LocalEvents.DRAINED_WELL, bundle))
                end
            },
            {
                Locations.FOREST_TEMPLE_WELL_EAST_HEART,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.water_timer(bundle) >= 8) or
                        LogicHelpers.has_item(LocalEvents.DRAINED_WELL, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_WELL,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_LOWER,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.has_item(LocalEvents.DRAINED_WELL, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_OUTDOORS_LOWER,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.has_item(LocalEvents.DRAINED_WELL, bundle)
                end
            }
        }
    )

    --Forest Temple Below Boss Key Chest
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_BELOW_BOSS_KEY_CHEST,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_UPPER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.BLUE_BUBBLE)
                end
            }
        }
    )

    --Forest Temple Floormaster Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_FLOORMASTER_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_FLOORMASTER_CHEST,
                function(bundle)
                    return LogicHelpers.can_damage(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_FLOORMASTER_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_UPPER,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple West Corridor
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_WEST_CORRIDOR,
        world,
        {
            {
                Regions.FOREST_TEMPLE_LOBBY,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 1, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_BLOCK_PUSH_ROOM,
                function(bundle)
                    return (LogicHelpers.can_attack(bundle) or LogicHelpers.can_use(Items.NUTS, bundle))
                end
            }
        }
    )

    --Forest Temple Block Push Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_BLOCK_PUSH_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_EYE_SWITCH_CHEST,
                function(bundle)
                    return (LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                        (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_BLOCK_PUSH_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_WEST_CORRIDOR,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_OUTDOORS_UPPER,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.FOREST_OUTSIDE_BACKDOOR, bundle) and
                            LogicHelpers.can_jump_slash_except_hammer(bundle) and
                            LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_CORRIDOR_TWISTED,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                        LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 2, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_NW_CORRIDOR_STRAIGHTENED,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)) and
                        LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                        LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 2, bundle))
                end
            }
        }
    )

    --Forest Temple NW Corridor Twisted
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NW_CORRIDOR_TWISTED,
        world,
        {
            {
                Regions.FOREST_TEMPLE_BLOCK_PUSH_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_RED_POE_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 3, bundle)
                end
            }
        }
    )

    --Forest Temple NW Corridor Straightened
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_NW_CORRIDOR_STRAIGHTENED,
        world,
        {
            {
                Locations.FOREST_TEMPLE_BOSS_KEY_CHEST,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NW_CORRIDOR_STRAIGHTENED,
        world,
        {
            {
                Regions.FOREST_TEMPLE_BELOW_BOSS_KEY_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_BLOCK_PUSH_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 2, bundle)
                end
            }
        }
    )

    --Forest Temple Red Poe Room
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_RED_POE_ROOM,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_JOELLE,
                LocalEvents.DEFEATED_JOELLE,
                function(bundle)
                    return LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_RED_POE_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_RED_POE_CHEST,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DEFEATED_JOELLE, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_RED_POE_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NW_CORRIDOR_TWISTED,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 3, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_UPPER_STALFOS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple Upper Stalfos
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_UPPER_STALFOS,
        world,
        {
            {
                Locations.FOREST_TEMPLE_BOW_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 3)
                end
            },
            {
                Locations.FOREST_TEMPLE_UPPER_STALFOS_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_UPPER_STALFOS_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_UPPER_STALFOS_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_UPPER_STALFOS_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_UPPER_STALFOS,
        world,
        {
            {
                Regions.FOREST_TEMPLE_RED_POE_ROOM,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 3)
                end
            },
            {
                Regions.FOREST_TEMPLE_BLUE_POE_ROOM,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 3)
                end
            }
        }
    )

    --Forest Temple Blue Poe Room
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_BLUE_POE_ROOM,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_BETH,
                LocalEvents.DEFEATED_BETH,
                function(bundle)
                    return LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_BLUE_POE_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_BLUE_POE_CHEST,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DEFEATED_BETH, bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_BLUE_POE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_BLUE_POE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_BLUE_POE_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_BLUE_POE_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_UPPER_STALFOS,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_CORRIDOR_STRAIGHTENED,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 4, bundle)
                end
            }
        }
    )

    --Forest Temple NE Corridor Straightened
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NE_CORRIDOR_STRAIGHTENED,
        world,
        {
            {
                Regions.FOREST_TEMPLE_BLUE_POE_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 4, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_FROZEN_EYE_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 5, bundle)
                end
            }
        }
    )

    --Forest Temple NE Corridor Twisted
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_NE_CORRIDOR_TWISTED,
        world,
        {
            {
                Regions.FOREST_TEMPLE_FROZEN_EYE_ROOM,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 5, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_FALLING_ROOM,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple Frozen Eye Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_FROZEN_EYE_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_FROZEN_EYE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_FROZEN_EYE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_FROZEN_EYE_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NE_CORRIDOR_STRAIGHTENED,
                function(bundle)
                    return LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 5, bundle)
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_CORRIDOR_TWISTED,
                function(bundle)
                    return (LogicHelpers.small_keys(Items.FOREST_TEMPLE_SMALL_KEY, 5, bundle) and
                        (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle)))
                end
            }
        }
    )

    --Forest Temple Falling Room
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_FALLING_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_FALLING_CEILING_ROOM_CHEST,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_FALLING_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_NE_OUTDOORS_LOWER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_GREEN_POE_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_COURTYARD_SKULLTULA_ISLAND,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_NE_COURTYARD_SKULLTULA_ISLAND_GS,
                function(bundle)
                    return (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                        LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                        LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                        LogicHelpers.has_explosives(bundle))
                end
            }
        }
    )

    --Forest Temple Green Poe Room
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_GREEN_POE_ROOM,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_AMY,
                LocalEvents.DEFEATED_AMY,
                function(bundle)
                    return LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_GREEN_POE_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_GREEN_POE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.FOREST_TEMPLE_GREEN_POE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_GREEN_POE_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_FALLING_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_EAST_CORRIDOR,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DEFEATED_AMY, bundle)
                end
            }
        }
    )

    --Foest Temple East Corridor
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_EAST_CORRIDOR,
        world,
        {
            {
                Regions.FOREST_TEMPLE_LOBBY,
                function(bundle)
                    return (LogicHelpers.can_attack(bundle) or LogicHelpers.can_use(Items.NUTS, bundle))
                end
            },
            {
                Regions.FOREST_TEMPLE_GREEN_POE_ROOM,
                function(bundle)
                    return (LogicHelpers.can_attack(bundle) or LogicHelpers.can_use(Items.NUTS, bundle))
                end
            }
        }
    )

    --Forest Temple Boss Region
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_BOSS_REGION,
        world,
        {
            {
                Locations.FOREST_TEMPLE_BASEMENT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.FOREST_TEMPLE_GS_BASEMENT,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_BOSS_REGION,
        world,
        {
            {
                Regions.FOREST_TEMPLE_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.FOREST_TEMPLE_BOSS_ENTRYWAY,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Forest Temple Boss Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_BOSS_ENTRYWAY,
        world,
        {
            {
                Regions.FOREST_TEMPLE_BOSS_REGION,
                function(bundle)
                    return false
                end
            },
            --Todo: Connect to MQ_BOSS_REGION
            {
                Regions.FOREST_TEMPLE_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(Items.FOREST_TEMPLE_BOSS_KEY, bundle)
                end
            }
        }
    )

    --Forest Temple Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.FOREST_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                EventLocations.FOREST_TEMPLE_PHANTOM_GANON,
                Events.FOREST_TEMPLE_COMPLETED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.PHANTOM_GANON)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.FOREST_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                Locations.FOREST_TEMPLE_PHANTOM_GANON_HEART_CONTAINER,
                function(bundle)
                    return LogicHelpers.has_item(Events.FOREST_TEMPLE_COMPLETED, bundle)
                end
            },
            {
                Locations.PHANTOM_GANON,
                function(bundle)
                    return LogicHelpers.has_item(Events.FOREST_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.FOREST_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                Regions.FOREST_TEMPLE_BOSS_ENTRYWAY,
                function(bundle)
                    return false
                end
            },
            {
                Regions.SACRED_FOREST_MEADOW,
                function(bundle)
                    return LogicHelpers.has_item(Events.FOREST_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
end

return set_region_rules
