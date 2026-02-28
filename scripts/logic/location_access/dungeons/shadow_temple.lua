local EventLocations = {
    SHADOW_TEMPLE_BEGINNING_NUT_POT = "Shadow Temple Beginning Nut Pot",
    SHADOW_TEMPLE_FAIRY_POT = "Shadow Temple Fairy Pot",
    SHADOW_TEMPLE_BONGO_BONGO = "Shadow Temple Bongo Bongo"
}

local function set_region_rules(world)
    --Shadow Temple Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_ENTRYWAY,
        world,
        {
            {
                Regions.SHADOW_TEMPLE_BEGINNING,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.LENS_SHADOW, bundle) or
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle))
                end
            },
            {Regions.GRAVEYARD_WARP_PAD_REGION, function(bundle)
                    return true
                end}
        }
    )

    --Shadow Temple Beginning
    --Events
    LogicHelpers.add_events(
        Regions.SHADOW_TEMPLE_BEGINNING,
        world,
        {
            {
                EventLocations.SHADOW_TEMPLE_BEGINNING_NUT_POT,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.SHADOW_TEMPLE_BEGINNING,
        world,
        {
            {
                Locations.SHADOW_TEMPLE_MAP_CHEST,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_HOVER_BOOTS_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.DEAD_HAND)
                end
            },
            {
                Locations.SHADOW_TEMPLE_NEAR_DEAD_HAND_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_WHISPERING_WALLS_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_WHISPERING_WALLS_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_WHISPERING_WALLS_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_WHISPERING_WALLS_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_WHISPERING_WALLS_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_MAP_CHEST_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_MAP_CHEST_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_BEGINNING,
        world,
        {
            {Regions.SHADOW_TEMPLE_ENTRYWAY, function(bundle)
                    return true
                end},
            {
                Regions.SHADOW_TEMPLE_FIRST_BEAMOS,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            }
        }
    )

    --Shadow Temple First Beamos
    --Locations
    LogicHelpers.add_locations(
        Regions.SHADOW_TEMPLE_FIRST_BEAMOS,
        world,
        {
            {
                Locations.SHADOW_TEMPLE_COMPASS_CHEST,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_EARLY_SILVER_RUPEE_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_BEAMOS_SONG_OF_STORMS_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_FIRST_BEAMOS,
        world,
        {
            {
                Regions.SHADOW_TEMPLE_HUGE_PIT,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle) and LogicHelpers.is_adult(bundle) and
                        LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 1, bundle)
                end
            },
            {Regions.SHADOW_TEMPLE_BEYOND_BOAT, function(bundle)
                    return false
                end}
        }
    )

    --Shadow Temple Huge Pit
    --Locations
    LogicHelpers.add_locations(
        Regions.SHADOW_TEMPLE_HUGE_PIT,
        world,
        {
            {
                Locations.SHADOW_TEMPLE_INVISIBLE_BLADES_VISIBLE_CHEST,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_INVISIBLE_BLADES_INVISIBLE_CHEST,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle)
                end
            },
            {Locations.SHADOW_TEMPLE_FALLING_SPIKES_LOWER_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.SHADOW_TEMPLE_FALLING_SPIKES_UPPER_CHEST,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_HOVER, bundle) and
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) or
                        LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_CLIP, bundle) or
                        LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_FALLING_SPIKES_SWITCH_CHEST,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_HOVER, bundle) and
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) or
                        LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_CLIP, bundle) or
                        LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_INVISIBLE_SPIKES_CHEST,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 2, bundle) and
                        ((LogicHelpers.can_do_trick(Tricks.LENS_SHADOW_PLATFORM, bundle) and
                            LogicHelpers.can_do_trick(Tricks.LENS_SHADOW, bundle)) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))
                end
            },
            {
                Locations.SHADOW_TEMPLE_FREESTANDING_KEY,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 2, bundle) and
                        ((LogicHelpers.can_do_trick(Tricks.LENS_SHADOW_PLATFORM, bundle) and
                            LogicHelpers.can_do_trick(Tricks.LENS_SHADOW, bundle)) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)) and
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                        (LogicHelpers.can_use(Items.BOMB_BAG, bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.SHADOW_FREESTANDING_KEY, bundle) and
                                LogicHelpers.can_use(Items.BOMBCHUS_5, bundle)))
                end
            },
            {
                Locations.SHADOW_TEMPLE_GS_LIKE_LIKE_ROOM,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_GS_FALLING_SPIKES_ROOM,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_GS, bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                            LogicHelpers.can_standing_shield(bundle) and
                            LogicHelpers.can_use(Items.MASTER_SWORD, bundle)) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_ground_jump(bundle))
                end
            },
            {
                Locations.SHADOW_TEMPLE_GS_SINGLE_GIANT_POT,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 2, bundle) and
                        ((LogicHelpers.can_do_trick(Tricks.LENS_SHADOW_PLATFORM, bundle) and
                            LogicHelpers.can_do_trick(Tricks.LENS_SHADOW, bundle)) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) and
                                LogicHelpers.can_use(Items.HOOKSHOT, bundle))
                end
            },
            {
                Locations.SHADOW_TEMPLE_FALLING_SPIKES_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_FALLING_SPIKES_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_FALLING_SPIKES_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_HOVER, bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) or
                        LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_CLIP, bundle) or
                        LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_FALLING_SPIKES_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_HOVER, bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) or
                        LogicHelpers.can_do_trick(Tricks.SHADOW_UMBRELLA_CLIP, bundle) or
                        LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_INVISIBLE_BLADES_LEFT_HEART,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) and LogicHelpers.is_adult(bundle)) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_INVISIBLE_BLADES_RIGHT_HEART,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) and LogicHelpers.is_adult(bundle)) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_PIT_ROOM_SONG_OF_STORMS_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_HUGE_PIT,
        world,
        {
            {
                Regions.SHADOW_TEMPLE_WIND_TUNNEL,
                function(bundle)
                    return ((LogicHelpers.can_do_trick(Tricks.LENS_SHADOW_PLATFORM, bundle) and
                        LogicHelpers.can_do_trick(Tricks.LENS_SHADOW, bundle)) or
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.GROUND_JUMP_HARD, bundle) and
                                LogicHelpers.can_ground_jump(bundle))) and
                        LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 3, bundle)
                end
            }
        }
    )

    --Shadow Temple Wind Tunnel
    --Locations
    LogicHelpers.add_locations(
        Regions.SHADOW_TEMPLE_WIND_TUNNEL,
        world,
        {
            {Locations.SHADOW_TEMPLE_WIND_HINT_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.SHADOW_TEMPLE_AFTER_WIND_ENEMY_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GIBDO, EnemyDistance.CLOSE, true, 2)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_WIND_HIDDEN_CHEST,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_GS_NEAR_SHIP,
                function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                        LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 4, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_WIND_HINT_SUNS_SONG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_WIND_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_WIND_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_SCARECROW_NEAR_SHIP_NORTH_HEART,
                function(bundle)
                    return LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) and
                        LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 4, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_SCARECROW_NEAR_SHIP_SOUTH_HEART,
                function(bundle)
                    return LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) and
                        LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 4, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_WIND_TUNNEL,
        world,
        {
            {
                Regions.SHADOW_TEMPLE_BEYOND_BOAT,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle) and
                        LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) and
                        LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 4, bundle)
                end
            }
        }
    )

    --Shadow Temple Beyond Boat
    --Locations
    LogicHelpers.add_locations(
        Regions.SHADOW_TEMPLE_BEYOND_BOAT,
        world,
        {
            {
                Locations.SHADOW_TEMPLE_SPIKE_WALLS_LEFT_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.DINS_FIRE, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_BOSS_KEY_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.DINS_FIRE, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_INVISIBLE_FLOORMASTER_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.FLOORMASTER)
                end
            },
            {
                Locations.SHADOW_TEMPLE_GS_TRIPLE_GIANT_POT,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_BOAT_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_BOAT_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_BOAT_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                            LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.SHADOW_STATUE, bundle) and
                                LogicHelpers.can_use(Items.BOMBCHUS_5, bundle)))
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_BOAT_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                            LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.SHADOW_STATUE, bundle) and
                                LogicHelpers.can_use(Items.BOMBCHUS_5, bundle)))
                end
            },
            {
                Locations.SHADOW_TEMPLE_SPIKE_WALLS_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_FLOORMASTER_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_FLOORMASTER_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_SHIP_UPPER_LEFT_HEART,
                function(bundle)
                    return LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_SHIP_UPPER_RIGHT_HEART,
                function(bundle)
                    return LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle)
                end
            },
            {
                Locations.SHADOW_TEMPLE_AFTER_SHIP_LOWER_HEART,
                function(bundle)
                    return (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                        LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.SHADOW_STATUE, bundle) and
                            LogicHelpers.can_use(Items.BOMBCHUS_5, bundle))) and
                        LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or
                        (LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_BEYOND_BOAT,
        world,
        {
            {
                Regions.SHADOW_TEMPLE_BOSS_ENTRYWAY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                        LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.SHADOW_STATUE, bundle) and
                            LogicHelpers.can_use(Items.BOMBCHUS_5, bundle))) and
                        LogicHelpers.small_keys(Items.SHADOW_TEMPLE_SMALL_KEY, 5, bundle) and
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            }
        }
    )

    --Shadow Temple Boss Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_BOSS_ENTRYWAY,
        world,
        {
            {Regions.SHADOW_TEMPLE_BEYOND_BOAT, function(bundle)
                    return false
                end},
            {
                Regions.SHADOW_TEMPLE_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(Items.SHADOW_TEMPLE_BOSS_KEY, bundle)
                end
            }
        }
    )

    --Shadow Temple Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.SHADOW_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                EventLocations.SHADOW_TEMPLE_BONGO_BONGO,
                Events.SHADOW_TEMPLE_COMPLETED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.BONGO_BONGO)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.SHADOW_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                Locations.SHADOW_TEMPLE_BONGO_BONGO_HEART_CONTAINER,
                function(bundle)
                    return LogicHelpers.has_item(Events.SHADOW_TEMPLE_COMPLETED, bundle)
                end
            },
            {
                Locations.BONGO_BONGO,
                function(bundle)
                    return LogicHelpers.has_item(Events.SHADOW_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SHADOW_TEMPLE_BOSS_ROOM,
        world,
        {
            {Regions.SHADOW_TEMPLE_BOSS_ENTRYWAY, function(bundle)
                    return false
                end},
            {
                Regions.GRAVEYARD_WARP_PAD_REGION,
                function(bundle)
                    return LogicHelpers.has_item(Events.SHADOW_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
end

return set_region_rules
