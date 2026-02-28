local EventLocations = {
    DMT_BEAN_PLANT_FAIRY = "DMT Bean Plant Fairy",
    DMT_GOSSIP_STONE_SONG_FAIRY = "DMT Gossip Stone Song Fairy",
    DMT_BUG_ROCK = "DMT Bug Rock",
    DMT_STORMS_GROTTO_GOSSIP_STONE_SONG_FAIRY = "DMT Storms Grotto Gossip Stone Song Fairy",
    DMT_STORMS_GROTTO_BUTTERFLY_FAIRY = "DMT Storms Grotto Butterfly Fairy",
    DMT_STORMS_GROTTO_BUG_GRASS = "DMT Storms Grotto Bug Grass",
    DMT_STORMS_GROTTO_PUDDLE_FISH = "DMT Storms Grotto Puddle Fish",
    DMT_BEAN_PATCH = "DMT Bean Patch",
    DMT_DAY_NIGHT_CYCLE_CHILD = "DMT Day Night Cycle Child",
    DMT_DAY_NIGHT_CYCLE_ADULT = "DMT Day Night Cycle Adult"
}

local LocalEvents = {
    DMT_BEAN_PLANTED = "DMT Bean Planted"
}

local function set_region_rules(world)
    --Death Mountain Trail
    --Events
    LogicHelpers.add_events(
        Regions.DEATH_MOUNTAIN_TRAIL,
        world,
        {
            {
                EventLocations.DMT_BEAN_PLANT_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                EventLocations.DMT_BEAN_PATCH,
                LocalEvents.DMT_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        (LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                EventLocations.DMT_DAY_NIGHT_CYCLE_CHILD,
                Events.CHILD_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.DMT_DAY_NIGHT_CYCLE_ADULT,
                Events.ADULT_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DEATH_MOUNTAIN_TRAIL,
        world,
        {
            {
                Locations.DMT_CHEST,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or
                        (LogicHelpers.can_do_trick(Tricks.DMT_BOMBABLE, bundle) and LogicHelpers.is_child(bundle) and
                            LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                Locations.DMT_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.take_damage(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(LocalEvents.DMT_BEAN_PLANTED, bundle) and
                            (LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.DMT_GS_BEAN_PATCH,
                function(bundle)
                    return LogicHelpers.can_spawn_soil_skull(bundle) and
                        (LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.DMT_SOIL_GS, bundle) and
                                (LogicHelpers.take_damage(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) and
                                LogicHelpers.can_use(Items.BOOMERANG, bundle)))
                end
            },
            {Locations.DMT_GS_NEAR_KAK, function(bundle)
                    return LogicHelpers.blast_or_smash(bundle)
                end},
            {
                Locations.DMT_GS_ABOVE_DODONGOS_CAVERN,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.at_night(bundle) and
                        (LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.DMT_HOOKSHOT_LOWER_GS, bundle) and
                                LogicHelpers.can_use(Items.HOOKSHOT, bundle)) or
                            (LogicHelpers.can_do_trick(Tricks.DMT_BEAN_LOWER_GS, bundle) and
                                LogicHelpers.has_item(LocalEvents.DMT_BEAN_PLANTED, bundle)) or
                            (LogicHelpers.can_do_trick(Tricks.DMT_HOVERS_LOWER_GS, bundle) and
                                LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)) or
                            LogicHelpers.can_do_trick(Tricks.DMT_JS_LOWER_GS, bundle)) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.DMT_BLUE_RUPEE_UNDER_BOULDER,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.blast_or_smash(bundle)
                end
            },
            {
                Locations.DMT_RED_RUPEE_UNDER_BOULDER,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.blast_or_smash(bundle)
                end
            },
            {
                Locations.DMT_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                Locations.DMT_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                Locations.DMT_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                Locations.DMT_FLAG_SUNS_SONG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DEATH_MOUNTAIN_TRAIL,
        world,
        {
            {Regions.KAK_BEHIND_GATE, function(bundle)
                    return true
                end},
            {Regions.GORON_CITY, function(bundle)
                    return true
                end},
            {
                Regions.DEATH_MOUNTAIN_SUMMIT,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or
                        (LogicHelpers.is_adult(bundle) and
                            ((LogicHelpers.has_item(LocalEvents.DMT_BEAN_PLANTED, bundle) and
                                LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)) or
                                (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                                    LogicHelpers.can_do_trick(Tricks.DMT_CLIMB_HOVERS, bundle))))
                end
            },
            {
                Regions.DODONGOS_CAVERN_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or
                        LogicHelpers.is_adult(bundle)
                end
            },
            {Regions.DMT_STORMS_GROTTO, function(bundle)
                    return LogicHelpers.can_open_storms_grotto(bundle)
                end}
        }
    )

    --Death Mountain Summit
    --Events
    LogicHelpers.add_events(
        Regions.DEATH_MOUNTAIN_SUMMIT,
        world,
        {
            {
                EventLocations.DMT_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                EventLocations.DMT_BUG_ROCK,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DEATH_MOUNTAIN_SUMMIT,
        world,
        {
            {
                Locations.DMT_TRADE_BROKEN_SWORD,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.BROKEN_GORONS_SWORD, bundle)
                end
            },
            {
                Locations.DMT_TRADE_EYEDROPS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.WORLDS_FINEST_EYEDROPS, bundle)
                end
            },
            {
                Locations.DMT_TRADE_CLAIM_CHECK,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.CLAIM_CHECK, bundle)
                end
            },
            {
                Locations.DMT_GS_FALLING_ROCKS_PATH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.at_night(bundle) and
                        (LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) or
                            LogicHelpers.can_do_trick(Tricks.DMT_UPPER_GS, bundle)) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {Locations.DMT_GOSSIP_STONE_FAIRY, function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end},
            {
                Locations.DMT_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DEATH_MOUNTAIN_SUMMIT,
        world,
        {
            {Regions.DEATH_MOUNTAIN_TRAIL, function(bundle)
                    return true
                end},
            {Regions.DMC_UPPER_LOCAL, function(bundle)
                    return true
                end},
            {Regions.DMT_OWL_FLIGHT, function(bundle)
                    return LogicHelpers.is_child(bundle)
                end},
            {Regions.DMT_COW_GROTTO, function(bundle)
                    return LogicHelpers.blast_or_smash(bundle)
                end},
            {Regions.DMT_GREAT_FAIRY_FOUNTAIN, function(bundle)
                    return LogicHelpers.blast_or_smash(bundle)
                end}
        }
    )

    --Death Mountain Trail Owl Flight
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMT_OWL_FLIGHT,
        world,
        {
            {Regions.KAK_IMPAS_ROOFTOP, function(bundle)
                    return true
                end}
        }
    )

    --Death Mountain Trail Cow Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.DMT_COW_GROTTO,
        world,
        {
            {
                Locations.DMT_COW_GROTTO_COW,
                function(bundle)
                    return LogicHelpers.can_use(Items.EPONAS_SONG, bundle)
                end
            },
            {
                Locations.DMT_COW_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {Locations.DMT_COW_GROTTO_LEFT_HEART, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_MIDDLE_LEFT_HEART, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_MIDDLE_RIGHT_HEART, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RIGHT_HEART, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RUPEE1, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RUPEE2, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RUPEE3, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RUPEE4, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RUPEE5, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RUPEE6, function(bundle)
                    return true
                end},
            {Locations.DMT_COW_GROTTO_RED_RUPEE, function(bundle)
                    return true
                end},
            {
                Locations.DMT_COW_GROTTO_SONG_OF_STORMS_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {Locations.DMT_COW_GROTTO_GRASS1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.DMT_COW_GROTTO_GRASS2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMT_COW_GROTTO,
        world,
        {
            {Regions.DEATH_MOUNTAIN_SUMMIT, function(bundle)
                    return true
                end}
        }
    )

    --Death Mountain Trail Storms Grotto
    --Events
    LogicHelpers.add_events(
        Regions.DMT_STORMS_GROTTO,
        world,
        {
            {
                EventLocations.DMT_STORMS_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.DMT_STORMS_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.DMT_STORMS_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.DMT_STORMS_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DMT_STORMS_GROTTO,
        world,
        {
            {Locations.DMT_STORMS_GROTTO_CHEST, function(bundle)
                    return true
                end},
            {Locations.DMT_STORMS_GROTTO_FISH, function(bundle)
                    return LogicHelpers.has_bottle(bundle)
                end},
            {
                Locations.DMT_STORMS_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.DMT_STORMS_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.DMT_STORMS_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.DMT_STORMS_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {Locations.DMT_STORMS_GROTTO_GRASS1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.DMT_STORMS_GROTTO_GRASS2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.DMT_STORMS_GROTTO_GRASS3, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.DMT_STORMS_GROTTO_GRASS4, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMT_STORMS_GROTTO,
        world,
        {
            {Regions.DEATH_MOUNTAIN_TRAIL, function(bundle)
                    return true
                end}
        }
    )

    --Death Mountain Trail Great Fairy Fountain
    --Locations
    LogicHelpers.add_locations(
        Regions.DMT_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {
                Locations.DMT_GREAT_FAIRY_REWARD,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMT_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {Regions.DEATH_MOUNTAIN_SUMMIT, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
