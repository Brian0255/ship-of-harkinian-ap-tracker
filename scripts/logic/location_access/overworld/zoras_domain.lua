local EventLocations = {
    ZD_GOSSIP_STONE_SONG_FAIRY = "ZD Gossip Stone Song Fairy",
    ZD_NUT_POT = "ZD Nut Pot",
    ZD_STICK_POT = "ZD Stick Pot",
    ZD_FISH_GROUP = "ZD Fish Group",
    ZD_KING_ZORA_THAWING = "ZD King Zora Thawing",
    ZD_BEHIND_KING_ZORA_THAWING = "ZD Behind King Zora Thawing",
    ZD_DELIVER_RUTOS_LETTER = "ZD Deliver Ruto's Letter",
    ZD_FAIRY_GROTTO_FAIRY = "ZD Fairy Grotto Fairy"
}

local LocalEvents = {
    KING_ZORA_THAWED = "King Zora Thawed"
}

local function set_region_rules(world)
    --Zoras Domain
    --Events
    LogicHelpers.add_events(
        Regions.ZORAS_DOMAIN,
        world,
        {
            {
                EventLocations.ZD_DELIVER_RUTOS_LETTER,
                Events.DELIVER_LETTER,
                function(bundle)
                    return world:get_option("zoras_fountain") ~= Options.FOUNTAIN_OPEN and
                        LogicHelpers.can_use(Items.BOTTLE_WITH_RUTOS_LETTER, bundle) and
                        LogicHelpers.is_child(bundle)
                end
            }
        }
    )
    LogicHelpers.add_events(
        Regions.ZORAS_DOMAIN,
        world,
        {
            {
                EventLocations.ZD_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                EventLocations.ZD_NUT_POT,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.ZD_STICK_POT,
                Events.CAN_FARM_STICKS,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.ZD_FISH_GROUP,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.ZD_KING_ZORA_THAWING,
                LocalEvents.KING_ZORA_THAWED,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.blue_fire(bundle)
                end
            }
        }
    )

    --Locations
    LogicHelpers.add_locations(
        Regions.ZORAS_DOMAIN,
        world,
        {
            {
                Locations.ZD_DIVING_MINIGAME,
                function(bundle)
                    return LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) and
                        LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and
                        LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.ZD_CHEST,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.STICKS, bundle)
                end
            },
            {
                Locations.ZD_KING_ZORA_THAWED,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(LocalEvents.KING_ZORA_THAWED, bundle)
                end
            },
            {
                Locations.ZD_TRADE_PRESCRIPTION,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(LocalEvents.KING_ZORA_THAWED, bundle) and
                        LogicHelpers.can_use(Items.PRESCRIPTION, bundle)
                end
            },
            {
                Locations.ZD_GS_FROZEN_WATERFALL,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.hookshot_or_boomerang(bundle) or LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle) or
                            LogicHelpers.can_use(Items.FAIRY_BOW, bundle) or
                            (LogicHelpers.can_use(Items.MAGIC_SINGLE, bundle) and
                                (LogicHelpers.can_use(Items.MASTER_SWORD, bundle) or
                                    LogicHelpers.can_use(Items.KOKIRI_SWORD, bundle) or
                                    LogicHelpers.can_use(Items.BIGGORONS_SWORD, bundle)))) or
                        (LogicHelpers.can_do_trick(Tricks.ZD_GS, bundle) and
                            LogicHelpers.can_jump_slash_except_hammer(bundle)) and
                            LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.ZD_FISH1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.ZD_FISH2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.ZD_FISH3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.ZD_FISH4,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.ZD_FISH5,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.ZD_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.ZD_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZD_IN_FRONT_OF_KING_ZORA_BEEHIVE_LEFT,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_upper_beehives(bundle)
                end
            },
            {
                Locations.ZD_IN_FRONT_OF_KING_ZORA_BEEHIVE_RIGHT,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_upper_beehives(bundle)
                end
            },
            {
                Locations.ZD_NEAR_SHOP_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZD_NEAR_SHOP_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZD_NEAR_SHOP_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZD_NEAR_SHOP_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.ZD_NEAR_SHOP_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZORAS_DOMAIN,
        world,
        {
            {
                Regions.ZR_BEHIND_WATERFALL,
                function(bundle)
                    return true
                end
            },
            {
                Regions.LH_FROM_SHORTCUT,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Regions.ZD_BEHIND_KING_ZORA,
                function(bundle)
                    return LogicHelpers.has_item(Events.DELIVER_LETTER, bundle) or
                        world:get_option("zoras_fountain") == Options.FOUNTAIN_OPEN or
                        (world:get_option("zoras_fountain") == Options.FOUNTAIN_CLOSED_CHILD and
                            LogicHelpers.is_adult(bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.ZD_KING_ZORA_SKIP, bundle) and LogicHelpers.is_adult(bundle))
                end
            },
            {
                Regions.ZD_SHOP,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.blue_fire(bundle)
                end
            },
            {
                Regions.ZORAS_DOMAIN_ISLAND,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Zoras Domain Island
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZORAS_DOMAIN_ISLAND,
        world,
        {
            {
                Regions.ZORAS_DOMAIN,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Regions.ZD_STORMS_GROTTO,
                function(bundle)
                    return LogicHelpers.can_open_storms_grotto(bundle)
                end
            }
        }
    )

    --ZD Behind King Zora
    --Events
    LogicHelpers.add_events(
        Regions.ZD_BEHIND_KING_ZORA,
        world,
        {
            {
                EventLocations.ZD_BEHIND_KING_ZORA_THAWING,
                LocalEvents.KING_ZORA_THAWED,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.blue_fire(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ZD_BEHIND_KING_ZORA,
        world,
        {
            {
                Locations.ZD_BEHIND_KING_ZORA_BEEHIVE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZD_BEHIND_KING_ZORA,
        world,
        {
            {
                Regions.ZORAS_DOMAIN,
                function(bundle)
                    return LogicHelpers.has_item(Events.DELIVER_LETTER, bundle) or
                        world:get_option("zoras_fountain") == Options.FOUNTAIN_OPEN or
                        (world:get_option("zoras_fountain") == Options.FOUNTAIN_CLOSED_CHILD and
                            LogicHelpers.is_adult(bundle))
                end
            },
            {
                Regions.ZORAS_FOUNTAIN,
                function(bundle)
                    return true
                end
            }
        }
    )

    --ZD Shop
    --Locations
    LogicHelpers.add_locations(
        Regions.ZD_SHOP,
        world,
        {
            {
                Locations.ZD_SHOP_ITEM1,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM1, bundle)
                end
            },
            {
                Locations.ZD_SHOP_ITEM2,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM2, bundle)
                end
            },
            {
                Locations.ZD_SHOP_ITEM3,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM3, bundle)
                end
            },
            {
                Locations.ZD_SHOP_ITEM4,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM4, bundle)
                end
            },
            {
                Locations.ZD_SHOP_ITEM5,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM5, bundle)
                end
            },
            {
                Locations.ZD_SHOP_ITEM6,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM6, bundle)
                end
            },
            {
                Locations.ZD_SHOP_ITEM7,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM7, bundle)
                end
            },
            {
                Locations.ZD_SHOP_ITEM8,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.ZD_SHOP_ITEM8, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZD_SHOP,
        world,
        {
            {
                Regions.ZORAS_DOMAIN,
                function(bundle)
                    return true
                end
            }
        }
    )

    --ZD Storms Grotto
    --Events
    LogicHelpers.add_events(
        Regions.ZD_STORMS_GROTTO,
        world,
        {
            {
                EventLocations.ZD_FAIRY_GROTTO_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ZD_STORMS_GROTTO,
        world,
        {
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY1,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY2,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY3,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY4,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY5,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY6,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY7,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZD_FAIRY_GROTTO_FAIRY8,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZD_STORMS_GROTTO,
        world,
        {
            {
                Regions.ZORAS_DOMAIN_ISLAND,
                function(bundle)
                    return true
                end
            }
        }
    )
end

return set_region_rules
