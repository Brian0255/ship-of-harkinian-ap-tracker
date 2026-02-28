local EventLocations = {
    ZR_BUG_GRASS = "ZR Bug Grass",
    MAGIC_BEAN_SALESMAN_SHOP = "Magic Bean Salesman Shop",
    ZR_OPEN_GROTTO_GOSSIP_STONE_SONG_FAIRY = "ZR Upper Grotto Gossip Stone Song Fairy",
    ZR_OPEN_GROTTO_BUTTERFLY_FAIRY = "ZR Upper Grotto Butterfly Fairy",
    ZR_OPEN_GROTTO_BUG_GRASS = "ZR Upper Grotto Bug Grass",
    ZR_OPEN_GROTTO_POND_FISH = "ZR Upper Grotto Pond Fish",
    ZR_BEAN_PATCH = "ZR Bean Patch",
    ZR_DAY_NIGHT_CYCLE_CHILD = "ZR Day Night Cycle Child",
    ZR_DAY_NIGHT_CYCLE_ADULT = "ZR Day Night Cycle Adult"
}

local LocalEvents = {
    ZR_BEAN_PLANTED = "ZR Bean Planted"
}

local function set_region_rules(world)
    --ZR Front
    --Events
    LogicHelpers.add_events(
        Regions.ZR_FRONT,
        world,
        {
            {
                EventLocations.ZR_DAY_NIGHT_CYCLE_CHILD,
                Events.CHILD_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.ZR_DAY_NIGHT_CYCLE_ADULT,
                Events.ADULT_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ZR_FRONT,
        world,
        {
            {
                Locations.ZR_GS_TREE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS4,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS5,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS6,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS7,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS8,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS9,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS10,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS11,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_NEAR_TREE_GRASS12,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_TREE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZR_FRONT,
        world,
        {
            {
                Regions.ZORA_RIVER,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.blast_or_smash(bundle)
                end
            },
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Zora River
    --Events
    LogicHelpers.add_events(
        Regions.ZORA_RIVER,
        world,
        {
            {
                EventLocations.ZR_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle) and
                        (LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            LogicHelpers.can_do_trick(Tricks.ZR_LOWER, bundle))
                end
            },
            {
                EventLocations.ZR_BEAN_PATCH,
                LocalEvents.ZR_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            }
        }
    )
    --Only when selling vanilla item (beans)
    LogicHelpers.add_events(
        Regions.ZORA_RIVER,
        world,
        {
            {
                EventLocations.MAGIC_BEAN_SALESMAN_SHOP,
                Events.CAN_BUY_BEANS,
                function(bundle)
                    return (world:get_option("shuffle_merchants") == Options.MERCHANTS_OFF or
                        world:get_option("shuffle_merchants") == Options.MERCHANTS_ALL_BUT_BEANS) and
                        LogicHelpers.is_child(bundle) and
                        LogicHelpers.has_item(Items.CHILD_WALLET, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ZORA_RIVER,
        world,
        {
            {
                Locations.ZR_MAGIC_BEAN_SALESMAN,
                function(bundle)
                    local shuffled = LogicHelpers.merchant_shuffled(Locations.ZR_MAGIC_BEAN_SALESMAN, bundle)
                    if not shuffled then
                        return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.CHILD_WALLET, bundle)
                    else
                        return LogicHelpers.can_afford_item("merchant_prices", Locations.ZR_MAGIC_BEAN_SALESMAN, bundle)
                    end
                end
            },
            {
                Locations.ZR_FROGS_OCARINA_GAME,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_TIME, bundle) and
                        LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) and
                        LogicHelpers.can_use(Items.SUNS_SONG, bundle) and
                        LogicHelpers.can_use(Items.EPONAS_SONG, bundle) and
                        LogicHelpers.can_use(Items.SARIAS_SONG, bundle))
                end
            },
            {
                Locations.ZR_FROGS_IN_THE_RAIN,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZR_FROGS_ZELDAS_LULLABY,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            },
            {
                Locations.ZR_FROGS_EPONAS_SONG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.EPONAS_SONG, bundle)
                end
            },
            {
                Locations.ZR_FROGS_SARIAS_SONG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SARIAS_SONG, bundle)
                end
            },
            {
                Locations.ZR_FROGS_SUNS_SONG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            },
            {
                Locations.ZR_FROGS_SONG_OF_TIME,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SONG_OF_TIME, bundle)
                end
            },
            {
                Locations.ZR_NEAR_OPEN_GROTTO_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.ZR_LOWER, bundle))
                end
            },
            {
                Locations.ZR_NEAR_DOMAIN_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.ZR_UPPER, bundle))
                end
            },
            {
                Locations.ZR_GS_LADDER,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_attack(bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.ZR_GS_NEAR_RAISED_GROTTOS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.HOOKSHOT, bundle) or LogicHelpers.can_use(Items.BOOMERANG, bundle)) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.ZR_GS_ABOVE_BRIDGE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOOKSHOT, bundle) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.ZR_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZR_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZR_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZR_NEAR_GROTTOS_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.ZR_NEAR_GROTTOS_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZR_NEAR_DOMAIN_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.ZR_NEAR_DOMAIN_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZR_BENEATH_DOMAIN_RED_LEFT_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.ZR_BENEATH_DOMAIN_RED_MIDDLE_LEFT_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.ZR_BENEATH_DOMAIN_RED_MIDDLE_RIGHT_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.ZR_BENEATH_DOMAIN_RED_RIGHT_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.ZR_NEAR_FREESTANDING_POH_GRASS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle) and
                        (LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            LogicHelpers.can_do_trick(Tricks.ZR_LOWER, bundle) or
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZORA_RIVER,
        world,
        {
            {
                Regions.ZR_FRONT,
                function(bundle)
                    return true
                end
            },
            {
                Regions.ZR_OPEN_GROTTO,
                function(bundle)
                    return true
                end
            },
            --I am not sure that there's any scenario where blast or smash wouldn't apply to here, not sure why this needs here (which checks if the other age opened it, basically)?
            {
                Regions.ZR_FAIRY_GROTTO,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle)
                end
            },
            {
                Regions.ZR_FROM_SHORTCUT,
                function(bundle)
                    return LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            },
            {
                Regions.ZR_STORMS_GROTTO,
                function(bundle)
                    return LogicHelpers.can_open_storms_grotto(bundle)
                end
            },
            {
                Regions.ZR_BEHIND_WATERFALL,
                function(bundle)
                    return world:get_option("sleeping_waterfall") == Options.WATERFALL_OPEN or
                        LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) or
                        (LogicHelpers.is_child(bundle) and LogicHelpers.can_do_trick(Tricks.ZR_CUCCO, bundle)) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) and
                            LogicHelpers.can_do_trick(Tricks.ZR_HOVERS, bundle))
                end
            }
        }
    )
    --Events

    --ZR From Shortcut
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZR_FROM_SHORTCUT,
        world,
        {
            {
                Regions.ZORA_RIVER,
                function(bundle)
                    return (LogicHelpers.hearts(bundle) > 1) or LogicHelpers.has_item(Items.BOTTLE_WITH_FAIRY, bundle) or
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle)
                end
            },
            {
                Regions.LOST_WOODS,
                function(bundle)
                    return LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle)
                end
            }
        }
    )

    --ZR Behind Waterfall
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZR_BEHIND_WATERFALL,
        world,
        {
            {
                Regions.ZORA_RIVER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.ZORAS_DOMAIN,
                function(bundle)
                    return true
                end
            }
        }
    )

    --ZR Open Grotto
    --Events
    LogicHelpers.add_events(
        Regions.ZR_OPEN_GROTTO,
        world,
        {
            {
                EventLocations.ZR_OPEN_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.ZR_OPEN_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.ZR_OPEN_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.ZR_OPEN_GROTTO_POND_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.ZR_OPEN_GROTTO,
        world,
        {
            {
                Locations.ZR_OPEN_GROTTO_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_FISH,
                function(bundle)
                    return LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.ZR_OPEN_GROTTO_GRASS4,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZR_OPEN_GROTTO,
        world,
        {
            {
                Regions.ZORA_RIVER,
                function(bundle)
                    return true
                end
            }
        }
    )

    --ZR Fairy Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.ZR_FAIRY_GROTTO,
        world,
        {
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY1,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY2,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY3,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY4,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY5,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY6,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY7,
                function(bundle)
                    return true
                end
            },
            {
                Locations.ZR_FAIRY_GROTTO_FAIRY8,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZR_FAIRY_GROTTO,
        world,
        {
            {
                Regions.ZORA_RIVER,
                function(bundle)
                    return true
                end
            }
        }
    )

    --ZR Storms Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.ZR_STORMS_GROTTO,
        world,
        {
            {
                Locations.ZR_DEKU_SCRUB_GROTTO_FRONT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.ZR_DEKU_SCRUB_GROTTO_FRONT, bundle)
                end
            },
            {
                Locations.ZR_DEKU_SCRUB_GROTTO_REAR,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.ZR_DEKU_SCRUB_GROTTO_REAR, bundle)
                end
            },
            {
                Locations.ZR_STORMS_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.ZR_STORMS_GROTTO,
        world,
        {
            {
                Regions.ZORA_RIVER,
                function(bundle)
                    return true
                end
            }
        }
    )
end

return set_region_rules
