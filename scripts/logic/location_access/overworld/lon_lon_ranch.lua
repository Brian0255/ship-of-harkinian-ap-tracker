local EventLocations = {
    LLR_TALON_RACE = "LLR Talon Race",
    LLR_TIME_TRIAL = "LLR Time Trial"
}

local function set_region_rules(world)
    --Lon Lon Ranch
    --Events
    LogicHelpers.add_events(
        Regions.LON_LON_RANCH,
        world,
        {
            {
                EventLocations.LLR_TALON_RACE,
                Events.FREED_EPONA,
                function(bundle)
                    return LogicHelpers.has_item(Items.CHILD_WALLET, bundle) or
                        world:get_option("skip_epona_race") and LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle) and
                            LogicHelpers.is_adult(bundle) and
                            LogicHelpers.at_day(bundle)
                end
            },
            {
                EventLocations.LLR_TIME_TRIAL,
                Events.GOTTEN_LINKS_COW,
                function(bundle)
                    return LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and
                        LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle) and
                        LogicHelpers.is_adult(bundle) and
                        LogicHelpers.at_day(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.LON_LON_RANCH,
        world,
        {
            {
                Locations.SONG_FROM_MALON,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.ZELDAS_LETTER, bundle) and
                        LogicHelpers.has_item(Items.FAIRY_OCARINA, bundle) and
                        LogicHelpers.at_day(bundle)
                end
            },
            {
                Locations.LLR_GS_TREE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle)
                end
            },
            {
                Locations.LLR_GS_RAIN_SHED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.LLR_GS_HOUSE_WINDOW,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.LLR_GS_BACK_WALL,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.LLR_FRONT_POT1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_FRONT_POT2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_FRONT_POT3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_FRONT_POT4,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_RAIN_SHED_POT1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_RAIN_SHED_POT2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_RAIN_SHED_POT3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_NEAR_TREE_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.LLR_TREE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LON_LON_RANCH,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            },
            {
                Regions.LLR_TALONS_HOUSE,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.TALONS_HOUSE_KEY, bundle)
                end
            },
            {
                Regions.LLR_STABLES,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.STABLES_KEY, bundle)
                end
            },
            {
                Regions.LLR_TOWER,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.BACK_TOWER_KEY, bundle)
                end
            },
            {
                Regions.LLR_GROTTO,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            }
        }
    )

    --LLR Talons House
    --Locations
    LogicHelpers.add_locations(
        Regions.LLR_TALONS_HOUSE,
        world,
        {
            {
                Locations.LLR_TALONS_CHICKENS,
                function(bundle)
                    return LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and LogicHelpers.is_child(bundle) and
                        LogicHelpers.at_day(bundle) and
                        LogicHelpers.has_item(Items.ZELDAS_LETTER, bundle)
                end
            },
            {
                Locations.LLR_TALONS_HOUSE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_TALONS_HOUSE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.LLR_TALONS_HOUSE_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LLR_TALONS_HOUSE,
        world,
        {
            {
                Regions.LON_LON_RANCH,
                function(bundle)
                    return true
                end
            }
        }
    )

    --LLR Stables
    --Locations
    LogicHelpers.add_locations(
        Regions.LLR_STABLES,
        world,
        {
            {
                Locations.LLR_STABLES_LEFT_COW,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle)
                end
            },
            {
                Locations.LLR_STABLES_RIGHT_COW,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LLR_STABLES,
        world,
        {
            {
                Regions.LON_LON_RANCH,
                function(bundle)
                    return true
                end
            }
        }
    )

    --LLR Tower
    --Locations
    LogicHelpers.add_locations(
        Regions.LLR_TOWER,
        world,
        {
            {
                Locations.LLR_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LLR_TOWER_LEFT_COW,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle)
                end
            },
            {
                Locations.LLR_TOWER_RIGHT_COW,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LLR_TOWER,
        world,
        {
            {
                Regions.LON_LON_RANCH,
                function(bundle)
                    return true
                end
            }
        }
    )

    --LLR Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.LLR_GROTTO,
        world,
        {
            {
                Locations.LLR_DEKU_SCRUB_GROTTO_LEFT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.LLR_DEKU_SCRUB_GROTTO_LEFT,bundle)
                end
            },
            {
                Locations.LLR_DEKU_SCRUB_GROTTO_RIGHT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.LLR_DEKU_SCRUB_GROTTO_RIGHT,bundle)
                end
            },
            {
                Locations.LLR_DEKU_SCRUB_GROTTO_CENTER,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.LLR_DEKU_SCRUB_GROTTO_CENTER,bundle)
                end
            },
            {
                Locations.LLR_DEKU_SCRUB_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LLR_GROTTO,
        world,
        {
            {
                Regions.LON_LON_RANCH,
                function(bundle)
                    return true
                end
            }
        }
    )
end

return set_region_rules
