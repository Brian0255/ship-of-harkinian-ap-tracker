local EventLocations = {
    DODONGOS_CAVERN_GOSSIP_STONE_SONG_FAIRY = "Dodongos Cavern Gossip Stone Song Fairy",
    DODONGOS_CAVERN_LOBBY_SWITCH = "Dodongos Cavern Lobby Switch",
    DODONGOS_CAVERN_LOWER_LIZALFOS_FIGHT = "Dodongos Cavern Lower Lizalfos Fight",
    DODONGOS_CAVERN_LIFT_SWITCH = "Dodongos Cavern Lift Switch",
    DODONGOS_CAVERN_EYES = "Dodongos Cavern Eyes",
    DODONGOS_CAVERN_FAIRY_POT = "Dodongos Cavern Fairy Pot",
    DODONGOS_CAVERN_KING_DODONGO = "Dodongos Cavern King Dodongo"
}

local LocalEvents = {
    DODONGOS_CAVERN_STAIRS_ROOM_DOOR = "Dodongos Cavern Stairs Room Door",
    DODONGOS_CAVERN_LIFT_PLATFORM = "Dodongos Cavern Lift Platform",
    DODONGOS_CAVERN_EYES_LIT = "Dodongos Cavern Eyes Lit",
    DODONGOS_CAVERN_LOWER_LIZALFOS_DEFEATED = "Dodongos Cavern Lower Lizalfos Defeated"
}

local function set_region_rules(world)
    --Dodongos Cavern Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_ENTRYWAY,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BEGINNING,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DEATH_MOUNTAIN_TRAIL,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Beginning
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BEGINNING,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_ENTRYWAY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_LOBBY,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            }
        }
    )

    --Dodongos Cavern Lobby
    --Events
    LogicHelpers.add_events(
        Regions.DODONGOS_CAVERN_LOBBY,
        world,
        {
            {
                EventLocations.DODONGOS_CAVERN_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)) and
                        LogicHelpers.call_gossip_fairy(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_LOBBY,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_MAP_CHEST,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)

                end
            },
            {
                Locations.DODONGOS_CAVERN_DEKU_SCRUB_LOBBY,
                function(bundle)
                    return (LogicHelpers.can_stun_deku(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                    and LogicHelpers.can_afford_item("scrub_prices",Locations.DODONGOS_CAVERN_DEKU_SCRUB_LOBBY,bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)) and
                        LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_LOBBY,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BEGINNING,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_LOBBY_SWITCH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.can_ground_jump(bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_SE_CORRIDOR,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_STAIRS_LOWER,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_STAIRS_ROOM_DOOR, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_FAR_BRIDGE,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_LIFT_PLATFORM, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_BOSS_REGION,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_EYES_LIT, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_BOSS_ENTRYWAY,
                function(bundle)
                    return false
                end
            }
        }
    )

    --Dodongos Cavern Lobby Switch
    --Events
    LogicHelpers.add_events(
        Regions.DODONGOS_CAVERN_LOBBY_SWITCH,
        world,
        {
            {
                EventLocations.DODONGOS_CAVERN_LOBBY_SWITCH,
                LocalEvents.DODONGOS_CAVERN_STAIRS_ROOM_DOOR,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_LOBBY_SWITCH,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_DODONGO_ROOM,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern SE Corridor
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_SE_CORRIDOR,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_GS_SCARECROW,
                function(bundle)
                    return LogicHelpers.can_use(Items.SCARECROW, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.LONGSHOT, bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.DC_SCARECROW_GS, bundle) and LogicHelpers.can_attack(bundle))
                end
            },
            {
                Locations.DODONGOS_CAVERN_SIDE_ROOM_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_SIDE_ROOM_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_SIDE_ROOM_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_SIDE_ROOM_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_SIDE_ROOM_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_SIDE_ROOM_POT6,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_SE_CORRIDOR,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_SE_ROOM,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.can_attack(bundle) or
                        (LogicHelpers.take_damage(bundle) and LogicHelpers.can_shield(bundle))
                end
            },
            {
                Regions.DODONGOS_CAVERN_NEAR_LOWER_LIZALFOS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern SE Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_SE_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_GS_SIDE_ROOM_NEAR_LOWER_LIZALFOS,
                function(bundle)
                    return LogicHelpers.can_attack(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_SE_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_SE_CORRIDOR,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Near Lower Lizalfos
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_NEAR_LOWER_LIZALFOS,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_SE_CORRIDOR,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_LOWER_LIZALFOS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Lower Lizalfos
    --Events
    LogicHelpers.add_events(
        Regions.DODONGOS_CAVERN_LOWER_LIZALFOS,
        world,
        {
            {
                EventLocations.DODONGOS_CAVERN_LOWER_LIZALFOS_FIGHT,
                LocalEvents.DODONGOS_CAVERN_LOWER_LIZALFOS_DEFEATED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.LIZALFOS, EnemyDistance.CLOSE, true, 2)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_LOWER_LIZALFOS,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_NEAR_LOWER_LIZALFOS,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_LOWER_LIZALFOS_DEFEATED, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_DODONGO_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_LOWER_LIZALFOS_DEFEATED, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_LOWER_LIZALFOS_LOCATIONS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Lower Lizalfos Locations
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_LOWER_LIZALFOS_LOCATIONS,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_LIZALFOS_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_LIZALFOS_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_LIZALFOS_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_LIZALFOS_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_LOWER_LIZALFOS_ROOM_LAVAFALL_HEART,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Dodongo Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_DODONGO_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_TORCH_ROOM_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_TORCH_ROOM_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_TORCH_ROOM_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_TORCH_ROOM_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_DODONGO_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_LOBBY_SWITCH,
                function(bundle)
                    return LogicHelpers.has_fire_source_with_torch(bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_LOWER_LIZALFOS,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_NEAR_DODONGO_ROOM,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            }
        }
    )

    --Dodongos Cavern Near Dodongo Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_NEAR_DODONGO_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_DEKU_SCRUB_SIDE_ROOM_NEAR_DODONGOS,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices",Locations.DODONGOS_CAVERN_DEKU_SCRUB_SIDE_ROOM_NEAR_DODONGOS,bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_NEAR_DODONGO_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_DODONGO_ROOM,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Stairs Lower
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_STAIRS_LOWER,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_STAIRS_UPPER,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or
                        LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.DC_STAIRS_WITH_BOW, bundle) and
                            LogicHelpers.can_use(Items.FAIRY_BOW, bundle))
                end
            },
            {
                Regions.DODONGOS_CAVERN_COMPASS_ROOM,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_VINES_ABOVE_STAIRS_GS,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.DC_VINES_GS, bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.LONGSHOT)
                end
            }
        }
    )

    --Dodongos Cavern Stairs Upper
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_STAIRS_UPPER,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_GS_ALCOVE_ABOVE_STAIRS,
                function(bundle)
                    return LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.LONGSHOT) or
                        (LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_LIFT_PLATFORM, bundle) and
                            LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG))
                end
            },
            {
                Locations.DODONGOS_CAVERN_STAIRCASE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_STAIRCASE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_STAIRCASE_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_STAIRCASE_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_STAIRS_UPPER,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_STAIRS_LOWER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_ARMOS_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_VINES_ABOVE_STAIRS_GS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.can_attack(bundle)
                end
            }
        }
    )

    --Dodongos Cavern Vines Above Stairs
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_VINES_ABOVE_STAIRS_GS,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_GS_VINES_ABOVE_STAIRS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Compass Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_COMPASS_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_COMPASS_CHEST,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_COMPASS_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_STAIRS_LOWER,
                function(bundle)
                    return LogicHelpers.can_use_any(
                        {
                            Items.MASTER_SWORD,
                            Items.BIGGORONS_SWORD,
                            Items.MEGATON_HAMMER,
                            Items.GORONS_BRACELET
                        },
                        bundle
                    ) or LogicHelpers.has_explosives(bundle)
                end
            }
        }
    )

    --Dodongos Cavern Armos Room
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_ARMOS_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_STAIRS_UPPER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_BOMB_ROOM_LOWER,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Bomb Room Lower
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_BOMB_ROOM_LOWER,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_BOMB_FLOWER_PLATFORM_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.DODONGOS_CAVERN_BLADE_ROOM_HEART,
                function(bundle)
                    return true
                end
            },
            {
                Locations.DODONGOS_CAVERN_FIRST_BRIDGE_GRASS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_BLADE_ROOM_GRASS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BOMB_ROOM_LOWER,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_ARMOS_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_2F_SIDE_ROOM,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or
                        (LogicHelpers.can_do_trick(Tricks.DC_SCRUB_ROOM, bundle) and
                            LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                Regions.DODONGOS_CAVERN_FIRST_SLINGSHOT_ROOM,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_BOMB_ROOM_UPPER,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_do_trick(Tricks.DC_JUMP, bundle) or LogicHelpers.can_ground_jump(bundle))) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        (LogicHelpers.can_use(Items.LONGSHOT, bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST_SIMPLE, bundle) and
                            LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_jump_slash(bundle))
                end
            }
        }
    )

    --Dodongos Cavern 2F Side Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_2F_SIDE_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_DEKU_SCRUB_NEAR_BOMB_BAG_LEFT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices",Locations.DODONGOS_CAVERN_DEKU_SCRUB_NEAR_BOMB_BAG_LEFT,bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_DEKU_SCRUB_NEAR_BOMB_BAG_RIGHT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices",Locations.DODONGOS_CAVERN_DEKU_SCRUB_NEAR_BOMB_BAG_RIGHT,bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_2F_SIDE_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BOMB_ROOM_LOWER,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern First Slingshot Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_FIRST_SLINGSHOT_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_SINGLE_EYE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_SINGLE_EYE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_SINGLE_EYE_GRASS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_FIRST_SLINGSHOT_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BOMB_ROOM_LOWER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_UPPER_LIZALFOS,
                function(bundle)
                    return LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                        LogicHelpers.can_do_trick(Tricks.DC_SLINGSHOT_SKIP, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_ground_jump(bundle))
                end
            }
        }
    )

    --Dodongos Cavern Upper Lizalfos
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_UPPER_LIZALFOS,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_UPPER_LIZALFOS_ROOM_LEFT_HEART,
                function(bundle)
                    return true
                end
            },
            {
                Locations.DODONGOS_CAVERN_UPPER_LIZALFOS_ROOM_RIGHT_HEART,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_UPPER_LIZALFOS,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_FIRST_SLINGSHOT_ROOM,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.LIZALFOS, EnemyDistance.CLOSE, true, 2)
                end
            },
            {
                Regions.DODONGOS_CAVERN_SECOND_SLINGSHOT_ROOM,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.LIZALFOS, EnemyDistance.CLOSE, true, 2)
                end
            },
            {
                Regions.DODONGOS_CAVERN_NEAR_LOWER_LIZALFOS,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_LOWER_LIZALFOS_DEFEATED, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_DODONGO_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.DODONGOS_CAVERN_LOWER_LIZALFOS_DEFEATED, bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_LOWER_LIZALFOS_LOCATIONS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Second Slingshot Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_SECOND_SLINGSHOT_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_DOUBLE_EYE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_DOUBLE_EYE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_SECOND_SLINGSHOT_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_UPPER_LIZALFOS,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_BOMB_ROOM_UPPER,
                function(bundle)
                    return LogicHelpers.can_use_any({Items.FAIRY_SLINGSHOT, Items.FAIRY_BOW}, bundle) or
                        LogicHelpers.can_do_trick(Tricks.DC_SLINGSHOT_SKIP, bundle)
                end
            }
        }
    )

    --Dodongos Cavern Bomb Room Upper
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_BOMB_ROOM_UPPER,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_BOMB_BAG_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.DODONGOS_CAVERN_BLADE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_BLADE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BOMB_ROOM_UPPER,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BOMB_ROOM_LOWER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_SECOND_SLINGSHOT_ROOM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_FAR_BRIDGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Far Bridge
    --Events
    LogicHelpers.add_events(
        Regions.DODONGOS_CAVERN_FAR_BRIDGE,
        world,
        {
            {
                EventLocations.DODONGOS_CAVERN_EYES,
                LocalEvents.DODONGOS_CAVERN_EYES_LIT,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle)
                end
            },
            {
                EventLocations.DODONGOS_CAVERN_LIFT_SWITCH,
                LocalEvents.DODONGOS_CAVERN_LIFT_PLATFORM,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_FAR_BRIDGE,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_END_OF_BRIDGE_CHEST,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_FAR_BRIDGE,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_BOMB_ROOM_UPPER,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Boss Region
    --Events
    LogicHelpers.add_events(
        Regions.DODONGOS_CAVERN_BOSS_REGION,
        world,
        {
            {
                EventLocations.DODONGOS_CAVERN_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_BOSS_REGION,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_BEFORE_BOSS_GRASS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BOSS_REGION,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DODONGOS_CAVERN_BACK_ROOM,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle)
                end
            },
            {
                Regions.DODONGOS_CAVERN_BOSS_ENTRYWAY,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Back Room
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_BACK_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_GS_BACK_ROOM,
                function(bundle)
                    return LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_BACK_ROOM_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_BACK_ROOM_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_BACK_ROOM_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DODONGOS_CAVERN_BACK_ROOM_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BACK_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BOSS_REGION,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Boss Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BOSS_ENTRYWAY,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BOSS_ROOM,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Boss Exit
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BOSS_EXIT,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BOSS_REGION,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Dodongos Cavern Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.DODONGOS_CAVERN_BOSS_ROOM,
        world,
        {
            {
                EventLocations.DODONGOS_CAVERN_KING_DODONGO,
                Events.DODONGOS_CAVERN_COMPLETED,
                function(bundle)
                    local trick_check =
                        LogicHelpers.can_do_trick(Tricks.BLUE_FIRE_MUD_WALLS, bundle) and
                        LogicHelpers.can_use(Items.BOTTLE_WITH_BLUE_FIRE, bundle)
                    if LogicHelpers.can_do_trick(Tricks.DC_HAMMER_FLOOR, bundle) then
                        trick_check =
                            LogicHelpers.can_do_trick(Tricks.BLUE_FIRE_MUD_WALLS, bundle) and LogicHelpers.blue_fire(bundle)
                    end
                    return (LogicHelpers.has_explosives(bundle) or LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) or
                        trick_check) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.KING_DODONGO)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DODONGOS_CAVERN_BOSS_ROOM,
        world,
        {
            {
                Locations.DODONGOS_CAVERN_BOSS_ROOM_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.DODONGOS_CAVERN_KING_DODONGO_HEART_CONTAINER,
                function(bundle)
                    return LogicHelpers.has_item(Events.DODONGOS_CAVERN_COMPLETED, bundle)
                end
            },
            {
                Locations.KING_DODONGO,
                function(bundle)
                    return LogicHelpers.has_item(Events.DODONGOS_CAVERN_COMPLETED, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DODONGOS_CAVERN_BOSS_ROOM,
        world,
        {
            {
                Regions.DODONGOS_CAVERN_BOSS_EXIT,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DEATH_MOUNTAIN_TRAIL,
                function(bundle)
                    return LogicHelpers.has_item(Events.DODONGOS_CAVERN_COMPLETED, bundle)
                end
            }
        }
    )
end

return set_region_rules
