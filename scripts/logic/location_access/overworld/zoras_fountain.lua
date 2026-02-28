local EventLocations = {
    ZF_GOSSIP_STONE_SONG_FAIRY = "ZF Gossip Stone Song Fairy",
    ZF_BUTTERFLY_FAIRY = "ZF Butterfly Fairy"
}

local function set_region_rules(world)
    --Zora's Fountain
    --Events
    LogicHelpers.add_events(
        Regions.ZORAS_FOUNTAIN,
        world,
        {
            {
                EventLocations.ZF_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                EventLocations.ZF_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.STICKS, bundle) and LogicHelpers.at_day(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ZORAS_FOUNTAIN,
        world,
        {
            {
                Locations.ZF_GS_TREE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle)
                end
            },
            {
                Locations.ZF_GS_ABOVE_THE_LOG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.ZF_FAIRY_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.ZF_FAIRY_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZF_JABU_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.ZF_JABU_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZF_NEAR_JABU_POT1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZF_NEAR_JABU_POT2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZF_NEAR_JABU_POT3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZF_NEAR_JABU_POT4,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZF_TREE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZORAS_FOUNTAIN,
        world,
        {
            {Regions.ZD_BEHIND_KING_ZORA, function(bundle)
                    return true
                end},
            {Regions.ZF_ICEBERGS, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end},
            {Regions.ZF_LAKEBED, function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end},
            {
                Regions.ZF_HIDDEN_CAVE,
                function(bundle)
                    return LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and LogicHelpers.blast_or_smash(bundle)
                end
            },
            {
                Regions.ZF_ROCK,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.SCARECROW, bundle)
                end
            },
            {
                Regions.JABU_JABUS_BELLY_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use(Items.BOTTLE_WITH_FISH, bundle) or
                            world:get_option("jabu_jabu") == Options.JABU_OPEN)
                end
            },
            {
                Regions.ZF_GREAT_FAIRY_FOUNTAIN,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle) or
                        (LogicHelpers.can_do_trick(Tricks.ZF_GREAT_FAIRY_WITHOUT_EXPLOSIVES, bundle) and
                            LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) and
                            LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle))
                end
            }
        }
    )

    --Zora's Fountains Icebergs
    --Locations
    LogicHelpers.add_locations(
        Regions.ZF_ICEBERGS,
        world,
        {
            {Locations.ZF_ICEBERG_FREESTANDING_POH, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZF_ICEBERGS,
        world,
        {
            {
                Regions.ZORAS_FOUNTAIN,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            },
            {Regions.ZF_LAKEBED, function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end},
            {Regions.ZF_LEDGE, function(bundle)
                    return true
                end}
        }
    )

    --Zora's Fountain Lakebed
    --Locations
    LogicHelpers.add_locations(
        Regions.ZF_LAKEBED,
        world,
        {
            {
                Locations.ZF_BOTTOM_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTH_INNER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTHEAST_INNER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTHEAST_INNER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTH_INNER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTHWEST_INNER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTHWEST_INNER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTH_MIDDLE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTHEAST_MIDDLE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTHEAST_MIDDLE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTH_MIDDLE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTHWEST_MIDDLE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTHWEST_MIDDLE_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTH_OUTER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTHEAST_OUTER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTHEAST_OUTER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTH_OUTER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_SOUTHWEST_OUTER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            },
            {
                Locations.ZF_BOTTOM_NORTHWEST_OUTER_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.IRON_BOOTS, bundle) and
                        LogicHelpers.water_timer(bundle) >= 16
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZF_LAKEBED,
        world,
        {
            {Regions.ZORAS_FOUNTAIN, function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end}
        }
    )

    --Zora's Fountain Ledge
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZF_LEDGE,
        world,
        {
            {Regions.ZORAS_FOUNTAIN, function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end},
            {Regions.ZF_ICEBERGS, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end},
            {Regions.ZF_LAKEBED, function(bundle)
                    return LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end},
            {Regions.ICE_CAVERN_ENTRYWAY, function(bundle)
                    return true
                end}
        }
    )

    --Zora's Fountain Hidden Cave
    --Locations
    LogicHelpers.add_locations(
        Regions.ZF_HIDDEN_CAVE,
        world,
        {
            {
                Locations.ZF_HIDDEN_CAVE_POT1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZF_HIDDEN_CAVE_POT2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZF_HIDDEN_CAVE_POT3,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZF_HIDDEN_CAVE,
        world,
        {
            {Regions.ZF_HIDDEN_LEDGE, function(bundle)
                    return true
                end}
        }
    )

    --Zora's Fountain Hidden Ledge
    --Locations
    LogicHelpers.add_locations(
        Regions.ZF_HIDDEN_LEDGE,
        world,
        {
            {
                Locations.ZF_GS_HIDDEN_CAVE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOMB_THROW) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZF_HIDDEN_LEDGE,
        world,
        {
            {
                Regions.ZORAS_FOUNTAIN,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or LogicHelpers.take_damage(bundle)
                end
            },
            {Regions.ZF_HIDDEN_CAVE, function(bundle)
                    return true
                end}
        }
    )

    --Zora's Fountain Rock
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZF_ROCK,
        world,
        {
            {Regions.ZORAS_FOUNTAIN, function(bundle)
                    return true
                end}
        }
    )

    --Zora's Fountain Great Fairy Fountain
    --Locations
    LogicHelpers.add_locations(
        Regions.ZF_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {
                Locations.ZF_GREAT_FAIRY_REWARD,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZF_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {Regions.ZORAS_FOUNTAIN, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
