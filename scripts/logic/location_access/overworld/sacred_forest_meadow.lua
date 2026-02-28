local EventLocations = {
    SFM_GOSSIP_STONE_SONG_FAIRY = "SFM Gossip Stone Song Fairy",
    SFM_FAIRY_FOUNTAIN_FAIRY = "SFM Fairy Fountain Fairy"
}

local function set_region_rules(world)
    --SFM Entryway
    --Connections
    LogicHelpers.connect_regions(
        Regions.SFM_ENTRYWAY,
        world,
        {
            {Regions.LW_BEYOND_MIDO, function(bundle)
                    return true
                end},
            {
                Regions.SACRED_FOREST_MEADOW,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS)
                end
            },
            {Regions.SFM_WOLFOS_GROTTO, function(bundle)
                    return LogicHelpers.can_open_bomb_grotto(bundle)
                end}
        }
    )

    --Sacred Forest Meadow
    --Events
    LogicHelpers.add_events(
        Regions.SACRED_FOREST_MEADOW,
        world,
        {
            {
                EventLocations.SFM_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            }
        }
    )
    --Location
    LogicHelpers.add_locations(
        Regions.SACRED_FOREST_MEADOW,
        world,
        {
            {
                Locations.SONG_FROM_SARIA,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.ZELDAS_LETTER, bundle)
                end
            },
            {Locations.SHEIK_IN_FOREST, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end},
            {
                Locations.SFM_GS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.SFM_MAZE_LOWER_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.SFM_MAZE_LOWER_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.SFM_MAZE_UPPER_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.SFM_MAZE_UPPER_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.SFM_SARIA_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.SFM_SARIA_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SACRED_FOREST_MEADOW,
        world,
        {
            {Regions.SFM_ENTRYWAY, function(bundle)
                    return true
                end},
            {
                Regions.FOREST_TEMPLE_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {Regions.SFM_FAIRY_GROTTO, function(bundle)
                    return true
                end},
            {Regions.SFM_STORMS_GROTTO, function(bundle)
                    return LogicHelpers.can_open_storms_grotto(bundle)
                end}
        }
    )

    --SFM Fairy Grotto
    --Events
    LogicHelpers.add_events(
        Regions.SFM_FAIRY_GROTTO,
        world,
        {
            {
                EventLocations.SFM_FAIRY_FOUNTAIN_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.SFM_FAIRY_GROTTO,
        world,
        {
            {Locations.SFM_FAIRY_GROTTO_FAIRY1, function(bundle)
                    return true
                end},
            {Locations.SFM_FAIRY_GROTTO_FAIRY2, function(bundle)
                    return true
                end},
            {Locations.SFM_FAIRY_GROTTO_FAIRY3, function(bundle)
                    return true
                end},
            {Locations.SFM_FAIRY_GROTTO_FAIRY4, function(bundle)
                    return true
                end},
            {Locations.SFM_FAIRY_GROTTO_FAIRY5, function(bundle)
                    return true
                end},
            {Locations.SFM_FAIRY_GROTTO_FAIRY6, function(bundle)
                    return true
                end},
            {Locations.SFM_FAIRY_GROTTO_FAIRY7, function(bundle)
                    return true
                end},
            {Locations.SFM_FAIRY_GROTTO_FAIRY8, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SFM_FAIRY_GROTTO,
        world,
        {
            {Regions.SACRED_FOREST_MEADOW, function(bundle)
                    return true
                end}
        }
    )

    --SFM Wolfos Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.SFM_WOLFOS_GROTTO,
        world,
        {
            {
                Locations.SFM_WOLFOS_GROTTO_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.WOLFOS, EnemyDistance.CLOSE, true, 2)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SFM_WOLFOS_GROTTO,
        world,
        {
            {Regions.SACRED_FOREST_MEADOW, function(bundle)
                    return true
                end}
        }
    )

    --SFM Storms Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.SFM_STORMS_GROTTO,
        world,
        {
            {
                Locations.SFM_DEKU_SCRUB_GROTTO_FRONT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.SFM_DEKU_SCRUB_GROTTO_FRONT,bundle)
                end
            },
            {
                Locations.SFM_DEKU_SCRUB_GROTTO_REAR,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.ZR_DEKU_SCRUB_GROTTO_REAR,bundle)
                end
            },
            {
                Locations.SFM_DEKU_SCRUB_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.SFM_STORMS_GROTTO,
        world,
        {
            {Regions.SACRED_FOREST_MEADOW, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
