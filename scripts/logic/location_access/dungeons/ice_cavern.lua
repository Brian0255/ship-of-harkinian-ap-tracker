local EventLocations = {
    ICE_CAVERN_MAP_ROOM_BLUE_FIRE_ACCESS = "Ice Cavern Map Room Blue Fire Access",
    ICE_CAVERN_COMPASS_ROOM_BLUE_FIRE_ACCESS = "Ice Cavern Compass Room Blue Fire Access",
    ICE_CAVERN_BLOCK_ROOM_BLUE_FIRE_ACCESS = "Ice Cavern Block Room Blue Fire Access"
}

local function set_region_rules(world)
    --Ice Cavern Entryway
    --Locations
    LogicHelpers.add_locations(Regions.ICE_CAVERN_ENTRYWAY, world, {})
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_ENTRYWAY,
        world,
        {
            {Regions.ICE_CAVERN_BEGINNING, function(bundle)
                    return true
                end},
            --Skipping MQ
            {Regions.ZF_LEDGE, function(bundle)
                    return true
                end}
        }
    )

    --Ice Cavern Beginning
    --Locations
    LogicHelpers.add_locations(
        Regions.ICE_CAVERN_BEGINNING,
        world,
        {
            {
                Locations.ICE_CAVERN_ENTRANCE_SONG_OF_STORMS_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {Locations.ICE_CAVERN_LOBBY_RUPEE, function(bundle)
                    return LogicHelpers.blue_fire(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_BEGINNING,
        world,
        {
            {Regions.ICE_CAVERN_ENTRYWAY, function(bundle)
                    return true
                end},
            {
                Regions.ICE_CAVERN_HUB,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.FREEZARD, EnemyDistance.CLOSE, true, 4)
                end
            },
            {Regions.ICE_CAVERN_ABOVE_BEGINNING, function(bundle)
                    return false
                end}
        }
    )

    --Ice Cavern Hub
    --Locations
    LogicHelpers.add_locations(
        Regions.ICE_CAVERN_HUB,
        world,
        {
            {
                Locations.ICE_CAVERN_GS_SPINNING_SCYTHE_ROOM,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            },
            {Locations.ICE_CAVERN_HALL_POT1, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.ICE_CAVERN_HALL_POT2, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {
                Locations.ICE_CAVERN_SPINNING_BLADE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ICE_CAVERN_SPINNING_BLADE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ICE_CAVERN_SPINNING_BLADE_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_HUB,
        world,
        {
            {Regions.ICE_CAVERN_BEGINNING, function(bundle)
                    return true
                end},
            {
                Regions.ICE_CAVERN_MAP_ROOM,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) or
                        (LogicHelpers.can_do_trick(Tricks.GROUND_JUMP_HARD, bundle) and LogicHelpers.can_ground_jump(bundle))) and
                        LogicHelpers.can_clear_stalagmite(bundle)
                end
            },
            {Regions.ICE_CAVERN_COMPASS_ROOM, function(bundle)
                    return LogicHelpers.blue_fire(bundle)
                end},
            {
                Regions.ICE_CAVERN_BLOCK_ROOM,
                function(bundle)
                    return LogicHelpers.blue_fire(bundle) and LogicHelpers.can_clear_stalagmite(bundle)
                end
            }
        }
    )

    --Ice Cavern Map Room
    --Events
    LogicHelpers.add_events(
        Regions.ICE_CAVERN_MAP_ROOM,
        world,
        {
            {
                EventLocations.ICE_CAVERN_MAP_ROOM_BLUE_FIRE_ACCESS,
                Events.CAN_ACCESS_BLUE_FIRE,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ICE_CAVERN_MAP_ROOM,
        world,
        {
            {Locations.ICE_CAVERN_MAP_CHEST, function(bundle)
                    return LogicHelpers.blue_fire(bundle)
                end},
            {
                Locations.ICE_CAVERN_FROZEN_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and LogicHelpers.blue_fire(bundle)) or
                        LogicHelpers.has_explosives(bundle) or
                        (LogicHelpers.can_do_trick(Tricks.RUSTED_SWITCHES, bundle) and
                            ((LogicHelpers.can_standing_shield(bundle) and LogicHelpers.can_use(Items.DEKU_SHIELD, bundle)) or
                                LogicHelpers.can_use_any(
                                    {Items.MASTER_SWORD, Items.BIGGORONS_SWORD, Items.MEGATON_HAMMER},
                                    bundle
                                ))) or
                        (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                            LogicHelpers.can_use(Items.HOOKSHOT, bundle))
                end
            },
            {Locations.ICE_CAVERN_MAP_ROOM_LEFT_HEART, function(bundle)
                    return true
                end},
            {Locations.ICE_CAVERN_MAP_ROOM_MIDDLE_HEART, function(bundle)
                    return true
                end},
            {Locations.ICE_CAVERN_MAP_ROOM_RIGHT_HEART, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_MAP_ROOM,
        world,
        {
            {Regions.ICE_CAVERN_HUB, function(bundle)
                    return true
                end}
        }
    )

    --Ice Cavern Compass Room
    --Events
    LogicHelpers.add_events(
        Regions.ICE_CAVERN_COMPASS_ROOM,
        world,
        {
            {
                EventLocations.ICE_CAVERN_COMPASS_ROOM_BLUE_FIRE_ACCESS,
                Events.CAN_ACCESS_BLUE_FIRE,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ICE_CAVERN_COMPASS_ROOM,
        world,
        {
            {
                Locations.ICE_CAVERN_COMPASS_CHEST,
                function(bundle)
                    return LogicHelpers.can_clear_stalagmite(bundle) and LogicHelpers.blue_fire(bundle)
                end
            },
            {
                Locations.ICE_CAVERN_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.can_clear_stalagmite(bundle) and LogicHelpers.blue_fire(bundle)
                end
            },
            {
                Locations.ICE_CAVERN_GS_HEART_PIECE_ROOM,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_COMPASS_ROOM,
        world,
        {
            {Regions.ICE_CAVERN_HUB, function(bundle)
                    return true
                end}
        }
    )

    --Ice Cavern Main
    --Events
    LogicHelpers.add_events(
        Regions.ICE_CAVERN_BLOCK_ROOM,
        world,
        {
            {
                EventLocations.ICE_CAVERN_BLOCK_ROOM_BLUE_FIRE_ACCESS,
                Events.CAN_ACCESS_BLUE_FIRE,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ICE_CAVERN_BLOCK_ROOM,
        world,
        {
            {
                Locations.ICE_CAVERN_GS_PUSH_BLOCK_ROOM,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle) or
                        (LogicHelpers.can_do_trick(Tricks.ICE_BLOCK_GS, bundle) and LogicHelpers.is_adult(bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                            LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.SHORT_JUMPSLASH))
                end
            },
            {
                Locations.ICE_CAVERN_SLIDING_BLOCK_ROOM_RUPEE1,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.ICE_CAVERN_SLIDING_BLOCK_ROOM_RUPEE2,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.ICE_CAVERN_SLIDING_BLOCK_ROOM_RUPEE3,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_BLOCK_ROOM,
        world,
        {
            {Regions.ICE_CAVERN_HUB, function(bundle)
                    return LogicHelpers.can_clear_stalagmite(bundle)
                end},
            {Regions.ICE_CAVERN_BEFORE_FINAL_ROOM, function(bundle)
                    return LogicHelpers.blue_fire(bundle)
                end}
        }
    )

    --Ice Cavern Before Final Room
    --Locations
    LogicHelpers.add_locations(
        Regions.ICE_CAVERN_BEFORE_FINAL_ROOM,
        world,
        {
            {
                Locations.ICE_CAVERN_NEAR_END_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.blue_fire(bundle)
                end
            },
            {
                Locations.ICE_CAVERN_NEAR_END_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.blue_fire(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_BEFORE_FINAL_ROOM,
        world,
        {
            {Regions.ICE_CAVERN_BLOCK_ROOM, function(bundle)
                    return LogicHelpers.blue_fire(bundle)
                end},
            {Regions.ICE_CAVERN_FINAL_ROOM, function(bundle)
                    return true
                end}
        }
    )

    --Ice Cavern Final Room
    --Locations
    LogicHelpers.add_locations(
        Regions.ICE_CAVERN_FINAL_ROOM,
        world,
        {
            {
                Locations.ICE_CAVERN_IRON_BOOTS_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS)
                end
            },
            {
                Locations.SHEIK_IN_ICE_CAVERN,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS)
                end
            } --Rando enables this for child
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_FINAL_ROOM,
        world,
        {
            {
                Regions.ICE_CAVERN_BEFORE_FINAL_ROOM,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS)
                end
            },
            {
                Regions.ICE_CAVERN_FINAL_ROOM_UNDERWATER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS) and
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            }
        }
    )

    --Ice Cavern Final Room Underwater
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_FINAL_ROOM_UNDERWATER,
        world,
        {
            {
                Regions.ICE_CAVERN_FINAL_ROOM,
                function(bundle)
                    return LogicHelpers.can_use(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Regions.ICE_CAVERN_ABOVE_BEGINNING,
                function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            }
        }
    )

    --Ice Cavern Above Beginning
    --Connections
    LogicHelpers.connect_regions(
        Regions.ICE_CAVERN_ABOVE_BEGINNING,
        world,
        {
            {
                Regions.ICE_CAVERN_FINAL_ROOM_UNDERWATER,
                function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            },
            {Regions.ICE_CAVERN_BEGINNING, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
