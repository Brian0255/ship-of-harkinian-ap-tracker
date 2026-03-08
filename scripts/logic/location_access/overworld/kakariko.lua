local EventLocations = {
    KAK_GATE = "Kak Gate",
    KAK_GATE_GUARD = "Kak Gate Guard",
    KAK_BUG_ROCK = "Kak Bug Rock",
    KAK_ADULT_TALON = "Kak Adult Talon",
    KAK_WINDMILL_PHONOGRAM_MAN = "Kak Windmill Phonogram Man",
    KAK_OPEN_GROTTO_GOSSIP_STONE_SONG_FAIRY = "Kak Open Grotto Gossip Stone Song Fairy",
    KAK_OPEN_GROTTO_BUTTERFLY_FAIRY = "Kak Open Grotto Butterfly Fairy",
    KAK_OPEN_GROTTO_BUG_GRASS = "Kak Open Grotto Bug Grass",
    KAK_OPEN_GROTTO_PUDDLE_FISH = "Kak Open Grotto Puddle Fish"
}

local LocalEvents = {
    WAKE_UP_ADULT_TALON = "Wake Up Talon As Adult"
}

local function set_region_rules(world)
    --Kakariko Village
    --Events
    LogicHelpers.add_events(
        Regions.KAKARIKO_VILLAGE,
        world,
        {
            {
                EventLocations.KAK_BUG_ROCK,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.KAK_GATE_GUARD,
                Events.SOLD_KEATON_MASK,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Events.CAN_BORROW_MASKS, bundle) and
                        LogicHelpers.has_item(Items.CHILD_WALLET, bundle)
                end
            }
        }
    )

    --Open Kak Gate from the start if open gate is on, otherwise create an event in Kak for it
    LogicHelpers.add_events(
        Regions.ROOT,
        world,
        {
            {
                EventLocations.KAK_GATE,
                Events.KAKARIKO_GATE_OPEN,
                function(bundle)
                    if world:get_option("kakariko_gate") == Options.KAK_GATE_OPEN then
                        return true
                    else
                        return (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.ZELDAS_LETTER, bundle))
                    end
                end
            }
        }
    )

    --Locations
    LogicHelpers.add_locations(
        Regions.KAKARIKO_VILLAGE,
        world,
        {
            {
                Locations.SHEIK_IN_KAKARIKO,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.FOREST_MEDALLION, bundle) and
                        LogicHelpers.has_item(Items.FIRE_MEDALLION, bundle) and
                        LogicHelpers.has_item(Items.WATER_MEDALLION, bundle)
                end
            },
            {
                Locations.KAK_ANJU_AS_CHILD,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.at_day(bundle)
                end
            },
            {
                Locations.KAK_ANJU_AS_ADULT,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.at_day(bundle)
                end
            },
            {
                Locations.KAK_TRADE_POCKET_CUCCO,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.at_day(bundle) and
                        (LogicHelpers.can_use(Items.POCKET_EGG, bundle) and
                            LogicHelpers.has_item(LocalEvents.WAKE_UP_ADULT_TALON, bundle))
                end
            },
            {
                Locations.KAK_GS_HOUSE_UNDER_CONSTRUCTION,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.KAK_GS_SKULLTULA_HOUSE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.KAK_GS_GUARDS_HOUSE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.KAK_GS_TREE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_get_nighttime_gs(bundle) and
                        LogicHelpers.can_bonk_trees(bundle)
                end
            },
            {
                Locations.KAK_GS_WATCHTOWER,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.LONGSHOT) or
                            (LogicHelpers.can_do_trick(Tricks.KAK_TOWER_GS, bundle) and
                                LogicHelpers.can_jump_slash_except_hammer(bundle))) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {
                Locations.KAK_NEAR_POTION_SHOP_POT1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_POTION_SHOP_POT2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_POTION_SHOP_POT3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_IMPAS_HOUSE_POT1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_IMPAS_HOUSE_POT2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_IMPAS_HOUSE_POT3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_GUARDS_HOUSE_POT1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_GUARDS_HOUSE_POT2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_GUARDS_HOUSE_POT3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_TREE_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_TREE_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_TREE_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_TREE_GRASS4,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_TREE_GRASS5,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_NEAR_GRAVEYARD_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_NEAR_GRAVEYARD_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_NEAR_GRAVEYARD_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_NEAR_OPEN_GROTTO_ADULT_CRATE1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_OPEN_GROTTO_ADULT_CRATE2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_OPEN_GROTTO_ADULT_CRATE3,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_OPEN_GROTTO_ADULT_CRATE4,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_POTION_SHOP_ADULT_CRATE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_SHOOTING_GALLERY_ADULT_CRATE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_BOARDING_HOUSE_ADULT_CRATE1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_BOARDING_HOUSE_ADULT_CRATE2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_IMPAS_HOUSE_ADULT_CRATE1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_IMPAS_HOUSE_ADULT_CRATE2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_BAZAAR_ADULT_CRATE1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_BAZAAR_ADULT_CRATE2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_BEHIND_GS_HOUSE_ADULT_CRATE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_GRAVEYARD_CHILD_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_WINDMILL_CHILD_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_FENCE_CHILD_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_BOARDING_HOUSE_CHILD_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_NEAR_BAZAAR_CHILD_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.KAK_TREE,
                function(bundle)
                    return LogicHelpers.can_bonk_trees(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAKARIKO_VILLAGE,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_CARPENTER_BOSS_HOUSE,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.BOSS_HOUSE_KEY, bundle)
                end
            },
            {
                Regions.KAK_HOUSE_OF_SKULLTULA,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.SKULLTULA_HOUSE_KEY, bundle)
                end
            },
            {
                Regions.KAK_IMPAS_HOUSE,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.IMPAS_HOUSE_KEY, bundle)
                end
            },
            {
                Regions.KAK_WINDMILL,
                function(bundle)
                    return LogicHelpers.can_open_overworld_door(Items.WINDMILL_KEY, bundle)
                end
            },
            {
                Regions.KAK_BAZAAR,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.KAK_BAZAAR_KEY, bundle)
                end
            },
            {
                Regions.KAK_SHOOTING_GALLERY,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.KAK_SHOOTING_GALLERY_KEY, bundle)
                end
            },
            {
                Regions.KAK_WELL,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Events.DRAIN_WELL, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.BOTTOM_OF_THE_WELL_NAVI_DIVE, bundle) and
                            LogicHelpers.is_child(bundle) and
                            LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) and
                            LogicHelpers.can_jump_slash(bundle))
                end
            },
            {
                Regions.KAK_POTION_SHOP_FRONT,
                function(bundle)
                    return (LogicHelpers.at_day(bundle) or LogicHelpers.is_child(bundle)) and
                        LogicHelpers.can_open_overworld_door(Items.KAK_POTION_SHOP_KEY, bundle)
                end
            },
            {
                Regions.KAK_REDEAD_GROTTO,
                function(bundle)
                    return LogicHelpers.can_open_bomb_grotto(bundle)
                end
            },
            {
                Regions.KAK_IMPAS_LEDGE,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.at_day(bundle)) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.VISIBLE_COLLISION, bundle))
                end
            },
            {
                Regions.KAK_WATCHTOWER,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.at_day(bundle) or
                        LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.LONGSHOT) or
                        LogicHelpers.can_do_trick(Tricks.KAK_TOWER_GS, bundle) and LogicHelpers.can_jump_slash(bundle)
                end
            },
            {
                Regions.KAK_ROOFTOP,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                        LogicHelpers.can_do_trick(Tricks.KAK_MAN_ON_ROOF, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {
                Regions.KAK_IMPAS_ROOFTOP,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                        LogicHelpers.can_do_trick(Tricks.KAK_ROOFTOP_GS, bundle) and
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            },
            {
                Regions.THE_GRAVEYARD,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_BEHIND_GATE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Events.KAKARIKO_GATE_OPEN, bundle)
                end
            },
            {
                Regions.KAK_BACKYARD,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.at_day(bundle)
                end
            }
        }
    )

    --Kak Impas Ledge
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_IMPAS_LEDGE,
        world,
        {
            {
                Regions.KAK_IMPAS_HOUSE_BACK,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Impas Rooftop
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_IMPAS_ROOFTOP,
        world,
        {
            {
                Locations.KAK_GS_ABOVE_IMPAS_HOUSE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_get_nighttime_gs(bundle) and
                        LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_IMPAS_ROOFTOP,
        world,
        {
            {
                Regions.KAK_IMPAS_LEDGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Watchtower
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_WATCHTOWER,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_ROOFTOP,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.KAK_MAN_ON_ROOF, bundle) and LogicHelpers.is_child(bundle)
                end
            }
        }
    )

    --Kak Rooftop
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_ROOFTOP,
        world,
        {
            {
                Locations.KAK_MAN_ON_ROOF,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_ROOFTOP,
        world,
        {
            {
                Regions.KAK_BACKYARD,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Backyard
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_BACKYARD,
        world,
        {
            {
                Locations.KAK_NEAR_MEDICINE_SHOP_POT1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.KAK_NEAR_MEDICINE_SHOP_POT2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_BACKYARD,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_OPEN_GROTTO,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_GRANNYS_POTION_SHOP,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.GRANNYS_POTION_SHOP_KEY, bundle)
                end
            },
            {
                Regions.KAK_POTION_SHOP_BACK,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.at_day(bundle) and
                        LogicHelpers.can_open_overworld_door(Items.KAK_POTION_SHOP_KEY, bundle)
                end
            }
        }
    )

    --Kak Carpenter Boss House
    --Events
    LogicHelpers.add_events(
        Regions.KAK_CARPENTER_BOSS_HOUSE,
        world,
        {
            {
                EventLocations.KAK_ADULT_TALON,
                LocalEvents.WAKE_UP_ADULT_TALON,
                function(bundle)
                    return world:get_option("shuffle_adult_trade_items") and LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_use(Items.POCKET_EGG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_CARPENTER_BOSS_HOUSE,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak House of Skulltula
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_HOUSE_OF_SKULLTULA,
        world,
        {
            {
                Locations.KAK_10_GOLD_SKULLTULA_REWARD,
                function(bundle)
                    return LogicHelpers.has_item(Items.GOLD_SKULLTULA_TOKEN, bundle, 10)
                end
            },
            {
                Locations.KAK_20_GOLD_SKULLTULA_REWARD,
                function(bundle)
                    return LogicHelpers.has_item(Items.GOLD_SKULLTULA_TOKEN, bundle, 20)
                end
            },
            {
                Locations.KAK_30_GOLD_SKULLTULA_REWARD,
                function(bundle)
                    return LogicHelpers.has_item(Items.GOLD_SKULLTULA_TOKEN, bundle, 30)
                end
            },
            {
                Locations.KAK_40_GOLD_SKULLTULA_REWARD,
                function(bundle)
                    return LogicHelpers.has_item(Items.GOLD_SKULLTULA_TOKEN, bundle, 40)
                end
            },
            {
                Locations.KAK_50_GOLD_SKULLTULA_REWARD,
                function(bundle)
                    return LogicHelpers.has_item(Items.GOLD_SKULLTULA_TOKEN, bundle, 50)
                end
            },
            {
                Locations.KAK_100_GOLD_SKULLTULA_REWARD,
                function(bundle)
                    return LogicHelpers.has_item(Items.GOLD_SKULLTULA_TOKEN, bundle, 100)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_HOUSE_OF_SKULLTULA,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Impas House
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_IMPAS_HOUSE,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_COW_CAGE,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle)
                end
            }
        }
    )

    --Kak Impas House Back
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_IMPAS_HOUSE_BACK,
        world,
        {
            {
                Locations.KAK_IMPAS_HOUSE_FREESTANDING_POH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_IMPAS_HOUSE_BACK,
        world,
        {
            {
                Regions.KAK_IMPAS_LEDGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_COW_CAGE,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.EPONAS_SONG, bundle)
                end
            }
        }
    )

    --Kak Impas House Cow
    --This region exists because to get around AP's restriction on locations having one parent region
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_COW_CAGE,
        world,
        {
            {
                Locations.KAK_IMPAS_HOUSE_COW,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Windmill
    --Events
    LogicHelpers.add_events(
        Regions.KAK_WINDMILL,
        world,
        {
            {
                EventLocations.KAK_WINDMILL_PHONOGRAM_MAN,
                Events.DRAIN_WELL,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_play_song(Items.SONG_OF_STORMS, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_WINDMILL,
        world,
        {
            {
                Locations.KAK_WINDMILL_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.can_use(Items.BOOMERANG, bundle) or
                        LogicHelpers.has_item(Events.DAMPES_WINDMILL_ACCESS, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.KAK_ADULT_WINDMILL_POH, bundle)) or
                        (LogicHelpers.is_child(bundle) and LogicHelpers.can_jump_slash_except_hammer(bundle) and
                            LogicHelpers.can_do_trick(Tricks.KAK_CHILD_WINDMILL_POH, bundle))
                end
            },
            {
                Locations.SONG_FROM_WINDMILL,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.FAIRY_OCARINA, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_WINDMILL,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Bazaar
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_BAZAAR,
        world,
        {
            {
                Locations.KAK_BAZAAR_ITEM1,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM1, bundle)
                end
            },
            {
                Locations.KAK_BAZAAR_ITEM2,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM2, bundle)
                end
            },
            {
                Locations.KAK_BAZAAR_ITEM3,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM3, bundle)
                end
            },
            {
                Locations.KAK_BAZAAR_ITEM4,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM4, bundle)
                end
            },
            {
                Locations.KAK_BAZAAR_ITEM5,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM5, bundle)
                end
            },
            {
                Locations.KAK_BAZAAR_ITEM6,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM6, bundle)
                end
            },
            {
                Locations.KAK_BAZAAR_ITEM7,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM7, bundle)
                end
            },
            {
                Locations.KAK_BAZAAR_ITEM8,
                function(bundle)
                    return LogicHelpers.can_afford_item("shop_prices", Locations.KAK_BAZAAR_ITEM8, bundle)
                end
            }
        }
    )
    LogicHelpers.connect_regions(
        Regions.KAK_BAZAAR,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Shooting Gallery
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_SHOOTING_GALLERY,
        world,
        {
            {
                Locations.KAK_SHOOTING_GALLERY_REWARD,
                function(bundle)
                    return LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_SHOOTING_GALLERY,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Potion Shop Front
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_POTION_SHOP_FRONT,
        world,
        {
            {
                Locations.KAK_POTION_SHOP_ITEM1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM1, bundle)
                end
            },
            {
                Locations.KAK_POTION_SHOP_ITEM2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM2, bundle)
                end
            },
            {
                Locations.KAK_POTION_SHOP_ITEM3,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM3, bundle)
                end
            },
            {
                Locations.KAK_POTION_SHOP_ITEM4,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM4, bundle)
                end
            },
            {
                Locations.KAK_POTION_SHOP_ITEM5,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM5, bundle)
                end
            },
            {
                Locations.KAK_POTION_SHOP_ITEM6,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM6, bundle)
                end
            },
            {
                Locations.KAK_POTION_SHOP_ITEM7,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM7, bundle)
                end
            },
            {
                Locations.KAK_POTION_SHOP_ITEM8,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_afford_item("shop_prices", Locations.KAK_POTION_SHOP_ITEM8, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_POTION_SHOP_FRONT,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_POTION_SHOP_BACK,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )

    --Kak Potion Shop Back
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_POTION_SHOP_BACK,
        world,
        {
            {
                Regions.KAK_POTION_SHOP_FRONT,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAK_BACKYARD,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )

    --Kak Granny's Potion Shop
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_GRANNYS_POTION_SHOP,
        world,
        {
            {
                Locations.KAK_TRADE_ODD_MUSHROOM,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.ODD_MUSHROOM, bundle)
                end
            },
            {
                Locations.KAK_GRANNYS_SHOP,
                function(bundle)
                    local shuffled = LogicHelpers.merchant_shuffled(Locations.KAK_GRANNYS_SHOP, bundle)
                    local can_afford = LogicHelpers.can_use(Items.ADULT_WALLET, bundle)
                    if shuffled then
                        can_afford = LogicHelpers.can_afford_item("merchant_prices", Locations.KAK_GRANNYS_SHOP, bundle)
                    end
                    return LogicHelpers.is_adult(bundle) and can_afford and
                        (LogicHelpers.can_use(Items.ODD_MUSHROOM, bundle)) and
                        LogicHelpers.trade_quest_step(Items.ODD_MUSHROOM, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_GRANNYS_POTION_SHOP,
        world,
        {
            {
                Regions.KAK_BACKYARD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Redead Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_REDEAD_GROTTO,
        world,
        {
            {
                Locations.KAK_REDEAD_GROTTO_CHEST,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.REDEAD, EnemyDistance.CLOSE, true, 2)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_REDEAD_GROTTO,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Open Grotto
    --Events
    LogicHelpers.add_events(
        Regions.KAK_OPEN_GROTTO,
        world,
        {
            {
                EventLocations.KAK_OPEN_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.KAK_OPEN_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.KAK_OPEN_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.KAK_OPEN_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.KAK_OPEN_GROTTO,
        world,
        {
            {
                Locations.KAK_OPEN_GROTTO_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_FISH,
                function(bundle)
                    return LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_play_song(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.KAK_OPEN_GROTTO_GRASS4,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_OPEN_GROTTO,
        world,
        {
            {
                Regions.KAK_BACKYARD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Behind Gate
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_BEHIND_GATE,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Events.KAKARIKO_GATE_OPEN, bundle) or
                        LogicHelpers.can_do_trick(Tricks.VISIBLE_COLLISION, bundle)
                end
            },
            {
                Regions.DEATH_MOUNTAIN_TRAIL,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Kak Well
    --Connections
    LogicHelpers.connect_regions(
        Regions.KAK_WELL,
        world,
        {
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) or
                        LogicHelpers.has_item(Events.DRAIN_WELL, bundle)
                end
            },
            --TODO: Add check for dungeon entrance randomization
            {
                Regions.BOTTOM_OF_THE_WELL_ENTRYWAY,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Events.DRAIN_WELL, bundle)
                end
            }
        }
    )
end

return set_region_rules
