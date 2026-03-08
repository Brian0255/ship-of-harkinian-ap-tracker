local EventLocations = {
    HF_BIG_POE = "HF Big Poe",
    HF_RUNNING_MAN = "HF Running Man",
    HF_COW_GROTTO_BEHIND_WEBS_GOSSIP_STONE_SONG_FAIRY = "HF Cow Grotto Behind Webs Gossip Stone Song Fairy",
    HF_COW_GROTTO_BEHIND_WEBS_BUGS_SHRUB = "HF Cow Grotto Behind Webs Bugs Shrub",
    HF_FAIRY_GROTTO_FAIRY = "HF Fairy Grotto Fairy",
    HF_SOUTHEAST_GROTTO_GOSSIP_STONE_SONG_FAIRY = "HF Southeast Grotto Gossip Stone Song Fairy",
    HF_SOUTHEAST_GROTTO_BUTTERFLY_FAIRY = "HF Southeast Grotto Butterfly Fairy",
    HF_SOUTHEAST_GROTTO_BUG_GRASS = "HF Southeast Grotto Bugs",
    HF_SOUTHEAST_GROTTO_PUDDLE_FISH = "HF Southeast Grotto Puddle Fish",
    HF_OPEN_GROTTO_GOSSIP_STONE_SONG_FAIRY = "HF Open Grotto Gossip Stone Song Fairy",
    HF_OPEN_GROTTO_BUTTERFLY_FAIRY = "HF Open Grotto Butterfly Fairy",
    HF_OPEN_GROTTO_BUG_GRASS = "HF Open Grotto Bugs",
    HF_OPEN_GROTTO_PUDDLE_FISH = "HF Open Grotto Puddle Fish",
    HF_NEAR_MARKET_GROTTO_GOSSIP_STONE_SONG_FAIRY = "HF Near Market Grotto Gossip Stone Song Fairy",
    HF_NEAR_MARKET_GROTTO_BUTTERFLY_FAIRY = "HF Near Market Grotto Butterfly Fairy",
    HF_NEAR_MARKET_GROTTO_BUG_GRASS = "HF Near Market Grotto Bugs",
    HF_NEAR_MARKET_GROTTO_PUDDLE_FISH = "HF Near Market Grotto Puddle Fish",
    HF_DAY_NIGHT_CYCLE_CHILD = "HF Day Night Cycle Child",
    HF_DAY_NIGHT_CYCLE_ADULT = "HF Day Night Cycle Adult"
}

local function set_region_rules(world)
    --Hyrule Field
    --Events
    LogicHelpers.add_events(
        Regions.HYRULE_FIELD,
        world,
        {
            {
                EventLocations.HF_BIG_POE,
                Events.CAN_DEFEAT_BIG_POE,
                function(bundle)
                    return (LogicHelpers.has_bottle(bundle) and LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                        (LogicHelpers.can_use(Items.EPONA, bundle) or
                            LogicHelpers.can_do_trick(Tricks.HF_BIG_POE_WITHOUT_EPONA, bundle)))
                end
            },
            {
                EventLocations.HF_RUNNING_MAN,
                Events.SOLD_BUNNY_HOOD,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Events.CAN_BORROW_BUNNY_HOOD, bundle) and
                        LogicHelpers.has_item(Items.KOKIRIS_EMERALD, bundle) and
                        LogicHelpers.has_item(Items.GORONS_RUBY, bundle) and
                        LogicHelpers.has_item(Items.ZORAS_SAPPHIRE, bundle) and
                        LogicHelpers.has_item(Items.CHILD_WALLET, bundle))
                end
            },
            {
                EventLocations.HF_DAY_NIGHT_CYCLE_CHILD,
                Events.CHILD_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                EventLocations.HF_DAY_NIGHT_CYCLE_ADULT,
                Events.ADULT_CAN_PASS_TIME,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.HYRULE_FIELD,
        world,
        {
            {
                Locations.HF_OCARINA_OF_TIME_ITEM,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.stone_count(bundle) == 3 and
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            },
            {
                Locations.SONG_FROM_OCARINA_OF_TIME,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.stone_count(bundle) == 3 and
                        LogicHelpers.has_item(Items.BRONZE_SCALE, bundle))
                end
            },
            {
                Locations.HF_POND_SONG_OF_STORMS_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS3,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS4,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS5,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS6,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS7,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS8,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS9,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS10,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS11,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_CENTRAL_GRASS12,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS3,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS4,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS5,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS6,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS7,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS8,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS9,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS10,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS11,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTH_GRASS12,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS3,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS4,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS5,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS6,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS7,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS8,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS9,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS10,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS11,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GRASS12,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS3,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS4,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS5,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS6,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS7,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS8,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS9,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS10,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS11,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_KFGRASS12,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_LLR_TREE,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NEAR_LH_TREE,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_CHILD_NEAR_GV_TREE,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_ADULT_NEAR_GV_TREE,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NEAR_ZR_TREE,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NEAR_KAK_TREE,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NEAR_KAK_SMALL_TREE,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_TREE_1,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_TREE_2,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_TREE_3,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NORTHWEST_TREE_1,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NORTHWEST_TREE_2,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NORTHWEST_TREE_3,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NORTHWEST_TREE_4,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NORTHWEST_TREE_5,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_NORTHWEST_TREE_6,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_EAST_TREE_1,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_EAST_TREE_2,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_EAST_TREE_3,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_EAST_TREE_4,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_EAST_TREE_5,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_EAST_TREE_6,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_1,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_2,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_3,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_4,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_5,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_6,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_7,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_8,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_9,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_10,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_11,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_12,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_13,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_14,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_15,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_16,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_17,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_18,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_TREE_19,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_CHILD_SOUTHEAST_TREE_1,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_CHILD_SOUTHEAST_TREE_2,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_CHILD_SOUTHEAST_TREE_3,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_CHILD_SOUTHEAST_TREE_4,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_CHILD_SOUTHEAST_TREE_5,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_CHILD_SOUTHEAST_TREE_6,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.can_bonk_trees(bundle))
                end
            },
            {
                Locations.HF_TEKTITE_GROTTO_TREE,
                function(bundle)
                    return (LogicHelpers.can_bonk_trees(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HYRULE_FIELD,
        world,
        {
            {
                Regions.LW_BRIDGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.LAKE_HYLIA,
                function(bundle)
                    return true
                end
            },
            {
                Regions.GERUDO_VALLEY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.MARKET_ENTRANCE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.KAKARIKO_VILLAGE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.ZR_FRONT,
                function(bundle)
                    return true
                end
            },
            {
                Regions.LON_LON_RANCH,
                function(bundle)
                    return true
                end
            },
            {
                Regions.HF_SOUTHEAST_GROTTO,
                function(bundle)
                    return (LogicHelpers.blast_or_smash(bundle))
                end
            },
            {
                Regions.HF_OPEN_GROTTO,
                function(bundle)
                    return true
                end
            },
            {
                Regions.HF_INSIDE_FENCE_GROTTO,
                function(bundle)
                    return (LogicHelpers.can_open_bomb_grotto(bundle))
                end
            },
            {
                Regions.HF_COW_GROTTO,
                function(bundle)
                    return ((LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle) or LogicHelpers.is_child(bundle)) and
                        LogicHelpers.can_open_bomb_grotto(bundle))
                end
            },
            {
                Regions.HF_NEAR_MARKET_GROTTO,
                function(bundle)
                    return (LogicHelpers.blast_or_smash(bundle))
                end
            },
            {
                Regions.HF_FAIRY_GROTTO,
                function(bundle)
                    return (LogicHelpers.blast_or_smash(bundle))
                end
            },
            {
                Regions.HF_NEAR_KAK_GROTTO,
                function(bundle)
                    return (LogicHelpers.can_open_bomb_grotto(bundle))
                end
            },
            {
                Regions.HF_TEKTITE_GROTTO,
                function(bundle)
                    return (LogicHelpers.can_open_bomb_grotto(bundle))
                end
            }
        }
    )

    --HF Southeast Grotto
    --Events
    LogicHelpers.add_events(
        Regions.HF_SOUTHEAST_GROTTO,
        world,
        {
            {
                EventLocations.HF_SOUTHEAST_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.HF_SOUTHEAST_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.HF_SOUTHEAST_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.HF_SOUTHEAST_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_SOUTHEAST_GROTTO,
        world,
        {
            {
                Locations.HF_SOUTHEAST_GROTTO_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_FISH,
                function(bundle)
                    return (LogicHelpers.has_bottle(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return (LogicHelpers.can_break_lower_hives(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return (LogicHelpers.can_break_lower_hives(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_GRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_GRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_GRASS3,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_SOUTHEAST_GROTTO_GRASS4,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_SOUTHEAST_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --HF Open Grotto
    --Events
    LogicHelpers.add_events(
        Regions.HF_OPEN_GROTTO,
        world,
        {
            {
                EventLocations.HF_OPEN_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.HF_OPEN_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.HF_OPEN_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.HF_OPEN_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_OPEN_GROTTO,
        world,
        {
            {
                Locations.HF_OPEN_GROTTO_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_OPEN_GROTTO_FISH,
                function(bundle)
                    return (LogicHelpers.has_bottle(bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return (LogicHelpers.can_break_lower_hives(bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return (LogicHelpers.can_break_lower_hives(bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_GRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_GRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_GRASS3,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_OPEN_GROTTO_GRASS4,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_OPEN_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --HF Inside Fence Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_INSIDE_FENCE_GROTTO,
        world,
        {
            {
                Locations.HF_DEKU_SCRUB_GROTTO,
                function(bundle)
                    return (LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.HF_DEKU_SCRUB_GROTTO,bundle))
                end
            },
            {
                Locations.HF_DEKU_SCRUB_GROTTO_BEEHIVE,
                function(bundle)
                    return (LogicHelpers.can_break_lower_hives(bundle))
                end
            },
            {
                Locations.HF_FENCE_GROTTO_STORMS_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_INSIDE_FENCE_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --HF Cow Grotto
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_COW_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            },
            {
                Regions.HF_COW_GROTTO_BEHIND_WEBS,
                function(bundle)
                    return (LogicHelpers.has_fire_source(bundle))
                end
            }
        }
    )

    --HF Cow Grotto Behind Webs
    --Events
    LogicHelpers.add_events(
        Regions.HF_COW_GROTTO_BEHIND_WEBS,
        world,
        {
            {
                EventLocations.HF_COW_GROTTO_BEHIND_WEBS_BUGS_SHRUB,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.HF_COW_GROTTO_BEHIND_WEBS_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_COW_GROTTO_BEHIND_WEBS,
        world,
        {
            {
                Locations.HF_GS_COW_GROTTO,
                function(bundle)
                    return (LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG))
                end
            },
            {
                Locations.HF_COW_GROTTO_COW,
                function(bundle)
                    return (LogicHelpers.can_use(Items.EPONAS_SONG, bundle))
                end
            },
            {
                Locations.HF_COW_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                Locations.HF_COW_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.HF_COW_GROTTO_POT1,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.HF_COW_GROTTO_POT2,
                function(bundle)
                    return (LogicHelpers.can_break_pots(bundle))
                end
            },
            {
                Locations.HF_COW_GROTTO_GRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_COW_GROTTO_GRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_COW_GROTTO_BEHIND_WEBS,
        world,
        {
            {
                Regions.HF_COW_GROTTO,
                function(bundle)
                    return true
                end
            }
        }
    )

    --HF Near Market Grotto
    --Events
    LogicHelpers.add_events(
        Regions.HF_NEAR_MARKET_GROTTO,
        world,
        {
            {
                EventLocations.HF_NEAR_MARKET_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.HF_NEAR_MARKET_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.HF_NEAR_MARKET_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.HF_NEAR_MARKET_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_NEAR_MARKET_GROTTO,
        world,
        {
            {
                Locations.HF_NEAR_MARKET_GROTTO_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_NEAR_MARKET_GROTTO_FISH,
                function(bundle)
                    return (LogicHelpers.has_bottle(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return (LogicHelpers.can_break_lower_hives(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return (LogicHelpers.can_break_lower_hives(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GROTTO_GRASS1,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GROTTO_GRASS2,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GROTTO_GRASS3,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                Locations.HF_NEAR_MARKET_GROTTO_GRASS4,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_NEAR_MARKET_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --HF Fairy Grotto
    --Events
    LogicHelpers.add_events(
        Regions.HF_FAIRY_GROTTO,
        world,
        {
            {
                EventLocations.HF_FAIRY_GROTTO_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_FAIRY_GROTTO,
        world,
        {
            {
                Locations.HF_FAIRY_GROTTO_FAIRY1,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_FAIRY_GROTTO_FAIRY2,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_FAIRY_GROTTO_FAIRY3,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_FAIRY_GROTTO_FAIRY4,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_FAIRY_GROTTO_FAIRY5,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_FAIRY_GROTTO_FAIRY6,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_FAIRY_GROTTO_FAIRY7,
                function(bundle)
                    return true
                end
            },
            {
                Locations.HF_FAIRY_GROTTO_FAIRY8,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_FAIRY_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --HF Near Kak Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_NEAR_KAK_GROTTO,
        world,
        {
            {
                Locations.HF_GS_STONE_BRIDGE_TREE_GROTTO,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_NEAR_KAK_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )

    --HF Tektite Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.HF_TEKTITE_GROTTO,
        world,
        {
            {
                Locations.HF_TEKTITE_GROTTO_FREESTANDING_POH,
                function(bundle)
                    return (LogicHelpers.has_item(Items.GOLDEN_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HF_TEKTITE_GROTTO,
        world,
        {
            {
                Regions.HYRULE_FIELD,
                function(bundle)
                    return true
                end
            }
        }
    )
end

return set_region_rules
