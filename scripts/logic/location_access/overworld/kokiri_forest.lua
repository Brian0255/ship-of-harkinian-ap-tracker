local EventLocations = {
    MIDO = "Mido",
    MIDO_FROM_OUTSIDE_DEKU_TREE = "Mido From Outside Deku Tree",
    KF_GOSSIP_STONE_SONG_FAIRY = "KF Gossip Stone Song Fairy",
    KF_SOFT_SOIL = "KF Soft Soil",
    KF_DEKU_TREE_DEKU_BABA_NUTS = "KF Deku Tree Deku Baba Nuts",
    KF_DEKU_TREE_DEKU_BABA_STICKS = "KF Deku Tree Deku Baba Sticks",
    KF_DEKU_TREE_GOSSIP_STONE_SONG_FAIRY = "KF Deku Tree Gossip Stone Song Fairy",
    KF_STORMS_GROTTO_GOSSIP_STONE_SONG_FAIRY = "KF Storms Grotto Gossip Stone Song Fairy",
    KF_STORMS_GROTTO_BUTTERFLY_FAIRY = "KF Storms Grotto Butterfly Fairy",
    KF_STORMS_GROTTO_BUG_GRASS = "KF Storms Grotto Bugs",
    KF_STORMS_GROTTO_PUDDLE_FISH = "KF Storms Grotto Puddle Fish"
}

local LocalEvents = {
    MIDO_SWORD_AND_SHIELD = "Showed Mido the Sword and Shield",
    KF_BEAN_PLANTED = "KF Bean Planted"
}

local function set_region_rules(world)
    LogicHelpers.add_events(
        Regions.KOKIRI_FOREST,
        world,
        {
            {
                EventLocations.MIDO,
                LocalEvents.MIDO_SWORD_AND_SHIELD,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.KOKIRI_SWORD, bundle) and
                        LogicHelpers.has_item(Items.DEKU_SHIELD, bundle)) or
                        world:get_option("closed_forest") == Options.CLOSED_FOREST_OFF
                end
            },
            {
                EventLocations.KF_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                EventLocations.KF_SOFT_SOIL,
                LocalEvents.KF_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.KOKIRI_FOREST,
        world,
        {
            {
                Locations.KF_KOKIRI_SWORD_CHEST,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_GS_KNOW_IT_ALL_HOUSE,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_attack(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle))
                end
            },
            {
                Locations.KF_GS_BEAN_PATCH,
                function(bundle)
                    return LogicHelpers.can_attack(bundle) and LogicHelpers.is_child(bundle) and
                        LogicHelpers.can_use(Items.BOTTLE_WITH_BUGS, bundle)
                end
            },
            {
                Locations.KF_GS_HOUSE_OF_TWINS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.hookshot_or_boomerang(bundle) or
                            (LogicHelpers.can_do_trick(Tricks.KF_ADULT_GS, bundle) and
                                LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.KF_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.KF_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.KF_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.KF_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.KF_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.KF_BRIDGE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_BEHIND_MIDOS_HOUSE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_SOUTH_GRASS_WEST_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_SOUTH_GRASS_EAST_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_NORTH_GRASS_WEST_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_NORTH_GRASS_EAST_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_BOULDER_MAZE_FIRST_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_BOULDER_MAZE_SECOND_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_BEAN_PLATFORM_RUPEE1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.KF_BEAN_PLATFORM_RUPEE2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.KF_BEAN_PLATFORM_RUPEE3,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.KF_BEAN_PLATFORM_RUPEE4,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.KF_BEAN_PLATFORM_RUPEE5,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.KF_BEAN_PLATFORM_RUPEE6,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.KF_BEAN_PLATFORM_RED_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                            LogicHelpers.has_item(LocalEvents.KF_BEAN_PLANTED, bundle))
                end
            },
            {
                Locations.KF_SARIAS_ROOF_EAST_HEART,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_SARIAS_ROOF_NORTH_HEART,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_SARIAS_ROOF_WEST_HEART,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.KF_CHILD_GRASS1,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS2,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS3,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS4,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS5,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS6,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS7,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS8,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS9,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS10,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS11,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS12,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS_MAZE1,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS_MAZE2,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_CHILD_GRASS_MAZE3,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS1,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS2,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS3,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS4,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS5,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS6,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS7,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS8,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS9,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS10,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS11,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS12,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS13,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS14,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS15,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS16,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS17,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS18,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS19,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.KF_ADULT_GRASS20,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_cut_shrubs(bundle))
                end
            }
        }
    )
    -- Connections
    LogicHelpers.connect_regions(
        Regions.KOKIRI_FOREST,
        world,
        {
            {
                Regions.KF_LINKS_HOUSE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KF_MIDOS_HOUSE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KF_SARIAS_HOUSE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KF_HOUSE_OF_TWINS,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KF_KNOW_IT_ALL_HOUSE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KF_KOKIRI_SHOP,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KF_OUTSIDE_DEKU_TREE,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_pass_enemy(bundle, Enemies.BIG_SKULLTULA) or
                            LogicHelpers.has_item(Events.FOREST_TEMPLE_COMPLETED, bundle))) or
                        (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(LocalEvents.MIDO_SWORD_AND_SHIELD, bundle)) or
                        world:get_option("closed_forest") == Options.CLOSED_FOREST_OFF
                end
            },
            {
                Regions.LOST_WOODS,
                function(bundle)
                    return true
                end
            },
            {
                Regions.LW_BRIDGE_FROM_FOREST,
                function(bundle)
                    return world:get_option("closed_forest") >= 1 or LogicHelpers.is_adult(bundle) or
                        LogicHelpers.has_item(Events.DEKU_TREE_COMPLETED, bundle)
                end
            },
            {
                Regions.KF_STORMS_GROTTO,
                function(bundle)
                    return LogicHelpers.can_open_storms_grotto(bundle)
                end
            }
        }
    )

    --KF Outside Deku Tree
    --Locations
    LogicHelpers.add_events(
        Regions.KF_OUTSIDE_DEKU_TREE,
        world,
        {
            {
                EventLocations.KF_DEKU_TREE_DEKU_BABA_NUTS,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return (LogicHelpers.can_get_deku_baba_nuts(bundle))
                end
            },
            {
                EventLocations.KF_DEKU_TREE_DEKU_BABA_STICKS,
                Events.CAN_FARM_STICKS,
                function(bundle)
                    return (LogicHelpers.can_get_deku_baba_sticks(bundle))
                end
            },
            {
                EventLocations.MIDO_FROM_OUTSIDE_DEKU_TREE,
                LocalEvents.MIDO_SWORD_AND_SHIELD,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.KOKIRI_SWORD, bundle) and
                        LogicHelpers.has_item(Items.DEKU_SHIELD, bundle) or
                        world:get_option("closed_forest") == Options.CLOSED_FOREST_OFF)
                end
            },
            {
                EventLocations.KF_DEKU_TREE_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy_except_suns(bundle))
                end
            }
        }
    )
    LogicHelpers.add_locations(
        Regions.KF_OUTSIDE_DEKU_TREE,
        world,
        {
            {
                Locations.KF_DEKU_TREE_LEFT_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.KF_DEKU_TREE_LEFT_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.KF_DEKU_TREE_RIGHT_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.KF_DEKU_TREE_RIGHT_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_OUTSIDE_DEKU_TREE,
        world,
        {
            {
                Regions.DEKU_TREE_ENTRYWAY,
                function(bundle)
                    return (LogicHelpers.is_child(bundle)) and
                        --Todo: Add dungeons shuffle rule when entrance shuffle is implementedd
                        (world:get_option("closed_forest") == Options.CLOSED_FOREST_OFF or
                            LogicHelpers.has_item(LocalEvents.MIDO_SWORD_AND_SHIELD, bundle))
                end
            },
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_pass_enemy(bundle, Enemies.BIG_SKULLTULA) or
                            LogicHelpers.has_item(Events.FOREST_TEMPLE_COMPLETED, bundle))) or
                        LogicHelpers.has_item(LocalEvents.MIDO_SWORD_AND_SHIELD, bundle) or
                        world:get_option("closed_forest") == Options.CLOSED_FOREST_OFF
                end
            }
        }
    )

    --KF Link's House
    --Locations
    LogicHelpers.add_locations(
        Regions.KF_LINKS_HOUSE,
        world,
        {
            {
                Locations.KF_LINKS_HOUSE_COW,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.EPONAS_SONG, bundle) and
                        LogicHelpers.has_item(Events.GOTTEN_LINKS_COW, bundle)
                end
            },
            {
                Locations.KF_LINKS_HOUSE_POT,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_LINKS_HOUSE,
        world,
        {
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return true
                end
            }
        }
    )

    --KF Mido's House
    --Locations
    LogicHelpers.add_locations(
        Regions.KF_MIDOS_HOUSE,
        world,
        {
            {
                Locations.KF_MIDO_TOP_LEFT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KF_MIDO_TOP_RIGHT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KF_MIDO_BOTTOM_LEFT_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KF_MIDO_BOTTOM_RIGHT_CHEST,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_MIDOS_HOUSE,
        world,
        {
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return true
                end
            }
        }
    )

    --KF Saria's House
    --Locations
    LogicHelpers.add_locations(
        Regions.KF_SARIAS_HOUSE,
        world,
        {
            {
                Locations.KF_SARIAS_HOUSE_TOP_LEFT_HEART,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KF_SARIAS_HOUSE_TOP_RIGHT_HEART,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KF_SARIAS_HOUSE_BOTTOM_LEFT_HEART,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KF_SARIAS_HOUSE_BOTTOM_RIGHT_HEART,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_SARIAS_HOUSE,
        world,
        {
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return true
                end
            }
        }
    )

    --KF House of Twins
    --Locations
    LogicHelpers.add_locations(
        Regions.KF_HOUSE_OF_TWINS,
        world,
        {
            {
                Locations.KF_TWINS_HOUSE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KF_TWINS_HOUSE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_HOUSE_OF_TWINS,
        world,
        {
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return true
                end
            }
        }
    )

    --KF Know it All House
    --Locations
    LogicHelpers.add_locations(
        Regions.KF_KNOW_IT_ALL_HOUSE,
        world,
        {
            {
                Locations.KF_BROTHERS_HOUSE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KF_BROTHERS_HOUSE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_KNOW_IT_ALL_HOUSE,
        world,
        {
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return true
                end
            }
        }
    )

    --KF Kokiri Shop
    --Locations
    LogicHelpers.add_locations(
        Regions.KF_KOKIRI_SHOP,
        world,
        {
            {
                Locations.KF_SHOP_ITEM1,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM1, bundle)
                end
            },
            {
                Locations.KF_SHOP_ITEM2,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM2, bundle)
                end
            },
            {
                Locations.KF_SHOP_ITEM3,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM3, bundle)
                end
            },
            {
                Locations.KF_SHOP_ITEM4,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM4, bundle)
                end
            },
            {
                Locations.KF_SHOP_ITEM5,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM5, bundle)
                end
            },
            {
                Locations.KF_SHOP_ITEM6,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM6, bundle)
                end
            },
            {
                Locations.KF_SHOP_ITEM7,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM7, bundle)
                end
            },
            {
                Locations.KF_SHOP_ITEM8,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.KF_SHOP_ITEM8, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_KOKIRI_SHOP,
        world,
        {
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return true
                end
            }
        }
    )

    --KF Storms Grotto
    --Events
    LogicHelpers.add_events(
        Regions.KF_STORMS_GROTTO,
        world,
        {
            {
                EventLocations.KF_STORMS_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.KF_STORMS_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.KF_STORMS_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.KF_STORMS_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.KF_STORMS_GROTTO,
        world,
        {
            {
                Locations.KF_STORMS_GROTTO_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KF_STORMS_GROTTO_FISH,
                function(bundle)
                    return LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.KF_STORMS_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.KF_STORMS_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.KF_STORMS_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.KF_STORMS_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.KF_STORMS_GROTTO_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KF_STORMS_GROTTO_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KF_STORMS_GROTTO_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KF_STORMS_GROTTO_GRASS4,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KF_STORMS_GROTTO,
        world,
        {
            {
                Regions.KOKIRI_FOREST,
                function(bundle)
                    return true
                end
            }
        }
    )
end

return set_region_rules
