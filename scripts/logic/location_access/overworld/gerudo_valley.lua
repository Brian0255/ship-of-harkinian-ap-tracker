local EventLocations = {
    GV_BUG_ROCK = "GV Bug Rock",
    GV_GOSSIP_STONE_SONG_FAIRY = "GV Gossip Stone Song Fairy",
    GV_BEAN_SOIL = "GV Bean Soil",
    GV_BEAN_PATCH = "GV Bean Patch",
    GV_DAY_NIGHT_CYCLE_CHILD = "GV Day Night Cycle Child",
    GV_DAY_NIGHT_CYCLE_ADULT = "GV Day Night Cycle Adult"
}

local LocalEvents = {
    GV_BEAN_PLANTED = "GV Bean Planted"
}

local function set_region_rules(world)
    --Gerudo Valley
    --Events
    LogicHelpers.add_events(
        Regions.GERUDO_VALLEY,
        world,
        {
            {
                EventLocations.GV_BUG_ROCK,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.GV_DAY_NIGHT_CYCLE_CHILD,
                Events.CHILD_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.GV_DAY_NIGHT_CYCLE_ADULT,
                Events.ADULT_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GERUDO_VALLEY,
        world,
        {
            {
                Locations.GV_GS_SMALL_BRIDGE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.BOOMERANG, bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            }
        }
    )
    --Connection
    LogicHelpers.connect_regions(
        Regions.GERUDO_VALLEY,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GV_UPPER_STREAM,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.take_damage(bundle)
                end
            },
            {
                Regions.GV_CRATE_LEDGE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Regions.GV_GROTTO_LEDGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GV_FORTRESS_SIDE,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.EPONA, bundle) or LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                            world:get_option("fortress_carpenters") == 2 or
                            LogicHelpers.has_item(Events.RESCUED_ALL_CARPENTERS, bundle))) or
                        (LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle))
                end
            },
            {
                Regions.GV_LOWER_STREAM,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            }
        }
    )

    --GV Upper Stream
    --Events
    LogicHelpers.add_events(
        Regions.GV_UPPER_STREAM,
        world,
        {
            {
                EventLocations.GV_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                EventLocations.GV_BEAN_SOIL,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                EventLocations.GV_BEAN_PATCH,
                LocalEvents.GV_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GV_UPPER_STREAM,
        world,
        {
            {
                Locations.GV_WATERFALL_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Locations.GV_GS_BEAN_PATCH,
                function(bundle)
                    return LogicHelpers.can_spawn_soil_skull(bundle) and LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.GV_COW,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.EPONAS_SONG, bundle)
                end
            },
            {
                Locations.GV_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.GV_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.GV_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.GV_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.GV_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.GV_NEAR_COW_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_UPPER_STREAM,
        world,
        {
            {
                Regions.GV_LOWER_STREAM,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            }
        }
    )

    --GV Lower Stream
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_LOWER_STREAM,
        world,
        {
            {
                Regions.LAKE_HYLIA,
                function(bundle)
                    return true
                end
            }
        }
    )

    --GV Grotto Ledge
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_GROTTO_LEDGE,
        world,
        {
            {
                Regions.GV_UPPER_STREAM,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST_SIMPLE, bundle) and
                        LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Regions.GV_LOWER_STREAM,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            },
            {
                Regions.GV_OCTOROK_GROTTO,
                function(bundle)
                    return LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)
                end
            },
            {
                Regions.GV_CRATE_LEDGE,
                function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            }
        }
    )

    --GV Crate Ledge
    --Locations
    LogicHelpers.add_locations(
        Regions.GV_CRATE_LEDGE,
        world,
        {
            {
                Locations.GV_CRATE_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GV_FREESTANDING_POH_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_CRATE_LEDGE,
        world,
        {
            {
                Regions.GV_UPPER_STREAM,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST_SIMPLE, bundle) and
                        LogicHelpers.has_explosives(bundle)
                end
            },
            {
                Regions.GV_LOWER_STREAM,
                function(bundle)
                    return LogicHelpers.can_use(Items.BRONZE_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            }
        }
    )

    --GV Fortress Side
    --Locations
    LogicHelpers.add_locations(
        Regions.GV_FORTRESS_SIDE,
        world,
        {
            {
                Locations.GV_CHEST,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            },
            {
                Locations.GV_TRADE_SAW,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.POACHERS_SAW, bundle)
                end
            },
            {
                Locations.GV_GS_BEHIND_TENT,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.GV_GS_PILLAR,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.GV_NEAR_BRIDGE_CRATE1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GV_NEAR_BRIDGE_CRATE2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GV_NEAR_BRIDGE_CRATE3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GV_NEAR_BRIDGE_CRATE4,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_FORTRESS_SIDE,
        world,
        {
            {
                Regions.GERUDO_FORTRESS_OUTSKIRTS,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GV_UPPER_STREAM,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GERUDO_VALLEY,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.EPONA, bundle) or
                        LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                        world:get_option("fortress_carpenters") == 2 or
                        LogicHelpers.has_item(Events.RESCUED_ALL_CARPENTERS, bundle)
                end
            },
            {
                Regions.GV_CARPENTER_TENT,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Regions.GV_STORMS_GROTTO,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_open_storms_grotto(bundle)
                end
            },
            {
                Regions.GV_CRATE_LEDGE,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST_SIMPLE, bundle) and
                        LogicHelpers.has_explosives(bundle)
                end
            }
        }
    )

    --GV Carpenter Tent
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_CARPENTER_TENT,
        world,
        {
            {
                Regions.GV_FORTRESS_SIDE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --GV Octorok Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.GV_OCTOROK_GROTTO,
        world,
        {
            {
                Locations.GV_OCTOROK_GROTTO_FRONT_LEFT_BLUE_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.GV_OCTOROK_GROTTO_FRONT_RIGHT_BLUE_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.GV__OCTOROK_GROTTO_BACK_BLUE_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.GV_OCTOROK_GROTTO_FRONT_LEFT_GREEN_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.GV_OCTOROK_GROTTO_FRONT_RIGHT_GREEN_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.GV_OCTOROK_GROTTO_BACK_LEFT_GREEN_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.GV_OCTOROK_GROTTO_BACK_RIGHT_GREEN_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Locations.GV_OCTOROK_GROTTO_RED_RUPEE,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_OCTOROK_GROTTO,
        world,
        {
            {
                Regions.GV_GROTTO_LEDGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --GV Storms Grotto
    --Locations
    LogicHelpers.add_locations(
    Regions.GV_STORMS_GROTTO,
        world,
        {
            {
                Locations.GV_DEKU_SCRUB_GROTTO_REAR,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.GV_DEKU_SCRUB_GROTTO_REAR, bundle)
                end
            },
            {
                Locations.GV_DEKU_SCRUB_GROTTO_FRONT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.GV_DEKU_SCRUB_GROTTO_FRONT, bundle)
                end
            },
            {
                Locations.GV_DEKU_SCRUB_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GV_STORMS_GROTTO,
        world,
        {
            {
                Regions.GV_FORTRESS_SIDE,
                function(bundle)
                    return true
                end
            }
        }
    )
end

return set_region_rules
