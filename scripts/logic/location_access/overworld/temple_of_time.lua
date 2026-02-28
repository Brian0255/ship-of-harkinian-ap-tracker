local EventLocations = {
    TOT_ENTRANCE_GOSSIP_STONE_SONG_FAIRY = "ToT Entrance Gossip Stone Fairy",
    CHAMBER_OF_SAGES = "Chamber of Sages"
}

local function set_region_rules(world)
    --ToT Entrance
    --Events
    LogicHelpers.add_events(
        Regions.TOT_ENTRANCE,
        world,
        {
            {
                EventLocations.TOT_ENTRANCE_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.TOT_ENTRANCE,
        world,
        {
            {
                Locations.MARKET_TOT_LEFT_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle) or
                        (LogicHelpers.can_use(Items.SUNS_SONG, bundle) and LogicHelpers.is_adult(bundle))
                end
            },
            {
                Locations.MARKET_TOT_LEFT_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.MARKET_TOT_LEFT_CENTER_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle) or
                        (LogicHelpers.can_use(Items.SUNS_SONG, bundle) and LogicHelpers.is_adult(bundle))
                end
            },
            {
                Locations.MARKET_TOT_LEFT_CENTER_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.MARKET_TOT_RIGHT_CENTER_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle) or
                        (LogicHelpers.can_use(Items.SUNS_SONG, bundle) and LogicHelpers.is_adult(bundle))
                end
            },
            {
                Locations.MARKET_TOT_RIGHT_CENTER_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.MARKET_TOT_RIGHT_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle) or
                        (LogicHelpers.can_use(Items.SUNS_SONG, bundle) and LogicHelpers.is_adult(bundle))
                end
            },
            {
                Locations.MARKET_TOT_RIGHT_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.TOT_ENTRANCE,
        world,
        {
            {
                Regions.MARKET,
                function(bundle)
                    return true
                end
            },
            {
                Regions.TEMPLE_OF_TIME,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Temple of Time
    --Locations
    LogicHelpers.add_locations(
        Regions.TEMPLE_OF_TIME,
        world,
        {
            {
                Locations.MARKET_TOT_LIGHT_ARROW_CUTSCENE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_trigger_lacs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.TEMPLE_OF_TIME,
        world,
        {
            {
                Regions.TOT_ENTRANCE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.BEYOND_DOOR_OF_TIME,
                function(bundle)
                    return world:get_option("door_of_time") == Options.DOOR_TIME_OPEN or
                        (LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) and
                            (world:get_option("door_of_time") == Options.DOOR_TIME_SONG_ONLY or
                                (LogicHelpers.stone_count(bundle) == 3 and
                                    LogicHelpers.has_item(Items.OCARINA_OF_TIME, bundle))))
                end
            }
        }
    )

    --Beyond Door of Time
    --Events
    LogicHelpers.add_events(
        Regions.BEYOND_DOOR_OF_TIME,
        world,
        {
            {
                EventLocations.CHAMBER_OF_SAGES,
                Events.TIME_TRAVEL,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.BEYOND_DOOR_OF_TIME,
        world,
        {
            {
                Locations.GIFT_FROM_RAURU,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.SHEIK_AT_TEMPLE,
                function(bundle)
                    return LogicHelpers.has_item(Items.FOREST_MEDALLION, bundle) and LogicHelpers.is_adult(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.BEYOND_DOOR_OF_TIME,
        world,
        {
            {
                Regions.TEMPLE_OF_TIME,
                function(bundle)
                    return true
                end
            },
            {
                Regions.MASTER_SWORD_PEDESTAL,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )

    --Get Master Sword
    --Locations
    LogicHelpers.add_locations(
        Regions.MASTER_SWORD_PEDESTAL,
        world,
        {
            {
                Locations.MARKET_TOT_MASTER_SWORD,
                function(bundle)
                    return true
                end
            }
        }
    )
end

return set_region_rules
