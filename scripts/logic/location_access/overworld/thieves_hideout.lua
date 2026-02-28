EventLocations = {
    TH_1_TORCH_CARPENTER_CELL = "TH 1 Torch Carpenter Cell",
    TH_DOUBLE_CELL_CARPENTER_CELL = "TH Double Cell Carpenter Cell",
    TH_DEAD_END_CARPENTER_CELL = "TH Dead End Carpenter Cell",
    TH_STEEP_SLOPE_CARPENTER_CELL = "TH Steep Slope Carpenter Cell",
    TH_RESCUED_ALL_CARPENTERS = "TH Rescued All Carpenters"
}

local LocalEvents = {
    TH_1_TORCH_CELL_CARPENTER_FREED = "TH 1 Torch Cell Carpenter Freed",
    TH_DOUBLE_CELL_CARPENTER_FREED = "TH Double Cell Carpenter Freed",
    TH_DEAD_END_CELL_CARPENTER_FREED = "TH Dead End Cell Carpenter Freed",
    TH_STEEP_SLOPE_CELL_CARPENTER_FREED = "TH Steep Slope Cell Carpenter Freed"
}

local function set_region_rules(world)
    --Thieves' Hideout 1 Torch Cell
    --Events
    LogicHelpers.add_events(
        Regions.THIEVES_HIDEOUT_1_TORCH_CELL,
        world,
        {
            {
                EventLocations.TH_1_TORCH_CARPENTER_CELL,
                LocalEvents.TH_1_TORCH_CELL_CARPENTER_FREED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_1_TORCH_CELL,
        world,
        {
            {
                Locations.TH_1_TORCH_CARPENTER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            },
            {
                Locations.TH_1_TORCH_CELL_RIGHT_POT,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.TH_1_TORCH_CELL_MIDDLE_POT,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {Locations.TH_1_TORCH_CELL_LEFT_POT, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.TH_1_TORCH_CELL_CRATE, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_1_TORCH_CELL,
        world,
        {
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end},
            {Regions.GF_NEAR_GROTTO, function(bundle)
                    return true
                end},
            {
                Regions.THIEVES_HIDEOUT_RESCUE_CARPENTERS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Thieves Hideout Double Cell
    --Events
    LogicHelpers.add_events(
        Regions.THIEVES_HIDEOUT_DOUBLE_CELL,
        world,
        {
            {
                EventLocations.TH_DOUBLE_CELL_CARPENTER_CELL,
                LocalEvents.TH_DOUBLE_CELL_CARPENTER_FREED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_DOUBLE_CELL,
        world,
        {
            {
                Locations.TH_DOUBLE_CELL_CARPENTER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            },
            {Locations.TH_DOUBLE_CELL_RIGHT_POT, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {
                Locations.TH_DOUBLE_CELL_MIDDLE_POT,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {Locations.TH_DOUBLE_CELL_LEFT_POT, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.TH_RIGHTMOST_JAILED_POT, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {
                Locations.TH_RIGHT_MIDDLE_JAILED_POT,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.TH_LEFT_MIDDLE_JAILED_POT,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {Locations.TH_LEFTMOST_JAILED_POT, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {
                Locations.TH_DOUBLE_CELL_LEFT_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.TH_DOUBLE_CELL_RIGHT_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_DOUBLE_CELL,
        world,
        {
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end},
            {Regions.GF_NEAR_GROTTO, function(bundle)
                    return true
                end},
            {
                Regions.THIEVES_HIDEOUT_RESCUE_CARPENTERS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Thieves Hideout Dead End Cell
    --Events
    LogicHelpers.add_events(
        Regions.THIEVES_HIDEOUT_DEAD_END_CELL,
        world,
        {
            {
                EventLocations.TH_DEAD_END_CARPENTER_CELL,
                LocalEvents.TH_DEAD_END_CELL_CARPENTER_FREED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_DEAD_END_CELL,
        world,
        {
            {
                Locations.TH_DEAD_END_CARPENTER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            },
            {Locations.TH_DEAD_END_CELL_CRATE, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_DEAD_END_CELL,
        world,
        {
            {Regions.GF_BELOW_GS, function(bundle)
                    return true
                end},
            {
                Regions.THIEVES_HIDEOUT_RESCUE_CARPENTERS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Thieves Hideout Steep Slope Cell
    --Events
    LogicHelpers.add_events(
        Regions.THIEVES_HIDEOUT_STEEP_SLOPE_CELL,
        world,
        {
            {
                EventLocations.TH_STEEP_SLOPE_CARPENTER_CELL,
                LocalEvents.TH_STEEP_SLOPE_CELL_CARPENTER_FREED,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_STEEP_SLOPE_CELL,
        world,
        {
            {
                Locations.TH_STEEP_SLOPE_CARPENTER,
                function(bundle)
                    return LogicHelpers.can_kill_enemy(bundle, Enemies.GERUDO_WARRIOR)
                end
            },
            {Locations.TH_STEEP_SLOPE_RIGHT_POT, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end},
            {Locations.TH_STEEP_SLOPE_LEFT_POT, function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_STEEP_SLOPE_CELL,
        world,
        {
            {Regions.GF_ABOVE_GTG, function(bundle)
                    return true
                end},
            {Regions.GF_TOP_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.THIEVES_HIDEOUT_RESCUE_CARPENTERS,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Thieves Hideout Rescue Carpenters
    --This is a deviation from ship logic due to the union of locations
    --Events
    LogicHelpers.add_events(
        Regions.THIEVES_HIDEOUT_RESCUE_CARPENTERS,
        world,
        {
            {
                EventLocations.TH_RESCUED_ALL_CARPENTERS,
                Events.RESCUED_ALL_CARPENTERS,
                function(bundle)
                    return (((LogicHelpers.small_keys(Items.GERUDO_FORTRESS_SMALL_KEY, 4, bundle) and
                        world:get_option("fortress_carpenters") == Options.CARPENTERS_NORMAL) or
                        (LogicHelpers.small_keys(Items.GERUDO_FORTRESS_SMALL_KEY, 1, bundle) and
                            world:get_option("fortress_carpenters") == Options.CARPENTERS_FAST)) and
                        LogicHelpers.has_item(LocalEvents.TH_DOUBLE_CELL_CARPENTER_FREED, bundle) and
                        LogicHelpers.has_item(LocalEvents.TH_STEEP_SLOPE_CELL_CARPENTER_FREED, bundle) and
                        LogicHelpers.has_item(LocalEvents.TH_DEAD_END_CELL_CARPENTER_FREED, bundle) and
                        LogicHelpers.has_item(LocalEvents.TH_1_TORCH_CELL_CARPENTER_FREED, bundle)) or
                        world:get_option("fortress_carpenters") == Options.CARPENTERS_FREE
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_RESCUE_CARPENTERS,
        world,
        {
            {
                Locations.GF_GERUDO_MEMBERSHIP_CARD,
                function(bundle)
                    return LogicHelpers.has_item(Events.RESCUED_ALL_CARPENTERS, bundle)
                end
            }
        }
    )

    --Thieves Hideout Kitchen Corridor
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_KITCHEN_CORRIDOR,
        world,
        {
            {
                Locations.TH_NEAR_KITCHEN_LEFTMOST_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.TH_NEAR_KITCHEN_MIDDLE_LEFT_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.TH_NEAR_KITCHEN_MIDDLE_RIGHT_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.TH_NEAR_KITCHEN_RIGHTMOST_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_KITCHEN_CORRIDOR,
        world,
        {
            {Regions.GF_NEAR_GROTTO, function(bundle)
                    return true
                end},
            {Regions.GF_ABOVE_GTG, function(bundle)
                    return true
                end},
            {
                Regions.THIEVES_HIDEOUT_KITCHEN_BOTTOM,
                function(bundle)
                    return LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            }
        }
    )

    --Thieves Hideout Kitchen Bottom
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_KITCHEN_BOTTOM,
        world,
        {
            {
                Locations.TH_KITCHEN_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle) and
                        LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Locations.TH_KITCHEN_SUN_FAIRY,
                function(bundle)
                    return LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD) and
                        LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_KITCHEN_BOTTOM,
        world,
        {
            {
                Regions.THIEVES_HIDEOUT_KITCHEN_CORRIDOR,
                function(bundle)
                    return LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.THIEVES_HIDEOUT_KITCHEN_TOP,
                function(bundle)
                    return LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.THIEVES_HIDEOUT_KITCHEN_POTS,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle) and LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            }
        }
    )

    --Thieves Hideout Kitchen Top
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_KITCHEN_TOP,
        world,
        {
            {Regions.THIEVES_HIDEOUT_KITCHEN_BOTTOM, function(bundle)
                    return true
                end},
            {
                Regions.THIEVES_HIDEOUT_KITCHEN_POTS,
                function(bundle)
                    return LogicHelpers.can_use(Items.BOOMERANG, bundle)
                end
            },
            {
                Regions.GF_NEAR_GS,
                function(bundle)
                    return LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            },
            {
                Regions.GF_TOP_OF_LOWER_VINES,
                function(bundle)
                    return LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            }
        }
    )

    --Thieves Hideout Kitchen Pots
    --This is a deviation from ship logic due to the union of locations
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_KITCHEN_POTS,
        world,
        {
            {Locations.TH_KITCHEN_POT1, function(bundle)
                    return true
                end},
            {Locations.TH_KITCHEN_POT2, function(bundle)
                    return true
                end}
        }
    )

    --Thieves Hideout Break Room
    --Locations
    LogicHelpers.add_locations(
        Regions.THIEVES_HIDEOUT_BREAK_ROOM,
        world,
        {
            {
                Locations.TH_BREAK_ROOM_FRONT_POT,
                function(bundle)
                    return (LogicHelpers.can_pass_enemy(bundle, Enemies.BREAK_ROOM_GUARD) and
                        LogicHelpers.can_break_pots(bundle)) or
                        (LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD) and
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.TH_BREAK_ROOM_BACK_POT,
                function(bundle)
                    return (LogicHelpers.can_pass_enemy(bundle, Enemies.BREAK_ROOM_GUARD) and
                        LogicHelpers.can_break_pots(bundle)) or
                        (LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD) and
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.TH_BREAK_HALLWAY_OUTER_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.TH_BREAK_HALLWAY_INNER_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.TH_BREAK_ROOM_RIGHT_CRATE,
                function(bundle)
                    return (LogicHelpers.can_pass_enemy(bundle, Enemies.BREAK_ROOM_GUARD) and
                        LogicHelpers.can_break_crates(bundle)) or
                        (LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD) and LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            },
            {
                Locations.TH_BREAK_ROOM_LEFT_CRATE,
                function(bundle)
                    return (LogicHelpers.can_pass_enemy(bundle, Enemies.BREAK_ROOM_GUARD) and
                        LogicHelpers.can_break_crates(bundle)) or
                        (LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD) and LogicHelpers.has_explosives(bundle) and
                            LogicHelpers.can_use(Items.BOOMERANG, bundle))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_BREAK_ROOM,
        world,
        {
            {
                Regions.GF_BELOW_CHEST,
                function(bundle)
                    return LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.THIEVES_HIDEOUT_BREAK_ROOM_CORRIDOR,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            }
        }
    )

    --Thieves Hideout Break Room Corridor
    --Connections
    LogicHelpers.connect_regions(
        Regions.THIEVES_HIDEOUT_BREAK_ROOM_CORRIDOR,
        world,
        {
            {
                Regions.THIEVES_HIDEOUT_BREAK_ROOM,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {Regions.GF_ABOVE_JAIL, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
