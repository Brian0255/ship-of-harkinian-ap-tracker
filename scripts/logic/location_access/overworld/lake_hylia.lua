local EventLocations = {
    LH_BUG_SHRUB = "LH Bug Shrub",
    LH_BEAN_FAIRY = "LH Bean Fairy",
    LH_GOSSIP_STONE_SONG_FAIRY = "LH Gossip Stone Song Fairy",
    LH_BUTTERFLY_FAIRY = "LH Butterfly Fairy",
    CHILD_SCARECROW = "Child Scarecrow",
    ADULT_SCARECROW = "Adult Scarecrow",
    LH_BEAN_PATCH = "LH Bean Patch",
    LH_DAY_NIGHT_CYCLE_CHILD = "LH Day Night Cycle Child",
    LH_DAY_NIGHT_CYCLE_ADULT = "LH Day Night Cycle Adult"
}

local LocalEvents = {
    LH_BEAN_PLANTED = "Lake Hylia Bean Planted"
}

local function set_region_rules(world)
    --Lake Hylia
    --Events
    LogicHelpers.add_events(
        Regions.LAKE_HYLIA,
        world,
        {
            {
                EventLocations.LH_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                EventLocations.LH_BEAN_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                EventLocations.LH_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.STICKS, bundle)
                end
            },
            {
                EventLocations.LH_BUG_SHRUB,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                EventLocations.CHILD_SCARECROW,
                Events.CHILD_SCARECROW_UNLOCKED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.FAIRY_OCARINA, bundle) and
                        LogicHelpers.ocarina_button_count(bundle) >= 2
                end
            },
            {
                EventLocations.ADULT_SCARECROW,
                Events.ADULT_SCARECROW_UNLOCKED,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.FAIRY_OCARINA, bundle) and
                        LogicHelpers.ocarina_button_count(bundle) >= 2
                end
            },
            {
                EventLocations.LH_BEAN_PATCH,
                LocalEvents.LH_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            },
            {
                EventLocations.LH_DAY_NIGHT_CYCLE_CHILD,
                Events.CHILD_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.LH_DAY_NIGHT_CYCLE_ADULT,
                Events.ADULT_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.LAKE_HYLIA,
        world,
        {
            {
                Locations.LH_UNDERWATER_ITEM,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SILVER_SCALE, bundle)
                end
            },
            {
                Locations.LH_SUN,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        ((LogicHelpers.has_item(Events.WATER_TEMPLE_COMPLETED, bundle) and
                            LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)) or
                            LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle)) and
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
                end
            },
            {
                Locations.LH_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.SCARECROW, bundle) or
                            LogicHelpers.has_item(LocalEvents.LH_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.LH_GS_BEAN_PATCH,
                function(bundle)
                    return LogicHelpers.can_spawn_soil_skull(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA)
                end
            },
            {
                Locations.LH_GS_LAB_WALL,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG) or
                            (LogicHelpers.can_do_trick(Tricks.LH_LAB_WALL_GS, bundle) and
                                LogicHelpers.can_jump_slash_except_hammer(bundle))) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.LH_GS_SMALL_ISLAND,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA) and
                        LogicHelpers.can_get_nighttime_gs(bundle) and
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Locations.LH_GS_TREE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.LH_UNDERWATER_FRONT_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Locations.LH_UNDERWATER_MIDDLE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LH_UNDERWATER_BACK_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LH_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LH_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LH_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LH_LAB_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.LH_LAB_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LH_SOUTHEAST_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.LH_SOUTHEAST_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LH_SOUTHWEST_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.LH_SOUTHWEST_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LH_ISLAND_SUNS_SONG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle) and
                        ((LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) and
                            (LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Events.WATER_TEMPLE_COMPLETED, bundle))) or
                            LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle))
                end
            },
            {Locations.LH_GRASS_1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_3, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_4, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_5, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_6, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_7, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_8, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_9, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_10, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_11, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_12, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_13, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_14, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_15, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_16, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_17, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_18, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_19, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_20, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_21, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_22, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_23, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_24, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_25, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_26, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_27, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_28, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_29, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_30, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_31, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_32, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_33, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_34, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_35, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_GRASS_36, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {
                Locations.LH_CHILD_GRASS_1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.LH_CHILD_GRASS_2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.LH_CHILD_GRASS_3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.LH_CHILD_GRASS_4,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {Locations.LH_WARP_PAD_GRASS_1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LH_WARP_PAD_GRASS_2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LAKE_HYLIA,
        world,
        {
            {Regions.HYRULE_FIELD, function(bundle)
                    return true
                end},
            {Regions.LH_FROM_SHORTCUT, function(bundle)
                    return true
                end},
            {Regions.LH_OWL_FLIGHT, function(bundle)
                    return LogicHelpers.is_child(bundle)
                end},
            {
                Regions.LH_FISHING_ISLAND,
                function(bundle)
                    return ((LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Events.WATER_TEMPLE_COMPLETED, bundle)) and
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)) or
                        (LogicHelpers.is_adult(bundle) and
                            (LogicHelpers.can_use(Items.SCARECROW, bundle) or
                                LogicHelpers.has_item(LocalEvents.LH_BEAN_PLANTED, bundle)))
                end
            },
            {
                Regions.LH_LAB,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.HYLIA_LAB_KEY, bundle)
                end
            },
            {Regions.LH_FROM_WATER_TEMPLE, function(bundle)
                    return true
                end},
            {Regions.LH_GROTTO, function(bundle)
                    return true
                end}
        }
    )

    --LH from Shortcut
    --Connections
    LogicHelpers.connect_regions(
        Regions.LH_FROM_SHORTCUT,
        world,
        {
            {
                Regions.LAKE_HYLIA,
                function(bundle)
                    return (LogicHelpers.hearts(bundle) > 1) or LogicHelpers.has_item(Items.BOTTLE_WITH_FAIRY, bundle) or
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            },
            {
                Regions.ZORAS_DOMAIN,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            }
        }
    )

    --LH from Water Temple
    --Connections
    LogicHelpers.connect_regions(
        Regions.LH_FROM_WATER_TEMPLE,
        world,
        {
            {
                Regions.LAKE_HYLIA,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.has_item(Items.BOTTLE_WITH_FAIRY, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            },
            {
                Regions.WATER_TEMPLE_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                        ((LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.LH_WATER_HOOKSHOT, bundle) and
                                LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle))) or
                            (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                                LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle)))
                end
            }
        }
    )

    --LH Fishing Island
    --Connections
    LogicHelpers.connect_regions(
        Regions.LH_FISHING_ISLAND,
        world,
        {
            {Regions.LAKE_HYLIA, function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end},
            {
                Regions.LH_FISHING_HOLE,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.FISHING_HOLE_KEY, bundle)
                end
            }
        }
    )

    --LH Owl Flight
    --Connections
    LogicHelpers.connect_regions(
        Regions.LH_OWL_FLIGHT,
        world,
        {
            {Regions.HYRULE_FIELD, function(bundle)
                    return true
                end}
        }
    )

    --LH Lab
    --Locations
    LogicHelpers.add_locations(
        Regions.LH_LAB,
        world,
        {
            {
                Locations.LH_LAB_DIVE,
                function(bundle)
                    return LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.LH_LAB_DIVING, bundle) and
                            LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                            LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            },
            {
                Locations.LH_LAB_TRADE_EYEBALL_FROG,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.EYEBALL_FROG, bundle)
                end
            },
            {
                Locations.LH_GS_LAB_CRATE,
                function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                        LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.LH_LAB_FRONT_RUPEE,
                function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle)
                end
            },
            {
                Locations.LH_LAB_LEFT_RUPEE,
                function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle)
                end
            },
            {
                Locations.LH_LAB_RIGHT_RUPEE,
                function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle)
                end
            },
            {
                Locations.LH_LAB_CRATE,
                function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LH_LAB,
        world,
        {
            {Regions.LAKE_HYLIA, function(bundle)
                    return true
                end}
        }
    )

    --LH Fishing HOLE
    --Locations
    LogicHelpers.add_locations(
        Regions.LH_FISHING_HOLE,
        world,
        {
            {
                Locations.LH_CHILD_FISHING,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            --These locations need to be adjusted to have the option check when we add the option to split child and adult pond fish
            {
                Locations.LH_CHILD_POND_FISH1,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH2,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH3,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH4,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH5,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH6,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH7,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH8,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH9,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH10,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH11,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH12,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH13,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH14,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_FISH15,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_LOACH1,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_CHILD_POND_LOACH2,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.LH_ADULT_FISHING,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH1,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH2,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH3,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH4,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH5,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH6,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH7,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH8,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH9,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH10,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH11,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH12,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH13,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH14,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_FISH15,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_ADULT_POND_LOACH,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.LH_HYRULE_LOACH_REWARD,
                function(bundle)
                    return LogicHelpers.can_use(Items.FISHING_POLE, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LH_FISHING_HOLE,
        world,
        {
            {Regions.LH_FISHING_ISLAND, function(bundle)
                    return true
                end}
        }
    )

    --LH Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.LH_GROTTO,
        world,
        {
            {
                Locations.LH_DEKU_SCRUB_GROTTO_LEFT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.LH_DEKU_SCRUB_GROTTO_LEFT,bundle)
                end
            },
            {
                Locations.LH_DEKU_SCRUB_GROTTO_RIGHT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.LH_DEKU_SCRUB_GROTTO_RIGHT,bundle)
                end
            },
            {
                Locations.LH_DEKU_SCRUB_GROTTO_CENTER,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.LH_DEKU_SCRUB_GROTTO_CENTER,bundle)
                end
            },
            {
                Locations.LH_DEKU_SCRUB_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LH_GROTTO,
        world,
        {
            {Regions.LAKE_HYLIA, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
