EventLocations = {
    DESERT_COLOSSUS_FAIRY_POND_COLOSSUS = "Desert Colossus Fairy Pond Colossus",
    DESERT_COLOSSUS_FAIRY_POND_OASIS = "Desert Colossus Fairy Pond Oasis",
    DESERT_COLOSSUS_BUG_ROCK = "Desert Colossus Bug Rock",
    DESERT_COLOSSUS_BEAN_PATCH = "Desert Colossus Bean Patch",
    DESERT_COLOSSUS_DAY_NIGHT_CYCLE_CHILD = "Desert Colossus Day Night Cycle Child",
    DESERT_COLOSSUS_DAY_NIGHT_CYCLE_ADULT = "Desert Colossus Day Night Cycle Adult"
}

local LocalEvents = {
    DESERT_COLOSSUS_BEAN_PLANTED = "Desert Colossus Bean Planted"
}

local function set_region_rules(world)
    --Desert Colossus
    --Events
    LogicHelpers.add_events(
        Regions.DESERT_COLOSSUS,
        world,
        {
            {
                EventLocations.DESERT_COLOSSUS_FAIRY_POND_COLOSSUS,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                EventLocations.DESERT_COLOSSUS_BUG_ROCK,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.DESERT_COLOSSUS_BEAN_PATCH,
                LocalEvents.DESERT_COLOSSUS_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            },
            {
                EventLocations.DESERT_COLOSSUS_DAY_NIGHT_CYCLE_CHILD,
                Events.CHILD_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.DESERT_COLOSSUS_DAY_NIGHT_CYCLE_ADULT,
                Events.ADULT_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DESERT_COLOSSUS,
        world,
        {
            {
                Locations.COLOSSUS_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.has_item(LocalEvents.DESERT_COLOSSUS_BEAN_PLANTED, bundle)
                end
            },
            {
                Locations.COLOSSUS_GS_BEAN_PATCH,
                function(bundle)
                    return LogicHelpers.can_spawn_soil_skull(bundle) and LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.COLOSSUS_GS_TREE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.COLOSSUS_GS_HILL,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        ((LogicHelpers.has_item(LocalEvents.DESERT_COLOSSUS_BEAN_PLANTED, bundle) and
                            LogicHelpers.can_attack(bundle)) or
                            LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.COLOSSUS_GS, bundle) and
                                LogicHelpers.can_use(Items.HOOKSHOT, bundle))) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.COLOSSUS_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.COLOSSUS_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.COLOSSUS_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.COLOSSUS_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.COLOSSUS_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DESERT_COLOSSUS,
        world,
        {
            {
                Regions.DESERT_COLOSSUS_OASIS,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Regions.COLOSSUS_GREAT_FAIRY_FOUNTAIN,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle)
                end
            },
            {Regions.SPIRIT_TEMPLE_ENTRYWAY, function(bundle)
                    return true
                end},
            {Regions.WASTELAND_NEAR_COLOSSUS, function(bundle)
                    return true
                end},
            {
                Regions.COLOSSUS_GROTTO,
                function(bundle)
                    return LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)
                end
            }
        }
    )

    --Desert Colossus Oasis
    --Events
    LogicHelpers.add_events(
        Regions.DESERT_COLOSSUS_OASIS,
        world,
        {
            {
                EventLocations.DESERT_COLOSSUS_FAIRY_POND_OASIS,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DESERT_COLOSSUS_OASIS,
        world,
        {
            {Locations.COLOSSUS_OASIS_FAIRY1, function(bundle)
                    return true
                end},
            {Locations.COLOSSUS_OASIS_FAIRY2, function(bundle)
                    return true
                end},
            {Locations.COLOSSUS_OASIS_FAIRY3, function(bundle)
                    return true
                end},
            {Locations.COLOSSUS_OASIS_FAIRY4, function(bundle)
                    return true
                end},
            {Locations.COLOSSUS_OASIS_FAIRY5, function(bundle)
                    return true
                end},
            {Locations.COLOSSUS_OASIS_FAIRY6, function(bundle)
                    return true
                end},
            {Locations.COLOSSUS_OASIS_FAIRY7, function(bundle)
                    return true
                end},
            {Locations.COLOSSUS_OASIS_FAIRY8, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DESERT_COLOSSUS_OASIS,
        world,
        {
            {Regions.DESERT_COLOSSUS, function(bundle)
                    return true
                end}
        }
    )

    --Desert Colossus Outside Temple
    --Locations
    LogicHelpers.add_locations(
        Regions.DESERT_COLOSSUS_OUTSIDE_TEMPLE,
        world,
        {
            {Locations.SHEIK_AT_COLOSSUS, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DESERT_COLOSSUS_OUTSIDE_TEMPLE,
        world,
        {
            {Regions.DESERT_COLOSSUS, function(bundle)
                    return true
                end}
        }
    )

    --Desert Colossus Great Fairy Fountain
    --Locations
    LogicHelpers.add_locations(
        Regions.COLOSSUS_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {
                Locations.COLOSSUS_GREAT_FAIRY_REWARD,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.COLOSSUS_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {Regions.DESERT_COLOSSUS, function(bundle)
                    return true
                end}
        }
    )

    --Desert Colossus Great Fairy Fountain
    --Locations
    LogicHelpers.add_locations(
        Regions.COLOSSUS_GROTTO,
        world,
        {
            {
                Locations.COLOSSUS_DEKU_SCRUB_GROTTO_REAR,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices", Locations.COLOSSUS_DEKU_SCRUB_GROTTO_REAR, bundle)
                end
            },
            {
                Locations.COLOSSUS_DEKU_SCRUB_GROTTO_FRONT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices", Locations.COLOSSUS_DEKU_SCRUB_GROTTO_FRONT, bundle)
                end
            },
            {
                Locations.COLOSSUS_DEKU_SCRUB_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.COLOSSUS_GROTTO,
        world,
        {
            {Regions.DESERT_COLOSSUS, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
