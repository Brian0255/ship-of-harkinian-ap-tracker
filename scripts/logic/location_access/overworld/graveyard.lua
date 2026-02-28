local EventLocations = {
    GRAVEYARD_BUTTERFLY_FAIRY = "Graveyard Butterfly Fairy",
    GRAVEYARD_BEAN_PLANT_FAIRY = "Graveyard Bean Plant Fairy",
    GRAVEYARD_BUG_ROCK = "Graveyard Bug Rock",
    GRAVEYARD_SOLD_SPOOKY_MASK = "Graveyard Sold Spooky Mask",
    GRAVEYARD_DAMPES_GRAVE_NUT_POT = "Graveyard Dampes Grave Nut Pot",
    GRAVEYARD_DAMPES_WINDMILL_ACCESS = "Graveyard Dampes Windmill Access",
    GRAVEYARD_GOSSIP_STONE_SONG_FAIRY = "Graveyard Gossip Stone Song Fairy",
    GRAVEYARD_BEAN_PATCH = "Graveyard Bean Patch"
}

local LocalEvents = {
    ACCESS_TO_WINDMILL_FROM_DAMPES_GRAVE = "Access to Windmill From Dampes Grave",
    GRAVEYARD_BEAN_PLANTED = "Graveyard Bean Planted"
}

local function set_region_rules(world)
    --The Graveyard
    --Events
    LogicHelpers.add_events(
        Regions.THE_GRAVEYARD,
        world,
        {
            {
                EventLocations.GRAVEYARD_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.STICKS, bundle) and LogicHelpers.at_day(bundle)
                end
            },
            {
                EventLocations.GRAVEYARD_BEAN_PLANT_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                EventLocations.GRAVEYARD_BUG_ROCK,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.GRAVEYARD_SOLD_SPOOKY_MASK,
                Events.SOLD_SPOOKY_MASK,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.has_item(Events.CAN_BORROW_SPOOKY_MASK, bundle) and
                        LogicHelpers.has_item(Items.CHILD_WALLET, bundle)
                end
            },
            {
                EventLocations.GRAVEYARD_BEAN_PATCH,
                LocalEvents.GRAVEYARD_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.THE_GRAVEYARD,
        world,
        {
            {
                Locations.GRAVEYARD_FREESTANDING_POH,
                function(bundle)
                    return (((LogicHelpers.is_adult(bundle) and
                        LogicHelpers.has_item(LocalEvents.GRAVEYARD_BEAN_PLANTED, bundle)) or
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)) and
                        LogicHelpers.can_break_crates(bundle)) or
                        (LogicHelpers.can_do_trick(Tricks.GY_POH, bundle) and LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.GRAVEYARD_DAMPE_GRAVEDIGGING_TOUR,
                function(bundle)
                    return LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and LogicHelpers.is_child(bundle) and
                        LogicHelpers.at_night(bundle)
                end
            },
            {
                Locations.GRAVEYARD_GS_WALL,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.hookshot_or_boomerang(bundle) and
                        LogicHelpers.at_night(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.GRAVEYARD_GS_BEAN_PATCH,
                function(bundle)
                    return LogicHelpers.can_spawn_soil_skull(bundle) and LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.GRAVEYARD_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.GRAVEYARD_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.GRAVEYARD_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {Locations.GRAVEYARD_GRASS_1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_3, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_4, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_5, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_6, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_7, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_8, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_9, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_10, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_11, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.GRAVEYARD_GRASS_12, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {
                Locations.GRAVEYARD_FREESTANDING_POH_CRATE,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        LogicHelpers.has_item(LocalEvents.GRAVEYARD_BEAN_PLANTED, bundle)) or
                        LogicHelpers.can_use(Items.LONGSHOT, bundle) and LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THE_GRAVEYARD,
        world,
        {
            {
                Regions.GRAVEYARD_SHIELD_GRAVE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.at_night(bundle)
                end
            },
            {
                Regions.GRAVEYARD_COMPOSERS_GRAVE,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            },
            {
                Regions.GRAVEYARD_HEART_PIECE_GRAVE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.at_night(bundle)
                end
            },
            {Regions.GRAVEYARD_DAMPES_GRAVE, function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end},
            {
                Regions.GRAVEYARD_DAMPES_HOUSE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.DAMPES_HUT_KEY, bundle)
                end
            },
            {Regions.KAKARIKO_VILLAGE, function(bundle)
                    return true
                end},
            {Regions.GRAVEYARD_WARP_PAD_REGION, function(bundle)
                    return false
                end}
        }
    )

    --The Graveyard Shield Grave
    --Locations
    LogicHelpers.add_locations(
        Regions.GRAVEYARD_SHIELD_GRAVE,
        world,
        {
            {Locations.GRAVEYARD_SHIELD_GRAVE_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GRAVEYARD_SHIELD_GRAVE,
        world,
        {
            {Regions.THE_GRAVEYARD, function(bundle)
                    return true
                end},
            {
                Regions.GRAVEYARD_SHIELD_GRAVE_BACK,
                function(bundle)
                    return LogicHelpers.can_break_mud_walls(bundle)
                end
            }
        }
    )

    --The Graveyard Shield Grave Back
    --Locations
    LogicHelpers.add_locations(
        Regions.GRAVEYARD_SHIELD_GRAVE_BACK,
        world,
        {
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY1, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY2, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY3, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY4, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY5, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY6, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY7, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_SHIELD_GRAVE_FAIRY8, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GRAVEYARD_SHIELD_GRAVE_BACK,
        world,
        {
            {Regions.GRAVEYARD_SHIELD_GRAVE, function(bundle)
                    return true
                end}
        }
    )

    --The Graveyard Heart Piece Grave
    --Locations
    LogicHelpers.add_locations(
        Regions.GRAVEYARD_HEART_PIECE_GRAVE,
        world,
        {
            {
                Locations.GRAVEYARD_HEART_PIECE_GRAVE_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GRAVEYARD_HEART_PIECE_GRAVE,
        world,
        {
            {Regions.THE_GRAVEYARD, function(bundle)
                    return true
                end}
        }
    )

    --The Graveyard Composers Grave
    --Locations
    LogicHelpers.add_locations(
        Regions.GRAVEYARD_COMPOSERS_GRAVE,
        world,
        {
            {
                Locations.GRAVEYARD_ROYAL_FAMILYS_TOMB_CHEST,
                function(bundle)
                    return LogicHelpers.has_fire_source(bundle)
                end
            },
            {
                Locations.SONG_FROM_ROYAL_FAMILYS_TOMB,
                function(bundle)
                    return LogicHelpers.can_use_projectile(bundle) or LogicHelpers.can_jump_slash(bundle)
                end
            },
            {
                Locations.GRAVEYARD_ROYAL_FAMILYS_TOMB_SUNS_SONG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GRAVEYARD_COMPOSERS_GRAVE,
        world,
        {
            {Regions.THE_GRAVEYARD, function(bundle)
                    return true
                end}
        }
    )

    --The Graveyard Dampes Grave
    --Events
    LogicHelpers.add_events(
        Regions.GRAVEYARD_DAMPES_GRAVE,
        world,
        {
            {
                EventLocations.GRAVEYARD_DAMPES_GRAVE_NUT_POT,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.GRAVEYARD_DAMPES_WINDMILL_ACCESS,
                Events.DAMPES_WINDMILL_ACCESS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.SONG_OF_TIME, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GRAVEYARD_DAMPES_GRAVE,
        world,
        {
            {Locations.GRAVEYARD_HOOKSHOT_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.GRAVEYARD_DAMPE_RACE_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.can_do_trick(Tricks.GY_CHILD_DAMPE_RACE_POH, bundle)
                end
            },
            {
                Locations.GRAVEYARD_DAMPES_GRAVE_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GRAVEYARD_DAMPES_GRAVE_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GRAVEYARD_DAMPES_GRAVE_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GRAVEYARD_DAMPES_GRAVE_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GRAVEYARD_DAMPES_GRAVE_POT5,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.GRAVEYARD_DAMPES_GRAVE_POT6,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE1, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE2, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE3, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE4, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE5, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE6, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE7, function(bundle)
                    return true
                end},
            {Locations.GRAVEYARD_DAMPES_GRAVE_RUPEE8, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GRAVEYARD_DAMPES_GRAVE,
        world,
        {
            {Regions.THE_GRAVEYARD, function(bundle)
                    return true
                end},
            {
                Regions.KAK_WINDMILL,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.SONG_OF_TIME, bundle)) or
                        (LogicHelpers.is_child(bundle) and LogicHelpers.can_ground_jump(bundle))
                end
            }
        }
    )

    --The Graveyard Dampes House
    --Connections
    LogicHelpers.connect_regions(
        Regions.GRAVEYARD_DAMPES_HOUSE,
        world,
        {
            {Regions.THE_GRAVEYARD, function(bundle)
                    return true
                end}
        }
    )

    --The Graveyard Warp Pad Region
    --Events
    LogicHelpers.add_events(
        Regions.GRAVEYARD_WARP_PAD_REGION,
        world,
        {
            {
                EventLocations.GRAVEYARD_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GRAVEYARD_WARP_PAD_REGION,
        world,
        {
            {
                Locations.GRAVEYARD_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.GRAVEYARD_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GRAVEYARD_WARP_PAD_REGION,
        world,
        {
            {Regions.THE_GRAVEYARD, function(bundle)
                    return true
                end},
            {
                Regions.SHADOW_TEMPLE_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.can_use(Items.DINS_FIRE, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.GY_SHADOW_FIRE_ARROWS, bundle) and LogicHelpers.is_adult(bundle) and
                            LogicHelpers.can_use(Items.FIRE_ARROW, bundle))
                end
            }
        }
    )
end

return set_region_rules
