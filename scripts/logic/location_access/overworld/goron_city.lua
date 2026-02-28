local EventLocations = {
    GC_GOSSIP_STONE_SONG_FAIRY = "GC Gossip Stone Song Fairy",
    GC_STICK_POT = "GC Stick Pot",
    GC_BUG_ROCK = "GC Bug Rock",
    GC_DARUNIAS_CHAMBER_TORCH = "GC Darunias Chamber Torch",
    GC_FIRE_AROUND_POT = "GC Fire Around Pot",
    GC_WOODS_WARP = "GC Woods Warp",
    GC_WOODS_WARP_FROM_WOODS = "GC Woods Warp From Woods",
    GC_DARUNIAS_DOOR_AS_CHILD = "GC Darunias Door as Child",
    GC_STOP_ROLLING_GORON_AS_ADULT = "GC Stop Rolling Goron as Adult"
}

local LocalEvents = {
    GC_CHILD_FIRE_LIT = "GC Child Fire Lit",
    GC_WOODS_WARP_OPEN = "GC Woods Warp Open",
    GC_DARUNIAS_DOOR_OPENED_AS_CHILD = "GC Darunias Door Opened as Child",
    GC_STOP_ROLLING_GORON_AS_ADULT = "GC Stop Rolling Goron As Adult"
}

local function set_region_rules(world)
    --Goron City
    --Events
    LogicHelpers.add_events(
        Regions.GORON_CITY,
        world,
        {
            {
                EventLocations.GC_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                EventLocations.GC_STICK_POT,
                Events.CAN_FARM_STICKS,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.GC_BUG_ROCK,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)
                end
            },
            {
                EventLocations.GC_FIRE_AROUND_POT,
                LocalEvents.GC_CHILD_FIRE_LIT,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.DINS_FIRE, bundle)
                end
            },
            {
                EventLocations.GC_WOODS_WARP,
                LocalEvents.GC_WOODS_WARP_OPEN,
                function(bundle)
                    return LogicHelpers.can_detonate_upright_bomb_flower(bundle) or
                        LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) or
                        LogicHelpers.has_item(LocalEvents.GC_CHILD_FIRE_LIT, bundle)
                end
            },
            {
                EventLocations.GC_DARUNIAS_DOOR_AS_CHILD,
                LocalEvents.GC_DARUNIAS_DOOR_OPENED_AS_CHILD,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            },
            {
                EventLocations.GC_STOP_ROLLING_GORON_AS_ADULT,
                LocalEvents.GC_STOP_ROLLING_GORON_AS_ADULT,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or LogicHelpers.has_explosives(bundle) or
                            LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.GC_LINK_GORON_DINS, bundle) and
                                (LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                                    (LogicHelpers.can_do_trick(Tricks.BLUE_FIRE_MUD_WALLS, bundle) and
                                        LogicHelpers.can_use(Items.BOTTLE_WITH_BLUE_FIRE, bundle)))))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GORON_CITY,
        world,
        {
            {
                Locations.GC_MAZE_LEFT_CHEST,
                function(bundle)
                    return LogicHelpers.can_use_any({Items.MEGATON_HAMMER, Items.SILVER_GAUNTLETS}, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.GC_LEFTMOST, bundle) and LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))
                end
            },
            {
                Locations.GC_MAZE_CENTER_CHEST,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)
                end
            },
            {
                Locations.GC_MAZE_RIGHT_CHEST,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)
                end
            },
            {
                Locations.GC_POT_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(LocalEvents.GC_CHILD_FIRE_LIT, bundle) and
                        (LogicHelpers.can_use(Items.BOMB_BAG, bundle) or
                            (LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                                LogicHelpers.can_do_trick(Tricks.GC_POT_STRENGTH, bundle)) or
                            (LogicHelpers.can_use(Items.BOMBCHUS_5, bundle) and
                                LogicHelpers.can_do_trick(Tricks.GC_POT, bundle)))
                end
            },
            {
                Locations.GC_ROLLING_GORON_AS_CHILD,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_explosives(bundle) or
                            (LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) and
                                LogicHelpers.can_do_trick(Tricks.GC_ROLLING_STRENGTH, bundle)))
                end
            },
            {
                Locations.GC_ROLLING_GORON_AS_ADULT,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(LocalEvents.GC_STOP_ROLLING_GORON_AS_ADULT, bundle)
                end
            },
            {
                Locations.GC_GS_BOULDER_MAZE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.blast_or_smash(bundle)
                end
            },
            {
                Locations.GC_GS_CENTER_PLATFORM,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.GC_MEDIGORON,
                function(bundle)
                    local can_afford = LogicHelpers.has_item(Items.ADULT_WALLET, bundle)
                    if LogicHelpers.merchant_shuffled(Locations.GC_MEDIGORON, bundle) then
                        can_afford = LogicHelpers.can_afford_item("merchant_prices",Locations.GC_MEDIGORON,bundle)
                    end
                    return LogicHelpers.is_adult(bundle) and can_afford and
                        (LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle))
                end
            },
            {
                Locations.GC_MAZE_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return (LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)) and
                        LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.GC_MAZE_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return (LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle)) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {Locations.GC_LOWER_STAIRCASE_POT1, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.GC_LOWER_STAIRCASE_POT2, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.GC_UPPER_STAIRCASE_POT1, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.GC_UPPER_STAIRCASE_POT2, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.GC_UPPER_STAIRCASE_POT3, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {
                Locations.GC_MAZE_CRATE,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or
                        (LogicHelpers.can_use(Items.SILVER_GAUNTLETS, bundle) and LogicHelpers.can_break_crates(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GORON_CITY,
        world,
        {
            {Regions.DEATH_MOUNTAIN_TRAIL, function(bundle)
                    return true
                end},
            {
                Regions.GC_MEDIGORON,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)
                end
            },
            {
                Regions.GC_WOODS_WARP,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.GC_WOODS_WARP_OPEN, bundle)
                end
            },
            {
                Regions.GC_SHOP,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        LogicHelpers.has_item(LocalEvents.GC_STOP_ROLLING_GORON_AS_ADULT, bundle)) or
                        (LogicHelpers.is_child(bundle) and
                            (LogicHelpers.blast_or_smash(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle) or
                                LogicHelpers.has_item(LocalEvents.GC_CHILD_FIRE_LIT, bundle) or
                                LogicHelpers.can_use(Items.FAIRY_BOW, bundle)))
                end
            },
            {
                Regions.GC_DARUNIAS_CHAMBER,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        LogicHelpers.has_item(LocalEvents.GC_STOP_ROLLING_GORON_AS_ADULT, bundle)) or
                        (LogicHelpers.is_child(bundle) and
                            LogicHelpers.has_item(LocalEvents.GC_DARUNIAS_DOOR_OPENED_AS_CHILD, bundle))
                end
            },
            {
                Regions.GC_GROTTO_PLATFORM,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        ((LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) and
                            ((LogicHelpers.effective_health(bundle) > 2) or LogicHelpers.can_use(Items.GORON_TUNIC, bundle) or
                                LogicHelpers.can_use(Items.LONGSHOT, bundle) or
                                LogicHelpers.can_use(Items.NAYRUS_LOVE, bundle))) or
                            (LogicHelpers.effective_health(bundle) > 1 and LogicHelpers.can_use(Items.GORON_TUNIC, bundle) and
                                LogicHelpers.can_use(Items.HOOKSHOT, bundle)) or
                            (LogicHelpers.can_use(Items.NAYRUS_LOVE, bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle)) or
                            (LogicHelpers.effective_health(bundle) > 2 and LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                                LogicHelpers.can_do_trick(Tricks.GC_GROTTO, bundle)))
                end
            }
        }
    )

    --Goron City Medigoron
    --Locations
    LogicHelpers.add_locations(
        Regions.GC_MEDIGORON,
        world,
        {
            {
                Locations.GC_MEDIGORON_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.GC_MEDIGORON_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {Locations.GC_MEDIGORON_POT1, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GC_MEDIGORON,
        world,
        {
            {Regions.GORON_CITY, function(bundle)
                    return true
                end}
        }
    )

    --Goron City Woods Warp
    --Events
    LogicHelpers.add_events(
        Regions.GC_WOODS_WARP,
        world,
        {
            {
                EventLocations.GC_WOODS_WARP_FROM_WOODS,
                LocalEvents.GC_WOODS_WARP_OPEN,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) or LogicHelpers.can_use(Items.DINS_FIRE, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GC_WOODS_WARP,
        world,
        {
            {
                Regions.GORON_CITY,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.GC_WOODS_WARP_OPEN, bundle)
                end
            },
            {Regions.LOST_WOODS, function(bundle)
                    return true
                end}
        }
    )

    --Goron City Darunias Chamber
    --Events
    LogicHelpers.add_events(
        Regions.GC_DARUNIAS_CHAMBER,
        world,
        {
            {
                EventLocations.GC_DARUNIAS_CHAMBER_TORCH,
                LocalEvents.GC_CHILD_FIRE_LIT,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.STICKS, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GC_DARUNIAS_CHAMBER,
        world,
        {
            {
                Locations.GC_DARUNIAS_JOY,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SARIAS_SONG, bundle)
                end
            },
            {Locations.GC_DARUNIA_POT1, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.GC_DARUNIA_POT2, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.GC_DARUNIA_POT3, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GC_DARUNIAS_CHAMBER,
        world,
        {
            {Regions.GORON_CITY, function(bundle)
                    return true
                end},
            {Regions.DMC_LOWER_LOCAL, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end}
        }
    )

    --Goron City Grotto Platform
    --Connections
    LogicHelpers.connect_regions(
        Regions.GC_GROTTO_PLATFORM,
        world,
        {
            {Regions.GC_GROTTO, function(bundle)
                    return true
                end},
            {
                Regions.GORON_CITY,
                function(bundle)
                    return LogicHelpers.effective_health(bundle) > 2 or
                        LogicHelpers.can_use_any({Items.GORON_TUNIC, Items.NAYRUS_LOVE}, bundle) or
                        ((LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.SONG_OF_TIME, bundle)) and
                            LogicHelpers.can_use(Items.LONGSHOT, bundle))
                end
            }
        }
    )

    --Goron City Shop
    --Locations
    LogicHelpers.add_locations(
        Regions.GC_SHOP,
        world,
        {
            {Locations.GC_SHOP_ITEM1, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM1, bundle)
                end},
            {Locations.GC_SHOP_ITEM2, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM2, bundle)
                end},
            {Locations.GC_SHOP_ITEM3, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM3, bundle)
                end},
            {Locations.GC_SHOP_ITEM4, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM4, bundle)
                end},
            {Locations.GC_SHOP_ITEM5, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM5, bundle)
                end},
            {Locations.GC_SHOP_ITEM6, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM6, bundle)
                end},
            {Locations.GC_SHOP_ITEM7, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM7, bundle)
                end},
            {Locations.GC_SHOP_ITEM8, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.GC_SHOP_ITEM8, bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GC_SHOP,
        world,
        {
            {Regions.GORON_CITY, function(bundle)
                    return true
                end}
        }
    )

    --Goron City Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.GC_GROTTO,
        world,
        {
            {
                Locations.GC_DEKU_SCRUB_GROTTO_LEFT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices", Locations.GC_DEKU_SCRUB_GROTTO_LEFT, bundle)
                end
            },
            {
                Locations.GC_DEKU_SCRUB_GROTTO_RIGHT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices", Locations.GC_DEKU_SCRUB_GROTTO_RIGHT, bundle)
                end
            },
            {
                Locations.GC_DEKU_SCRUB_GROTTO_CENTER,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices", Locations.GC_DEKU_SCRUB_GROTTO_RIGHT, bundle)
                end
            },
            {Locations.GC_GROTTO_BEEHIVE, function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GC_GROTTO,
        world,
        {
            {Regions.GC_GROTTO_PLATFORM, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
