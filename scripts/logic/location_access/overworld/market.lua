local EventLocations = {
    MARKET_GUARD_HOUSE = "Market Guard House",
    MARKET_MASK_SHOP_MASKS = "Market Mask Shop Masks",
    MARKET_MASK_SHOP_SKULL_MASK = "Market Mask Shop Skull Mask",
    MARKET_MASK_SHOP_SPOOKY_MASK = "Market Mask Shop Spooky Mask",
    MARKET_MASK_SHOP_BUNNY_HOOD = "Market Mask Shop Bunny Hood",
    MARKET_MASK_SHOP_MASK_OF_TRUTH = "Market Mask Shop Mask of Truth",
    MARKET_BOMBCHU_BOWLING_GAME = "Market Bombchu Bowling Game"
}

local function set_region_rules(world)
    --Market Entrance
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_ENTRANCE,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) or LogicHelpers.at_day(bundle))
                end
            },
            {Regions.MARKET, function(bundle)
                    return true
                end},
            {
                Regions.MARKET_GUARD_HOUSE,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.GUARD_HOUSE_KEY, bundle)
                end
            }
        }
    )

    --Market
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET,
        world,
        {
            {
                Locations.MARKET_MARKET_GRASS1,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.MARKET_MARKET_GRASS2,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.MARKET_MARKET_GRASS3,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.MARKET_MARKET_GRASS4,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.MARKET_MARKET_GRASS5,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.MARKET_MARKET_GRASS6,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.MARKET_MARKET_GRASS7,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {
                Locations.MARKET_MARKET_GRASS8,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use_sword(bundle) or LogicHelpers.has_item(Items.GORONS_BRACELET, bundle)))
                end
            },
            {Locations.MARKET_NEAR_BAZAAR_CRATE1, function(bundle)
                    return (LogicHelpers.is_child(bundle))
                end},
            {Locations.MARKET_NEAR_BAZAAR_CRATE2, function(bundle)
                    return (LogicHelpers.is_child(bundle))
                end},
            {
                Locations.MARKET_SHOOTING_GALLERY_CRATE1,
                function(bundle)
                    return (LogicHelpers.is_child(bundle))
                end
            },
            {
                Locations.MARKET_SHOOTING_GALLERY_CRATE2,
                function(bundle)
                    return (LogicHelpers.is_child(bundle))
                end
            },
            {
                Locations.MARKET_TREE,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET,
        world,
        {
            {Regions.MARKET_ENTRANCE, function(bundle)
                    return true
                end},
            {Regions.TOT_ENTRANCE, function(bundle)
                    return true
                end},
            {Regions.CASTLE_GROUNDS, function(bundle)
                    return true
                end},
            {
                Regions.MARKET_BAZAAR,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.MARKET_BAZAAR_KEY, bundle))
                end
            },
            {
                Regions.MARKET_MASK_SHOP,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.MASK_SHOP_KEY, bundle))
                end
            },
            {
                Regions.MARKET_SHOOTING_GALLERY,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.MARKET_SHOOTING_GALLERY_KEY, bundle))
                end
            },
            {
                Regions.MARKET_BOMBCHU_BOWLING,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.BOMBCHU_BOWLING_KEY, bundle))
                end
            },
            {
                Regions.MARKET_TREASURE_CHEST_GAME,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.at_night(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.TREASURE_CHEST_GAME_BUILDING_KEY, bundle))
                end
            },
            {
                Regions.MARKET_POTION_SHOP,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.MARKET_POTION_SHOP_KEY, bundle))
                end
            },
            {Regions.MARKET_BACK_ALLEY, function(bundle)
                    return LogicHelpers.is_child(bundle)
                end}
        }
    )

    --Market Back Alley
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_BACK_ALLEY,
        world,
        {
            {Regions.MARKET, function(bundle)
                    return true
                end},
            {
                Regions.MARKET_BOMBCHU_SHOP,
                function(bundle)
                    return (LogicHelpers.at_night(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.BOMBCHU_SHOP_KEY, bundle))
                end
            },
            {
                Regions.MARKET_DOG_LADY_HOUSE,
                function(bundle)
                    return (LogicHelpers.can_open_overworld_door(Items.RICHARDS_HOUSE_KEY, bundle))
                end
            },
            {
                Regions.MARKET_MAN_IN_GREEN_HOUSE,
                function(bundle)
                    return (LogicHelpers.at_night(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.ALLEY_HOUSE_KEY, bundle))
                end
            }
        }
    )

    --Market Guard House
    --Events
    LogicHelpers.add_events(
        Regions.MARKET_GUARD_HOUSE,
        world,
        {
            {
                EventLocations.MARKET_GUARD_HOUSE,
                Events.CAN_EMPTY_BIG_POES,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_GUARD_HOUSE,
        world,
        {
            {
                Locations.MARKET_10_BIG_POES,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        ((LogicHelpers.has_bottle(bundle) and LogicHelpers.has_item(Events.CAN_DEFEAT_BIG_POE, bundle)) or
                            LogicHelpers.has_item(
                                Items.BOTTLE_WITH_BIG_POE,
                                bundle,
                                world:get_option("big_poe_target_count")
                            )))
                end
            },
            {Locations.MARKET_MARKET_GS_GUARD_HOUSE, function(bundle)
                    return (LogicHelpers.is_child(bundle))
                end},
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT1,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT2,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT3,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT4,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT5,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT6,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT7,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT8,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT9,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT10,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT11,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT12,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT13,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT14,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT15,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT16,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT17,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT18,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT19,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT20,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT21,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT22,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT23,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT24,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT25,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT26,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT27,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT28,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT29,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT30,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT31,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT32,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT33,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT34,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT35,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT36,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT37,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT38,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT39,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT40,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT41,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT42,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT43,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CHILD_POT44,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT1,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT2,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT3,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT4,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT5,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT6,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT7,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT8,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT9,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT10,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_ADULT_POT11,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CRATE1,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CRATE2,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CRATE3,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CRATE4,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle))
                end
            },
            {
                Locations.MARKET_GUARD_HOUSE_CRATE5,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_GUARD_HOUSE,
        world,
        {
            {Regions.MARKET_ENTRANCE, function(bundle)
                    return true
                end}
        }
    )

    --Market Bazaar
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_BAZAAR,
        world,
        {
            {Locations.MARKET_BAZAAR_ITEM1, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM1, bundle)
                end},
            {Locations.MARKET_BAZAAR_ITEM2, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM2, bundle)
                end},
            {Locations.MARKET_BAZAAR_ITEM3, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM3, bundle)
                end},
            {Locations.MARKET_BAZAAR_ITEM4, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM4, bundle)
                end},
            {Locations.MARKET_BAZAAR_ITEM5, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM5, bundle)
                end},
            {Locations.MARKET_BAZAAR_ITEM6, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM6, bundle)
                end},
            {Locations.MARKET_BAZAAR_ITEM7, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM7, bundle)
                end},
            {Locations.MARKET_BAZAAR_ITEM8, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BAZAAR_ITEM8, bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_BAZAAR,
        world,
        {
            {Regions.MARKET, function(bundle)
                    return true
                end}
        }
    )

    --Market Mask Shop
    --Events
    LogicHelpers.add_events(
        Regions.MARKET_MASK_SHOP,
        world,
        {
            {
                EventLocations.MARKET_MASK_SHOP_MASKS,
                Events.CAN_BORROW_MASKS,
                function(bundle)
                    return (LogicHelpers.has_item(Items.ZELDAS_LETTER, bundle) and
                        LogicHelpers.has_item(Events.KAKARIKO_GATE_OPEN, bundle))
                end
            },
            {
                EventLocations.MARKET_MASK_SHOP_SKULL_MASK,
                Events.CAN_BORROW_SKULL_MASK,
                function(bundle)
                    return LogicHelpers.has_item(Events.CAN_BORROW_MASKS, bundle) and
                        (world:get_option("complete_mask_quest") or LogicHelpers.has_item(Events.SOLD_KEATON_MASK, bundle))
                end
            },
            {
                EventLocations.MARKET_MASK_SHOP_SPOOKY_MASK,
                Events.CAN_BORROW_SPOOKY_MASK,
                function(bundle)
                    return LogicHelpers.has_item(Events.CAN_BORROW_MASKS, bundle) and
                        (world:get_option("complete_mask_quest") or LogicHelpers.has_item(Events.SOLD_SKULL_MASK, bundle))
                end
            },
            {
                EventLocations.MARKET_MASK_SHOP_BUNNY_HOOD,
                Events.CAN_BORROW_BUNNY_HOOD,
                function(bundle)
                    return LogicHelpers.has_item(Events.CAN_BORROW_MASKS, bundle) and
                        (world:get_option("complete_mask_quest") or LogicHelpers.has_item(Events.SOLD_SPOOKY_MASK, bundle))
                end
            },
            {
                EventLocations.MARKET_MASK_SHOP_MASK_OF_TRUTH,
                Events.CAN_BORROW_MASK_OF_TRUTH,
                function(bundle)
                    return LogicHelpers.has_item(Events.CAN_BORROW_MASKS, bundle) and
                        (world:get_option("complete_mask_quest") or LogicHelpers.has_item(Events.SOLD_BUNNY_HOOD, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_MASK_SHOP,
        world,
        {
            {Regions.MARKET, function(bundle)
                    return true
                end}
        }
    )

    --Market Shooting Gallery
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_SHOOTING_GALLERY,
        world,
        {
            {
                Locations.MARKET_SHOOTING_GALLERY,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.CHILD_WALLET, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_SHOOTING_GALLERY,
        world,
        {
            {Regions.MARKET, function(bundle)
                    return true
                end}
        }
    )

    --Market Bombchu Bowling
    --Events
    LogicHelpers.add_events(
        Regions.MARKET_BOMBCHU_BOWLING,
        world,
        {
            {
                EventLocations.MARKET_BOMBCHU_BOWLING_GAME,
                Events.COULD_PLAY_BOWLING,
                function(bundle)
                    return LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and LogicHelpers.bombchus_enabled(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_BOMBCHU_BOWLING,
        world,
        {
            {
                Locations.MARKET_BOMBCHU_BOWLING_FIRST_PRIZE,
                function(bundle)
                    return (LogicHelpers.has_item(Events.COULD_PLAY_BOWLING, bundle))
                end
            },
            {
                Locations.MARKET_BOMBCHU_BOWLING_SECOND_PRIZE,
                function(bundle)
                    return (LogicHelpers.has_item(Events.COULD_PLAY_BOWLING, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_BOMBCHU_BOWLING,
        world,
        {
            {Regions.MARKET, function(bundle)
                    return true
                end}
        }
    )

    --Market Potion Shop
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_POTION_SHOP,
        world,
        {
            {Locations.MARKET_POTION_SHOP_ITEM1, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM1, bundle)
                end},
            {Locations.MARKET_POTION_SHOP_ITEM2, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM2, bundle)
                end},
            {Locations.MARKET_POTION_SHOP_ITEM3, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM3, bundle)
                end},
            {Locations.MARKET_POTION_SHOP_ITEM4, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM4, bundle)
                end},
            {Locations.MARKET_POTION_SHOP_ITEM5, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM5, bundle)
                end},
            {Locations.MARKET_POTION_SHOP_ITEM6, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM6, bundle)
                end},
            {Locations.MARKET_POTION_SHOP_ITEM7, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM7, bundle)
                end},
            {Locations.MARKET_POTION_SHOP_ITEM8, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_POTION_SHOP_ITEM8, bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_POTION_SHOP,
        world,
        {
            {Regions.MARKET, function(bundle)
                    return true
                end}
        }
    )

    --Market Treasure Chest Game
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_TREASURE_CHEST_GAME,
        world,
        {
            {
                Locations.MARKET_TREASURE_CHEST_GAME_REWARD,
                function(bundle)
                    return (LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_TREASURE_CHEST_GAME,
        world,
        {
            {Regions.MARKET, function(bundle)
                    return true
                end}
        }
    )

    --Market Bombchu Shop
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_BOMBCHU_SHOP,
        world,
        {
            {Locations.MARKET_BOMBCHU_SHOP_ITEM1, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM1, bundle)
                end},
            {Locations.MARKET_BOMBCHU_SHOP_ITEM2, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM2, bundle)
                end},
            {Locations.MARKET_BOMBCHU_SHOP_ITEM3, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM3, bundle)
                end},
            {Locations.MARKET_BOMBCHU_SHOP_ITEM4, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM4, bundle)
                end},
            {Locations.MARKET_BOMBCHU_SHOP_ITEM5, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM5, bundle)
                end},
            {Locations.MARKET_BOMBCHU_SHOP_ITEM6, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM6, bundle)
                end},
            {Locations.MARKET_BOMBCHU_SHOP_ITEM7, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM7, bundle)
                end},
            {Locations.MARKET_BOMBCHU_SHOP_ITEM8, function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices",Locations.MARKET_BOMBCHU_SHOP_ITEM8, bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_BOMBCHU_SHOP,
        world,
        {
            {Regions.MARKET_BACK_ALLEY, function(bundle)
                    return true
                end}
        }
    )

    --Market Dog Lady House
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_DOG_LADY_HOUSE,
        world,
        {
            {
                Locations.MARKET_LOST_DOG,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.at_night(bundle))
                end
            },
            {
                Locations.MARKET_LOST_DOG_HOUSE_CRATE,
                function(bundle)
                    return (LogicHelpers.can_break_crates(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_DOG_LADY_HOUSE,
        world,
        {
            {Regions.MARKET_BACK_ALLEY, function(bundle)
                    return true
                end}
        }
    )

    --Market Man in Green House
    --Locations
    LogicHelpers.add_locations(
        Regions.MARKET_MAN_IN_GREEN_HOUSE,
        world,
        {
            {
                Locations.MARKET_BACK_ALLEY_HOUSE_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_BACK_ALLEY_HOUSE_POT2,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.MARKET_BACK_ALLEY_HOUSE_POT3,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.MARKET_MAN_IN_GREEN_HOUSE,
        world,
        {
            {Regions.MARKET_BACK_ALLEY, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
