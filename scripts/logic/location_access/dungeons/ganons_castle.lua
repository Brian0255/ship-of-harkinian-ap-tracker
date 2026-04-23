local EventLocations = {
    GANONS_CASTLE_FREE_FAIRIES = "Ganon's Castle Free Fairies",
    GANONS_CASTLE_FOREST_TRIAL_AREA = "Ganon's Castle Forest Trial Area",
    GANONS_CASTLE_FIRE_TRIAL_AREA = "Ganon's Castle Fire Trial Area",
    GANONS_CASTLE_WATER_TRIAL_AREA = "Ganon's Castle Water Trial Area",
    GANONS_CASTLE_SHADOW_TRIAL_AREA = "Ganon's Castle Shadow Trial Area",
    GANONS_CASTLE_SPIRIT_TRIAL_AREA = "Ganon's Castle Spirit Trial Area",
    GANONS_CASTLE_LIGHT_TRIAL_AREA = "Ganon's Castle Light Trial Area",
    GANONS_CASTLE_BLUE_FIRE_ACCESS = "Ganon's Castle Blue Fire Access",
    GANONS_CASTLE_WATER_TRIAL_FAIRY_POT = "Ganon's Castle Water Trial Fairy Pot",
    GANONS_CASTLE_SPIRIT_TRIAL_NUT_POT = "Ganon's Castle Spirit Trial Nut Pot",
    GANON_DEFEATED = "Ganon Defeated"
}

local LocalEvents = {
    GANONS_CASTLE_FOREST_TRIAL_CLEARED = "Ganon's Castle Forest Trial Cleared",
    GANONS_CASTLE_FIRE_TRIAL_CLEARED = "Ganon's Castle Fire Trial Cleared",
    GANONS_CASTLE_WATER_TRIAL_CLEARED = "Ganon's Castle Water Trial Cleared",
    GANONS_CASTLE_SHADOW_TRIAL_CLEARED = "Ganon's Castle Shadow Trial Cleared",
    GANONS_CASTLE_SPIRIT_TRIAL_CLEARED = "Ganon's Castle Spirit Trial Cleared",
    GANONS_CASTLE_LIGHT_TRIAL_CLEARED = "Ganon's Castle Light Trial Cleared"
}

local trial_mapping = {
    [GanonsTrials.FOREST_TRIAL] = LocalEvents.GANONS_CASTLE_FOREST_TRIAL_CLEARED,
    [GanonsTrials.FIRE_TRIAL] = LocalEvents.GANONS_CASTLE_FIRE_TRIAL_CLEARED,
    [GanonsTrials.WATER_TRIAL] = LocalEvents.GANONS_CASTLE_WATER_TRIAL_CLEARED,
    [GanonsTrials.SHADOW_TRIAL] = LocalEvents.GANONS_CASTLE_SHADOW_TRIAL_CLEARED,
    [GanonsTrials.SPIRIT_TRIAL] = LocalEvents.GANONS_CASTLE_SPIRIT_TRIAL_CLEARED,
    [GanonsTrials.LIGHT_TRIAL] = LocalEvents.GANONS_CASTLE_LIGHT_TRIAL_CLEARED
}

local function set_region_rules(world)
    --Ganon's Castle Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_CASTLE_ENTRYWAY,
        world,
        {
            {
                Regions.GANONS_CASTLE_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.CASTLE_GROUNDS_FROM_GANONS_CASTLE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Ganon's Castle Lobby
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_CASTLE_LOBBY,
        world,
        {
            {
                Regions.GANONS_CASTLE_ENTRYWAY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GANONS_CASTLE_FOREST_TRIAL,
                function(bundle)
                    return not world:get_option("medallion_locked_trials") or
                        LogicHelpers.has_item(Items.FOREST_MEDALLION, bundle)
                end
            },
            {
                Regions.GANONS_CASTLE_FIRE_TRIAL,
                function(bundle)
                    return not world:get_option("medallion_locked_trials") or
                        LogicHelpers.has_item(Items.FIRE_MEDALLION, bundle)
                end
            },
            {
                Regions.GANONS_CASTLE_WATER_TRIAL,
                function(bundle)
                    return not world:get_option("medallion_locked_trials") or
                        LogicHelpers.has_item(Items.WATER_MEDALLION, bundle)
                end
            },
            {
                Regions.GANONS_CASTLE_SHADOW_TRIAL,
                function(bundle)
                    return not world:get_option("medallion_locked_trials") or
                        LogicHelpers.has_item(Items.SHADOW_MEDALLION, bundle)
                end
            },
            {
                Regions.GANONS_CASTLE_SPIRIT_TRIAL,
                function(bundle)
                    return not world:get_option("medallion_locked_trials") or
                        LogicHelpers.has_item(Items.SPIRIT_MEDALLION, bundle)
                end
            },
            {
                Regions.GANONS_CASTLE_LIGHT_TRIAL,
                function(bundle)
                    return LogicHelpers.can_use(Items.GOLDEN_GAUNTLETS, bundle) and
                        (not world:get_option("medallion_locked_trials") or
                            LogicHelpers.has_item(Items.LIGHT_MEDALLION, bundle))
                end
            },
            {
                Regions.GANONS_TOWER_ENTRYWAY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GANONS_CASTLE_DEKU_SCRUBS,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)
                end
            }
        }
    )

    --Ganon's Castle Deku Scrubs
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_CASTLE_DEKU_SCRUBS,
        world,
        {
            {
                EventLocations.GANONS_CASTLE_FREE_FAIRIES,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_CASTLE_DEKU_SCRUBS,
        world,
        {
            {
                Locations.GANONS_CASTLE_DEKU_SCRUB_CENTER_LEFT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.GANONS_CASTLE_DEKU_SCRUB_CENTER_LEFT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_DEKU_SCRUB_CENTER_RIGHT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.GANONS_CASTLE_DEKU_SCRUB_CENTER_RIGHT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_DEKU_SCRUB_RIGHT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.GANONS_CASTLE_DEKU_SCRUB_RIGHT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_DEKU_SCRUB_LEFT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.GANONS_CASTLE_DEKU_SCRUB_LEFT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY1,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY2,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY3,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY4,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY5,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY6,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY7,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_SCRUBS_FAIRY8,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Ganon's Castle Forest Trial
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_CASTLE_FOREST_TRIAL,
        world,
        {
            {
                EventLocations.GANONS_CASTLE_FOREST_TRIAL_AREA,
                LocalEvents.GANONS_CASTLE_FOREST_TRIAL_CLEARED,
                function(bundle)
                    return LogicHelpers.can_use(Items.LIGHT_ARROW, bundle) and
                        (LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_CASTLE_FOREST_TRIAL,
        world,
        {
            {
                Locations.GANONS_CASTLE_FOREST_TRIAL_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS)
                end
            },
            {
                Locations.GANONS_CASTLE_FOREST_TRIAL_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                            (LogicHelpers.can_use(Items.DINS_FIRE, bundle) and
                                LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT}, bundle)))
                end
            },
            {
                Locations.GANONS_CASTLE_FOREST_TRIAL_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                            (LogicHelpers.can_use(Items.DINS_FIRE, bundle) and
                                LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.HOOKSHOT}, bundle)))
                end
            }
        }
    )

    --Ganon's Castle Fire Trial
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_CASTLE_FIRE_TRIAL,
        world,
        {
            {
                EventLocations.GANONS_CASTLE_FIRE_TRIAL_AREA,
                LocalEvents.GANONS_CASTLE_FIRE_TRIAL_CLEARED,
                function(bundle)
                    return LogicHelpers.can_use(Items.GORON_TUNIC, bundle) and
                        LogicHelpers.can_use(Items.GOLDEN_GAUNTLETS, bundle) and
                        LogicHelpers.can_use(Items.LIGHT_ARROW, bundle) and
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_CASTLE_FIRE_TRIAL,
        world,
        {
            {
                Locations.GANONS_CASTLE_FIRE_TRIAL_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.can_use(Items.GORON_TUNIC, bundle) and
                        LogicHelpers.can_use(Items.GOLDEN_GAUNTLETS, bundle) and
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_FIRE_TRIAL_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.can_use(Items.GORON_TUNIC, bundle) and
                        LogicHelpers.can_use(Items.GOLDEN_GAUNTLETS, bundle) and
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_FIRE_TRIAL_HEART,
                function(bundle)
                    return LogicHelpers.can_use(Items.GORON_TUNIC, bundle)
                end
            }
        }
    )

    --Ganon's Castle Water Trial
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_CASTLE_WATER_TRIAL,
        world,
        {
            {
                EventLocations.GANONS_CASTLE_BLUE_FIRE_ACCESS,
                Events.CAN_ACCESS_BLUE_FIRE,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.GANONS_CASTLE_WATER_TRIAL_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.blue_fire(bundle) and LogicHelpers.can_kill_enemy(bundle, Enemies.FREEZARD)
                end
            },
            {
                EventLocations.GANONS_CASTLE_WATER_TRIAL_AREA,
                LocalEvents.GANONS_CASTLE_WATER_TRIAL_CLEARED,
                function(bundle)
                    return (LogicHelpers.blue_fire(bundle) and LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) and
                        LogicHelpers.can_use(Items.LIGHT_ARROW, bundle))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_CASTLE_WATER_TRIAL,
        world,
        {
            {
                Locations.GANONS_CASTLE_WATER_TRIAL_LEFT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_WATER_TRIAL_RIGHT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_WATER_TRIAL_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.blue_fire(bundle) and
                        LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_WATER_TRIAL_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.blue_fire(bundle) and
                        LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_WATER_TRIAL_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.blue_fire(bundle) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.FREEZARD)
                end
            }
        }
    )

    --Ganon's Castle Shadow Trial
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_CASTLE_SHADOW_TRIAL,
        world,
        {
            {
                EventLocations.GANONS_CASTLE_SHADOW_TRIAL_AREA,
                LocalEvents.GANONS_CASTLE_SHADOW_TRIAL_CLEARED,
                function(bundle)
                    return LogicHelpers.can_use(Items.LIGHT_ARROW, bundle) and
                        LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) and
                        ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) and
                            (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                                LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))) or
                            (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                                (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                                    (LogicHelpers.can_use(Items.DINS_FIRE, bundle) and
                                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))))))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_CASTLE_SHADOW_TRIAL,
        world,
        {
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_FRONT_CHEST,
                function(bundle)
                    return LogicHelpers.can_use_any(
                        {Items.FIRE_ARROW, Items.HOOKSHOT, Items.HOVER_BOOTS, Items.SONG_OF_TIME},
                        bundle
                    ) or LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_GOLDEN_GAUNTLETS_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                        (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle)))
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_POT1,
                function(bundle)
                    return LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_POT2,
                function(bundle)
                    return LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_POT3,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) and
                        ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) and
                            (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                                LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))) or
                            (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                                (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                                    (LogicHelpers.can_use(Items.DINS_FIRE, bundle) and
                                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)))))))
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_POT4,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) and
                        ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) and
                            (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                                LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))) or
                            (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                                (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                                    (LogicHelpers.can_use(Items.DINS_FIRE, bundle) and
                                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)))))))
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_HEART1,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                        (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle)))) and
                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle)))
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_HEART2,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                        (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle)))) and
                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle)))
                end
            },
            {
                Locations.GANONS_CASTLE_SHADOW_TRIAL_HEART3,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.FIRE_ARROW, bundle) or
                        (LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                            (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle)))) and
                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle)))
                end
            }
        }
    )

    --Ganon's Castle Spirit Trial
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_CASTLE_SPIRIT_TRIAL,
        world,
        {
            {
                EventLocations.GANONS_CASTLE_SPIRIT_TRIAL_NUT_POT,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return (((LogicHelpers.can_do_trick(Tricks.GANON_SPIRIT_TRIAL_HOOKSHOT, bundle) and
                        LogicHelpers.can_jump_slash_except_hammer(bundle)) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)) and
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                                (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                                    LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)))) and
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                        (LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) or
                            (world:get_option("sunlight_arrows") and LogicHelpers.can_use(Items.LIGHT_ARROW, bundle))))
                end
            },
            {
                EventLocations.GANONS_CASTLE_SPIRIT_TRIAL_AREA,
                LocalEvents.GANONS_CASTLE_SPIRIT_TRIAL_CLEARED,
                function(bundle)
                    return (LogicHelpers.can_use(Items.LIGHT_ARROW, bundle) and
                        (LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) or world:get_option("sunlight_arrows")) and
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                                (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                                    LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)))) and
                        ((LogicHelpers.can_do_trick(Tricks.GANON_SPIRIT_TRIAL_HOOKSHOT, bundle) and
                            LogicHelpers.can_jump_slash_except_hammer(bundle)) or
                            LogicHelpers.can_use(Items.HOOKSHOT, bundle)))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_CASTLE_SPIRIT_TRIAL,
        world,
        {
            {
                Locations.GANONS_CASTLE_SPIRIT_TRIAL_CRYSTAL_SWITCH_CHEST,
                function(bundle)
                    return ((LogicHelpers.can_do_trick(Tricks.GANON_SPIRIT_TRIAL_HOOKSHOT, bundle) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)) and
                        (LogicHelpers.can_jump_slash_except_hammer(bundle) or
                            (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                                (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                                    (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                                        LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle))))))
                end
            },
            {
                Locations.GANONS_CASTLE_SPIRIT_TRIAL_INVISIBLE_CHEST,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.GANON_SPIRIT_TRIAL_HOOKSHOT, bundle) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)) and
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                                (LogicHelpers.can_use_any({Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT}, bundle)))) and
                                (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                                    LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))
                end
            },
            {
                Locations.GANONS_CASTLE_SPIRIT_TRIAL_POT1,
                function(bundle)
                    return (((LogicHelpers.can_do_trick(Tricks.GANON_SPIRIT_TRIAL_HOOKSHOT, bundle) and
                        LogicHelpers.can_jump_slash_except_hammer(bundle)) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)) and
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                                (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                                    LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)))) and
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                        (LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) or
                            (world:get_option("sunlight_arrows") and LogicHelpers.can_use(Items.LIGHT_ARROW, bundle))))
                end
            },
            {
                Locations.GANONS_CASTLE_SPIRIT_TRIAL_POT2,
                function(bundle)
                    return (((LogicHelpers.can_do_trick(Tricks.GANON_SPIRIT_TRIAL_HOOKSHOT, bundle) and
                        LogicHelpers.can_jump_slash_except_hammer(bundle)) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)) and
                        (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.HOOKSHOT_EXTENSION, bundle) and
                                (LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                                    LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)))) and
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                        (LogicHelpers.can_use(Items.MIRROR_SHIELD, bundle) or
                            (world:get_option("sunlight_arrows") and LogicHelpers.can_use(Items.LIGHT_ARROW, bundle))))
                end
            },
            {
                Locations.GANONS_CASTLE_SPIRIT_TRIAL_BEAMOS_SUNS_SONG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_SPIRIT_TRIAL_HEART,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Ganon's Castle Light Trial
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_CASTLE_LIGHT_TRIAL,
        world,
        {
            {
                EventLocations.GANONS_CASTLE_LIGHT_TRIAL_AREA,
                LocalEvents.GANONS_CASTLE_LIGHT_TRIAL_CLEARED,
                function(bundle)
                    return LogicHelpers.can_use(Items.LIGHT_ARROW, bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_ground_jump(bundle))) and
                        LogicHelpers.small_keys(Items.GANONS_CASTLE_SMALL_KEY, 2, bundle) and
                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_CASTLE_LIGHT_TRIAL,
        world,
        {
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_FIRST_LEFT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_SECOND_LEFT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_THIRD_LEFT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_FIRST_RIGHT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_SECOND_RIGHT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_THIRD_RIGHT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_INVISIBLE_ENEMIES_CHEST,
                function(bundle)
                    return (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_LULLABY_CHEST,
                function(bundle)
                    return (LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) and
                        LogicHelpers.small_keys(Items.GANONS_CASTLE_SMALL_KEY, 1, bundle))
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_BOULDER_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle) and
                        LogicHelpers.small_keys(Items.GANONS_CASTLE_SMALL_KEY, 2, bundle))
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_ground_jump(bundle))) and
                        LogicHelpers.small_keys(Items.GANONS_CASTLE_SMALL_KEY, 2, bundle) and
                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))
                end
            },
            {
                Locations.GANONS_CASTLE_LIGHT_TRIAL_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_ground_jump(bundle))) and
                        LogicHelpers.small_keys(Items.GANONS_CASTLE_SMALL_KEY, 2, bundle) and
                        (LogicHelpers.can_do_trick(Tricks.LENS_GANON, bundle) or
                            LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))
                end
            }
        }
    )

    --Ganon's Tower Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_TOWER_ENTRYWAY,
        world,
        {
            {
                Regions.GANONS_CASTLE_LOBBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GANONS_TOWER_FLOOR_1,
                function(bundle)
                    --skip ganon's trials was removed, backwards compatibility check
                    if world:get_option("ganons_trials") == Options.GANONS_TRIALS_SKIP or world:get_option("skip_ganons_trials") then
                        return true
                    end
                    for _, trial in pairs(world.ganons_trials) do
                        if not LogicHelpers.has_item(trial_mapping[trial], bundle) then
                            return false
                        end
                    end
                    return true
                end
            }
        }
    )

    --Ganon's Tower Floor 1
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_TOWER_FLOOR_1,
        world,
        {
            {
                Regions.GANONS_TOWER_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.DINOLFOS, EnemyDistance.CLOSE, true, 2)
                end
            },
            {
                Regions.GANONS_TOWER_FLOOR_2,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.DINOLFOS, EnemyDistance.CLOSE, true, 2)
                end
            }
        }
    )

    --Ganon's Tower Floor 2
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_TOWER_FLOOR_2,
        world,
        {
            {
                Locations.GANONS_CASTLE_TOWER_BOSS_KEY_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 2)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_TOWER_FLOOR_2,
        world,
        {
            {
                Regions.GANONS_TOWER_FLOOR_1,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 2)
                end
            },
            {
                Regions.GANONS_TOWER_FLOOR_3,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.STALFOS, EnemyDistance.CLOSE, true, 2)
                end
            }
        }
    )

    --Ganon's Tower Floor 3
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_TOWER_FLOOR_3,
        world,
        {
            {
                Regions.GANONS_TOWER_FLOOR_2,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.IRON_KNUCKLE, EnemyDistance.CLOSE, true, 2)
                end
            },
            {
                Regions.GANONS_TOWER_BEFORE_GANONDORFS_LAIR,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.IRON_KNUCKLE, EnemyDistance.CLOSE, true, 2)
                end
            }
        }
    )

    --Ganon's Tower Before Ganondorf's Lair
    --Locations
    LogicHelpers.add_locations(
        Regions.GANONS_TOWER_BEFORE_GANONDORFS_LAIR,
        world,
        {
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT6,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT7,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT8,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT9,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT10,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT11,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT12,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT13,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT14,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT15,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT16,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT17,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GANONS_CASTLE_GANONS_TOWER_POT18,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_TOWER_BEFORE_GANONDORFS_LAIR,
        world,
        {
            {
                Regions.GANONS_TOWER_FLOOR_3,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GANONDORFS_LAIR,
                function(bundle)
                    return LogicHelpers.has_item(Items.GANONS_CASTLE_BOSS_KEY, bundle) or world:get_option("triforce_hunt")
                end
            }
        }
    )

    --Ganondorf's Lair
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONDORFS_LAIR,
        world,
        {
            {
                Regions.GANONS_CASTLE_ESCAPE,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GANONDORF)
                end
            }
        }
    )

    --Ganon's Castle Escape
    --Connections
    LogicHelpers.connect_regions(
        Regions.GANONS_CASTLE_ESCAPE,
        world,
        {
            {
                Regions.GANONS_ARENA,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Ganon's Arena
    --Events
    LogicHelpers.add_events(
        Regions.GANONS_ARENA,
        world,
        {
            {
                EventLocations.GANON_DEFEATED,
                Events.GAME_COMPLETED,
                function(bundle)
                    return world:get_option("triforce_hunt") == false and LogicHelpers.can_kill_enemy(bundle, Enemies.GANON)
                end
            }
        }
    )
end

return set_region_rules
