local EventLocations = {
    JABU_JABUS_BELLY_WEST_TENTACLE = "Jabu Jabus Belly West Tentacle",
    JABU_JABUS_BELLY_EAST_TENTACLE = "Jabu Jabus Belly East Tentacle",
    JABU_JABUS_BELLY_NORTH_TENTACLE = "Jabu Jabus Belly North Tentacle",
    JABU_JABUS_BELLY_RUTO_IN_1F = "Jabu Jabus Belly Ruto In 1F",
    JABU_JABUS_BELLY_LOWERED_PATH = "Jabu Jabus Belly Lowered Path",
    JABU_JABUS_BELLY_B1_NORTH_FAIRY_POT = "Jabu Jabus Belly B1 North Fairy Pot",
    JABU_JABUS_BELLY_WATER_SWITCH_ROOM_FAIRY_POT = "Jabu Jabus Belly Water Switch Room Fairy Pot",
    JABU_JABUS_BELLY_ABOVE_BIGOCTO_FAIRY_POT = "Jabu Jabus Belly Above Bigocto Fairy Pot",
    JABU_JABUS_BELLY_ABOVE_BIGOCTO_NUT_POT = "Jabu Jabus Belly Above Bigocto Nut Pot",
    JABU_JABUS_BELLY_BARINADE = "Jabu Jabus Belly Barinade"
}

local LocalEvents = {
    JABU_JABUS_BELLY_WEST_TENTACLE_DEFEATED = "Jabu Jabus Belly West Tentacle Defeated",
    JABU_JABUS_BELLY_EAST_TENTACLE_DEFEATED = "Jabu Jabus Belly East Tentacle Defeated",
    JABU_JABUS_BELLY_NORTH_TENTACLE_DEFEATED = "Jabu Jabus Belly North Tentacle Defeated",
    JABU_JABUS_BELLY_RUTO_IN_1F_RESCUED = "Jabu Jabus Belly Ruto In 1F Rescued",
    JABU_JABUS_BELLY_LOWERED_PATH_ACTIVATED = "Jabu Jabu Belly Lowered Path Activated"
}

local function set_region_rules(world)
    --Jabu Jabu's Belly Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_ENTRYWAY,
        world,
        {
            --TODO: Add vanilla/MQ check
            {Regions.JABU_JABUS_BELLY_BEGINNING, function(bundle)
                    return true
                end},
            {Regions.ZORAS_FOUNTAIN, function(bundle)
                    return true
                end}
        }
    )

    --Jabu Jabu's Belly Beginning
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_BEGINNING,
        world,
        {
            {Regions.JABU_JABUS_BELLY_ENTRYWAY, function(bundle)
                    return true
                end},
            {Regions.JABU_JABUS_BELLY_MAIN, function(bundle)
                    return LogicHelpers.can_use_projectile(bundle)
                end}
        }
    )

    --Jabu Jabu's Belly Main
    --Events
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_MAIN,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_WEST_TENTACLE,
                LocalEvents.JABU_JABUS_BELLY_WEST_TENTACLE_DEFEATED,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_RUTO_IN_1F_RESCUED, bundle) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.TENTACLE, EnemyDistance.BOOMERANG)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_MAIN,
        world,
        {
            {
                Locations.JABU_JABUS_BELLY_DEKU_SCRUB,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) and
                        (LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or
                            LogicHelpers.can_do_trick(Tricks.JABU_ALCOVE_JUMP_DIVE, bundle) or
                            LogicHelpers.can_use(Items.IRON_BOOTS, bundle)) and
                            LogicHelpers.can_stun_deku(bundle)
                        and LogicHelpers.can_afford_item("scrub_prices",Locations.JABU_JABUS_BELLY_DEKU_SCRUB,bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BOOMERANG_CHEST,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_RUTO_IN_1F_RESCUED, bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_MAP_CHEST,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_WEST_TENTACLE_DEFEATED, bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_PLATFORM_ROOM_SMALL_CRATE1,
                function(bundle)
                    return LogicHelpers.can_break_small_crates(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_PLATFORM_ROOM_SMALL_CRATE2,
                function(bundle)
                    return LogicHelpers.can_break_small_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_MAIN,
        world,
        {
            {Regions.JABU_JABUS_BELLY_BEGINNING, function(bundle)
                    return true
                end},
            {Regions.JABU_JABUS_BELLY_B1_NORTH, function(bundle)
                    return true
                end},
            {
                Regions.JABU_JABUS_BELLY_COMPASS_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_WEST_TENTACLE_DEFEATED, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_BLUE_TENTACLE,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_WEST_TENTACLE_DEFEATED, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_GREEN_TENTACLE,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_EAST_TENTACLE_DEFEATED, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_BIGOCTO_LEDGE,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_NORTH_TENTACLE_DEFEATED, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_NEAR_BOSS_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_LOWERED_PATH_ACTIVATED, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.JABU_BOSS_HOVER, bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))
                end
            }
        }
    )

    --Jabu Jabu's Belly B1 North
    --Events
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_B1_NORTH,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_RUTO_IN_1F,
                LocalEvents.JABU_JABUS_BELLY_RUTO_IN_1F_RESCUED,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                EventLocations.JABU_JABUS_BELLY_B1_NORTH_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                            LogicHelpers.can_kill_enemy(bundle, Enemies.OCTOROK))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_B1_NORTH,
        world,
        {
            {
                Locations.JABU_JABUS_BELLY_GS_LOBBY_BASEMENT_LOWER,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_TWO_OCTOROK_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                LogicHelpers.can_kill_enemy(bundle, Enemies.OCTOROK, EnemyDistance.BOOMERANG, false)))
                end
            },
            {
                Locations.JABU_JABUS_BELLY_TWO_OCTOROK_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                LogicHelpers.can_kill_enemy(bundle, Enemies.OCTOROK, EnemyDistance.BOOMERANG, false)))
                end
            },
            {
                Locations.JABU_JABUS_BELLY_TWO_OCTOROK_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                LogicHelpers.can_kill_enemy(bundle, Enemies.OCTOROK, EnemyDistance.BOOMERANG, false)))
                end
            },
            {
                Locations.JABU_JABUS_BELLY_TWO_OCTOROK_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                LogicHelpers.can_kill_enemy(bundle, Enemies.OCTOROK, EnemyDistance.BOOMERANG, false)))
                end
            },
            {
                Locations.JABU_JABUS_BELLY_TWO_OCTOROK_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                LogicHelpers.can_kill_enemy(bundle, Enemies.OCTOROK, EnemyDistance.BOOMERANG, false)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_B1_NORTH,
        world,
        {
            {Regions.JABU_JABUS_BELLY_MAIN, function(bundle)
                    return true
                end},
            {
                Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_LEDGE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_SOUTH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_LOBBY_BASEMENT_UPPER_GS,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            }
        }
    )

    --Jabu Jabu's Belly Water Switch Room Ledge
    --Events
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_LEDGE,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_LEDGE,
        world,
        {
            {
                Locations.JABU_JABUS_BELLY_GS_WATER_SWITCH_ROOM,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) or
                        LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOMB_THROW)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BASEMENT_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BASEMENT_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BASEMENT_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_LEDGE,
        world,
        {
            {Regions.JABU_JABUS_BELLY_B1_NORTH, function(bundle)
                    return true
                end},
            {Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_SOUTH, function(bundle)
                    return true
                end}
        }
    )

    --Jabu Jabu's Belly Water Switch Room South
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_SOUTH,
        world,
        {
            {
                Regions.JABU_JABUS_BELLY_B1_NORTH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_WATER_SWITCH_ROOM_LEDGE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            },
            {Regions.JABU_JABUS_BELLY_MAIN, function(bundle)
                    return LogicHelpers.can_use_projectile(bundle)
                end}
        }
    )

    --Jabu Jabu's Belly Compass Room
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_COMPASS_ROOM,
        world,
        {
            {
                Locations.JABU_JABUS_BELLY_COMPASS_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.SHABOM)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_COMPASS_ROOM,
        world,
        {
            {
                Regions.JABU_JABUS_BELLY_MAIN,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.SHABOM)
                end
            }
        }
    )

    --Jabu Jabu's Belly Blue Tentacle
    --Events
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_BLUE_TENTACLE,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_EAST_TENTACLE,
                LocalEvents.JABU_JABUS_BELLY_EAST_TENTACLE_DEFEATED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.TENTACLE, EnemyDistance.BOOMERANG)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_BLUE_TENTACLE,
        world,
        {
            {
                Regions.JABU_JABUS_BELLY_MAIN,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_EAST_TENTACLE_DEFEATED, bundle)
                end
            }
        }
    )

    --Jabu Jabu's Belly Green Tentacle
    --Events
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_GREEN_TENTACLE,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_NORTH_TENTACLE,
                LocalEvents.JABU_JABUS_BELLY_NORTH_TENTACLE_DEFEATED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.TENTACLE, EnemyDistance.BOOMERANG)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_GREEN_TENTACLE,
        world,
        {
            {
                Regions.JABU_JABUS_BELLY_MAIN,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_NORTH_TENTACLE_DEFEATED, bundle)
                end
            }
        }
    )

    --Jabu Jabu's Belly Bigocto Room
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_BIGOCTO_LEDGE,
        world,
        {
            {Regions.JABU_JABUS_BELLY_B1_NORTH, function(bundle)
                    return true
                end},
            {
                Regions.JABU_JABUS_BELLY_ABOVE_BIGOCTO,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.JABU_JABUS_BELLY_RUTO_IN_1F_RESCUED, bundle) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.BIG_OCTO)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_LOBBY_BASEMENT_UPPER_GS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.SHORT_JUMPSLASH)
                end
            }
        }
    )

    --Jabu Jabu's Belly GS Lobby Basement Upper
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_LOBBY_BASEMENT_UPPER_GS,
        world,
        {
            {Locations.JABU_JABUS_BELLY_GS_LOBBY_BASEMENT_UPPER, function(bundle)
                    return true
                end}
        }
    )

    --Jabu Jabu's Belly Above Bigocto
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_ABOVE_BIGOCTO,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_ABOVE_BIGOCTO_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.JABU_JABUS_BELLY_ABOVE_BIGOCTO_NUT_POT,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_ABOVE_BIGOCTO,
        world,
        {
            {
                Locations.JABU_JABUS_BELLY_ABOVE_BIG_OCTO_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_ABOVE_BIG_OCTO_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_ABOVE_BIG_OCTO_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_ABOVE_BIGOCTO,
        world,
        {
            {
                Regions.JABU_JABUS_BELLY_LIFT_UPPER,
                function(bundle)
                    return LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            }
        }
    )

    --Jabu Jabu's Belly Lift Upper
    --Events
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_LIFT_UPPER,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_LOWERED_PATH,
                LocalEvents.JABU_JABUS_BELLY_LOWERED_PATH_ACTIVATED,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_LIFT_UPPER,
        world,
        {
            {Regions.JABU_JABUS_BELLY_MAIN, function(bundle)
                    return true
                end}
        }
    )

    --Jabu Jabu's Belly Near Boss Room
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_NEAR_BOSS_ROOM,
        world,
        {
            {
                Locations.JABU_JABUS_BELLY_GS_NEAR_BOSS,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOMB_THROW)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_NEAR_BOSS_ROOM,
        world,
        {
            {Regions.JABU_JABUS_BELLY_MAIN, function(bundle)
                    return true
                end},
            {
                Regions.JABU_JABUS_BELLY_BOSS_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.JABU_NEAR_BOSS_RANGED, bundle) and
                            LogicHelpers.can_use_any({Items.HOOKSHOT, Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.JABU_NEAR_BOSS_EXPLOSIVES, bundle) and
                            (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                                (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                    LogicHelpers.can_use(Items.BOMB_BAG, bundle))))
                end
            }
        }
    )

    --Skipping master quest for now

    --Jabu Jabu's Belly Boss Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_BOSS_ENTRYWAY,
        world,
        {
            {Regions.JABU_JABUS_BELLY_BOSS_ROOM, function(bundle)
                    return true
                end}
        }
    )

    ----Jabu Jabu's Belly Boss Exit
    ----Connections
    --LogicHelpers.connect_regions(Regions.JABU_JABUS_BELLY_BOSS_EXIT, world, {
    --    {Regions.JABU_JABUS_BELLY_NEAR_BOSS_ROOM, function(bundle) return true end})
    --    --skipping mq connection
    --})

    --Jabu Jabu's Belly Boss Room
    --Events
    LogicHelpers.add_events(
        Regions.JABU_JABUS_BELLY_BOSS_ROOM,
        world,
        {
            {
                EventLocations.JABU_JABUS_BELLY_BARINADE,
                Events.JABU_JABUS_BELLY_COMPLETED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.BARINADE)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.JABU_JABUS_BELLY_BOSS_ROOM,
        world,
        {
            {
                Locations.JABU_JABUS_BELLY_BARINADE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BARINADE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BARINADE_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BARINADE_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BARINADE_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BARINADE_POT6,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.JABU_JABUS_BELLY_BARINADE_HEART_CONTAINER,
                function(bundle)
                    return LogicHelpers.has_item(Events.JABU_JABUS_BELLY_COMPLETED, bundle)
                end
            },
            {
                Locations.BARINADE,
                function(bundle)
                    return LogicHelpers.has_item(Events.JABU_JABUS_BELLY_COMPLETED, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.JABU_JABUS_BELLY_BOSS_ROOM,
        world,
        {
            --(Regions.JABU_JABUS_BELLY_BOSS_EXIT, function(bundle) return false),  --readd for MQ stuff
            {
                Regions.ZORAS_FOUNTAIN,
                function(bundle)
                    return LogicHelpers.has_item(Events.JABU_JABUS_BELLY_COMPLETED, bundle)
                end
            }
        }
    )
end

return set_region_rules
