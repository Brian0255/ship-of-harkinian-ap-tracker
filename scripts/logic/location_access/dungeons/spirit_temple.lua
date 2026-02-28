local EventLocations = {
    SPIRIT_TEMPLE_BEGINNING_NUT_CRATE = "Spirit Temple Nut Crate",
    SPIRIT_TEMPLE_TWINROVA = "Spirit Temple Twinrova"
}

local function set_region_rules(world)
    --Spirit Temple Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_ENTRYWAY,
        world,
        {
            {Regions.SPIRIT_TEMPLE_LOBBY, function(bundle)
                    return true
                end},
            {Regions.DESERT_COLOSSUS_OUTSIDE_TEMPLE, function(bundle)
                    return true
                end}
        }
    )

    --Spirit Temple Lobby
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_LOBBY,
        world,
        {
            {Locations.SPIRIT_TEMPLE_LOBBY_POT1, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.SPIRIT_TEMPLE_LOBBY_POT2, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_LOBBY,
        world,
        {
            {Regions.SPIRIT_TEMPLE_ENTRYWAY, function(bundle)
                    return true
                end},
            {Regions.SPIRIT_TEMPLE_CHILD, function(bundle)
                    return LogicHelpers.is_child(bundle)
                end},
            {
                Regions.SPIRIT_TEMPLE_EARLY_ADULT,
                function(bundle)
                    return LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)
                end
            }
        }
    )

    --Spirit Temple Child
    --Events
    LogicHelpers.add_events(
        Regions.SPIRIT_TEMPLE_CHILD,
        world,
        {
            {
                EventLocations.SPIRIT_TEMPLE_BEGINNING_NUT_CRATE,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_CHILD,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_CHILD_BRIDGE_CHEST,
                function(bundle)
                    return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.FAIRY_SLINGSHOT}, bundle) or
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_CHILD_CHU, bundle))) and
                        (LogicHelpers.has_explosives(bundle) or
                            ((LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle)) and
                                (LogicHelpers.can_use_any({Items.STICKS, Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle))))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CHILD_EARLY_TORCHES_CHEST,
                function(bundle)
                    return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.FAIRY_SLINGSHOT}, bundle) or
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_CHILD_CHU, bundle))) and
                        (LogicHelpers.has_explosives(bundle) or
                            ((LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle)) and
                                (LogicHelpers.can_use_any({Items.STICKS, Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle)))) and
                        (LogicHelpers.can_use_any({Items.STICKS, Items.DINS_FIRE}, bundle))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_GS_METAL_FENCE,
                function(bundle)
                    return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.FAIRY_SLINGSHOT}, bundle) or
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_CHILD_CHU, bundle))) and
                        (LogicHelpers.has_explosives(bundle) or
                            ((LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle)) and
                                (LogicHelpers.can_use_any({Items.STICKS, Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle))))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_ANUBIS_POT1,
                function(bundle)
                    return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.FAIRY_SLINGSHOT}, bundle) or
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_CHILD_CHU, bundle))) and
                        (LogicHelpers.has_explosives(bundle) or
                            ((LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle)) and
                                (LogicHelpers.can_use_any({Items.STICKS, Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle))))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_ANUBIS_POT2,
                function(bundle)
                    return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.FAIRY_SLINGSHOT}, bundle) or
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_CHILD_CHU, bundle))) and
                        (LogicHelpers.has_explosives(bundle) or
                            ((LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle)) and
                                (LogicHelpers.can_use_any({Items.STICKS, Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle))))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_ANUBIS_POT3,
                function(bundle)
                    return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.FAIRY_SLINGSHOT}, bundle) or
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_CHILD_CHU, bundle))) and
                        (LogicHelpers.has_explosives(bundle) or
                            ((LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle)) and
                                (LogicHelpers.can_use_any({Items.STICKS, Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle))))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_ANUBIS_POT4,
                function(bundle)
                    return (LogicHelpers.can_use_any({Items.BOOMERANG, Items.FAIRY_SLINGSHOT}, bundle) or
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_CHILD_CHU, bundle))) and
                        (LogicHelpers.has_explosives(bundle) or
                            ((LogicHelpers.can_use_any({Items.NUTS, Items.BOOMERANG}, bundle)) and
                                (LogicHelpers.can_use_any({Items.STICKS, Items.KOKIRI_SWORD, Items.FAIRY_SLINGSHOT}, bundle))))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_BEFORE_CHILD_CLIMB_SMALL_CRATE1,
                function(bundle)
                    return LogicHelpers.can_break_small_crates(bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_BEFORE_CHILD_CLIMB_SMALL_CRATE2,
                function(bundle)
                    return LogicHelpers.can_break_small_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_CHILD,
        world,
        {
            {
                Regions.SPIRIT_TEMPLE_CHILD_CLIMB,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 1, bundle)
                end
            }
        }
    )

    --Spirit Temple Child Climb
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_CHILD_CLIMB,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_CHILD_CLIMB_NORTH_CHEST,
                function(bundle)
                    return LogicHelpers.has_projectile(bundle) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                            LogicHelpers.has_projectile(bundle, Ages.ADULT)) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and LogicHelpers.is_child(bundle) and
                            LogicHelpers.has_projectile(bundle, Ages.CHILD))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CHILD_CLIMB_EAST_CHEST,
                function(bundle)
                    return LogicHelpers.has_projectile(bundle) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                            LogicHelpers.has_projectile(bundle, Ages.ADULT)) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and LogicHelpers.is_child(bundle) and
                            LogicHelpers.has_projectile(bundle, Ages.CHILD))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_GS_SUN_ON_FLOOR_ROOM,
                function(bundle)
                    return LogicHelpers.has_projectile(bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                        (LogicHelpers.take_damage(bundle) and
                            (LogicHelpers.can_jump_slash_except_hammer(bundle) or
                                LogicHelpers.has_projectile(bundle, Ages.CHILD))) or
                        (LogicHelpers.is_child(bundle) and LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and
                            LogicHelpers.has_projectile(bundle, Ages.CHILD)) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                            (LogicHelpers.has_projectile(bundle, Ages.ADULT) or
                                (LogicHelpers.take_damage(bundle) and LogicHelpers.can_jump_slash_except_hammer(bundle))))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CHILD_CLIMB_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_CHILD_CLIMB,
        world,
        {
            {
                Regions.SPIRIT_TEMPLE_CENTRAL_CHAMBER,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle) or
                        (world:get_option("sunlight_arrows") and LogicHelpers.can_use(Items.LIGHT_ARROW, bundle))
                end
            }
        }
    )

    --Spirit Temple Early Adult
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_EARLY_ADULT,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_COMPASS_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                        LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_EARLY_ADULT_RIGHT_CHEST,
                function(bundle)
                    return (LogicHelpers.can_use_any(
                        {Items.FAIRY_BOW, Items.HOOKSHOT, Items.FAIRY_SLINGSHOT, Items.BOOMERANG, Items.BOMBCHUS_5},
                        bundle
                    ) or
                        (LogicHelpers.can_use(Items.BOMB_BAG, bundle) and LogicHelpers.is_adult(bundle) and
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_LOWER_ADULT_SWITCH, bundle))) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_jump_slash_except_hammer(bundle))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_FIRST_MIRROR_LEFT_CHEST,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_FIRST_MIRROR_RIGHT_CHEST,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_GS_BOULDER_ROOM,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) and
                        (LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT, Items.BOMBCHUS_5}, bundle) or
                            (LogicHelpers.can_use(Items.BOMB_BAG, bundle) and
                                LogicHelpers.can_do_trick(Tricks.SPIRIT_LOWER_ADULT_SWITCH, bundle)))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_AFTER_BOULDER_ROOM_SUNS_SONG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle) and
                        (LogicHelpers.can_use_any(
                            {Items.FAIRY_BOW, Items.HOOKSHOT, Items.FAIRY_SLINGSHOT, Items.BOOMERANG, Items.BOMBCHUS_5},
                            bundle
                        ) or
                            (LogicHelpers.can_use(Items.BOMB_BAG, bundle) and LogicHelpers.is_adult(bundle) and
                                LogicHelpers.can_do_trick(Tricks.SPIRIT_LOWER_ADULT_SWITCH, bundle))) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_jump_slash(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_EARLY_ADULT,
        world,
        {
            {
                Regions.SPIRIT_TEMPLE_CENTRAL_CHAMBER,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 1, bundle)
                end
            }
        }
    )

    --Spirit Temple Central Chamber
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_CENTRAL_CHAMBER,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_MAP_CHEST,
                function(bundle)
                    return ((LogicHelpers.has_explosives(bundle) or
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)) and
                        (LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                            ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                                LogicHelpers.can_do_trick(Tricks.SPIRIT_MAP_CHEST, bundle)) and
                                LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                                LogicHelpers.can_use(Items.STICKS, bundle)))) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and
                            LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_use(Items.STICKS, bundle)) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle) and
                            (LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                                (LogicHelpers.can_do_trick(Tricks.SPIRIT_MAP_CHEST, bundle) and
                                    LogicHelpers.can_use(Items.FAIRY_BOW, bundle))) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_SUN_BLOCK_ROOM_CHEST,
                function(bundle)
                    return ((LogicHelpers.has_explosives(bundle) or
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)) and
                        (LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                            ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                                LogicHelpers.can_do_trick(Tricks.SPIRIT_SUN_CHEST, bundle)) and
                                LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                                LogicHelpers.can_use(Items.STICKS, bundle)))) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and
                            LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_use(Items.STICKS, bundle)) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle) and
                            (LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                                (LogicHelpers.can_do_trick(Tricks.SPIRIT_SUN_CHEST, bundle) and
                                    LogicHelpers.can_use(Items.FAIRY_BOW, bundle))) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_STATUE_ROOM_HAND_CHEST,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle) and
                        LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                        LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_STATUE_ROOM_NORTHEAST_CHEST,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle) and
                        LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                        LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) and
                        (LogicHelpers.can_use_any({Items.HOOKSHOT, Items.HOVER_BOOTS}, bundle) or
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_LOBBY_JUMP, bundle))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_GS_HALL_AFTER_SUN_BLOCK_ROOM,
                function(bundle)
                    return (LogicHelpers.has_explosives(bundle) and LogicHelpers.can_use(Items.BOOMERANG, bundle) and
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)) or
                        (LogicHelpers.can_use(Items.BOOMERANG, bundle) and
                            LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and
                            LogicHelpers.has_explosives(bundle)) or
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                            LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_GS_LOBBY,
                function(bundle)
                    return ((LogicHelpers.has_explosives(bundle) or
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)) and
                        LogicHelpers.can_do_trick(Tricks.SPIRIT_LOBBY_GS, bundle) and
                        LogicHelpers.can_use(Items.BOOMERANG, bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            LogicHelpers.can_do_trick(Tricks.SPIRIT_LOBBY_JUMP, bundle))) or
                        (LogicHelpers.can_do_trick(Tricks.SPIRIT_LOBBY_GS, bundle) and
                            LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and
                            LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_use(Items.BOOMERANG, bundle)) or
                        (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                            (LogicHelpers.can_use_any({Items.HOOKSHOT, Items.HOVER_BOOTS}, bundle) or
                                LogicHelpers.can_do_trick(Tricks.SPIRIT_LOBBY_JUMP, bundle)))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_AFTER_SUN_BLOCK_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_AFTER_SUN_BLOCK_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CENTRAL_CHAMBER_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CENTRAL_CHAMBER_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CENTRAL_CHAMBER_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CENTRAL_CHAMBER_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CENTRAL_CHAMBER_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_CENTRAL_CHAMBER_POT6,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 2, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_CENTRAL_CHAMBER,
        world,
        {
            {
                Regions.SPIRIT_TEMPLE_OUTDOOR_HANDS,
                function(bundle)
                    return LogicHelpers.can_jump_slash_except_hammer(bundle) or LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Regions.SPIRIT_TEMPLE_BEYOND_CENTRAL_LOCKED_DOOR,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 4, bundle) and
                        LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)
                end
            },
            {Regions.SPIRIT_TEMPLE_CHILD_CLIMB, function(bundle)
                    return true
                end},
            {
                Regions.SPIRIT_TEMPLE_INSIDE_STATUE_HEAD,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.SPIRIT_PLATFORM_HOOKSHOT, bundle) and
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            }
        }
    )

    --Spirit Temple Outdoor Hands
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_OUTDOOR_HANDS,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_SILVER_GAUNTLETS_CHEST,
                function(bundle)
                    return (LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle) and
                        LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                        LogicHelpers.has_explosives(bundle)) or
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_MIRROR_SHIELD_CHEST,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 4, bundle) and
                        LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                        LogicHelpers.has_explosives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_OUTDOOR_HANDS,
        world,
        {
            {
                Regions.DESERT_COLOSSUS,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle)) or
                        (LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and
                            ((LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 3, bundle) and
                                LogicHelpers.has_explosives(bundle)) or
                                LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle)))
                end
            }
        }
    )

    --Spirit Temple Beyond Central Locked Door
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_BEYOND_CENTRAL_LOCKED_DOOR,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_NEAR_FOUR_ARMOS_CHEST,
                function(bundle)
                    return (LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) or
                        (world:get_option("sunlight_arrows") and LogicHelpers.can_use(Items.LIGHT_ARROW, bundle))) and
                        LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_HALLWAY_LEFT_INVISIBLE_CHEST,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.LENS_SPIRIT, bundle) or
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)) and
                        LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_HALLWAY_RIGHT_INVISIBLE_CHEST,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.LENS_SPIRIT, bundle) or
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)) and
                        LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_BEAMOS_HALL_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_FOUR_ARMOS_ROOM_SUNS_SONG_FAIRY,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle) and LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_BEYOND_CENTRAL_LOCKED_DOOR,
        world,
        {
            {
                Regions.SPIRIT_TEMPLE_BEYOND_FINAL_LOCKED_DOOR,
                function(bundle)
                    return LogicHelpers.small_keys(Items.SPIRIT_TEMPLE_SMALL_KEY, 5, bundle) and
                        (LogicHelpers.can_do_trick(Tricks.SPIRIT_WALL, bundle) or
                            LogicHelpers.can_use_any({Items.LONGSHOT, Items.BOMBCHUS_5}, bundle) or
                            ((LogicHelpers.can_use_any({Items.BOMB_BAG, Items.NUTS, Items.DINS_FIRE}, bundle)) and
                                (LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT, Items.MEGATON_HAMMER}, bundle))))
                end
            }
        }
    )

    --Spirit Temple Beyond Final Locked Door
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_BEYOND_FINAL_LOCKED_DOOR,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_BOSS_KEY_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) and
                        ((LogicHelpers.take_damage(bundle) and LogicHelpers.can_do_trick(Tricks.FLAMING_CHESTS, bundle)) or
                            (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_TOPMOST_CHEST,
                function(bundle)
                    return (LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) and
                        (LogicHelpers.can_jump_slash(bundle) or LogicHelpers.has_explosives(bundle) or
                            (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                                (LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT, Items.HOOKSHOT}, bundle))))) or
                        (world:get_option("sunlight_arrows") and LogicHelpers.can_use(Items.LIGHT_ARROW, bundle))
                end
            },
            {
                Locations.SPIRIT_TEMPLE_ADULT_CLIMB_LEFT_HEART,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {
                Locations.SPIRIT_TEMPLE_ADULT_CLIMB_RIGHT_HEART,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_BEYOND_FINAL_LOCKED_DOOR,
        world,
        {
            {
                Regions.SPIRIT_TEMPLE_INSIDE_STATUE_HEAD,
                function(bundle)
                    return LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) and LogicHelpers.has_explosives(bundle) and
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            }
        }
    )

    --Spirit Temple Inside Statue Head
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_INSIDE_STATUE_HEAD,
        world,
        {
            {Regions.SPIRIT_TEMPLE_CENTRAL_CHAMBER, function(bundle)
                    return true
                end},
            {Regions.SPIRIT_TEMPLE_BOSS_ENTRYWAY, function(bundle)
                    return true
                end}
        }
    )

    --Spirit Temple Boss Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_BOSS_ENTRYWAY,
        world,
        {
            {Regions.SPIRIT_TEMPLE_INSIDE_STATUE_HEAD, function(bundle)
                    return false
                end},
            {
                Regions.SPIRIT_TEMPLE_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(Items.SPIRIT_TEMPLE_BOSS_KEY, bundle)
                end
            }
        }
    )

    --Spirit Temple Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.SPIRIT_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                EventLocations.SPIRIT_TEMPLE_TWINROVA,
                Events.SPIRIT_TEMPLE_COMPLETED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.TWINROVA)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.SPIRIT_TEMPLE_BOSS_ROOM,
        world,
        {
            {
                Locations.SPIRIT_TEMPLE_TWINROVA_HEART_CONTAINER,
                function(bundle)
                    return LogicHelpers.has_item(Events.SPIRIT_TEMPLE_COMPLETED, bundle)
                end
            },
            {
                Locations.TWINROVA,
                function(bundle)
                    return LogicHelpers.has_item(Events.SPIRIT_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SPIRIT_TEMPLE_BOSS_ROOM,
        world,
        {
            {Regions.SPIRIT_TEMPLE_BOSS_ENTRYWAY, function(bundle)
                    return false
                end},
            {
                Regions.DESERT_COLOSSUS,
                function(bundle)
                    return LogicHelpers.has_item(Events.SPIRIT_TEMPLE_COMPLETED, bundle)
                end
            }
        }
    )
end

return set_region_rules
