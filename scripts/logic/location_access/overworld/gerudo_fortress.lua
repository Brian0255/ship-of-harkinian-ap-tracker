local EventLocations = {
    GF_GATE = "GF Gate",
    GF_GATE_OUTSIDE = "GF Gate Outside",
    GTG_GATE = "GTG Gate",
    GF_STORMS_GROTTO_FAIRY = "GF Storms Grotto Fairy"
}

local LocalEvents = {
    GF_GATE_OPEN = "GF Gate Open",
    GTG_GATE_OPEN = "GTG Gate Open"
}

local function set_region_rules(world)
    --Gerudo Fortress Outskirts
    --Events
    LogicHelpers.add_events(
        Regions.GERUDO_FORTRESS_OUTSKIRTS,
        world,
        {
            {
                EventLocations.GF_GATE,
                LocalEvents.GF_GATE_OPEN,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GERUDO_FORTRESS_OUTSKIRTS,
        world,
        {
            {
                Locations.GF_OUTSKIRTS_NORTHEAST_CRATE,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)) and
                        LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_OUTSKIRTS_NORTHWEST_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GERUDO_FORTRESS_OUTSKIRTS,
        world,
        {
            {Regions.GV_FORTRESS_SIDE, function(bundle)
                    return true
                end},
            {Regions.THIEVES_HIDEOUT_1_TORCH_CELL, function(bundle)
                    return true
                end},
            {
                Regions.GF_OUTSIDE_GATE,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.GF_GATE_OPEN, bundle)
                end
            },
            {
                Regions.GF_NEAR_GROTTO,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.GF_OUTSIDE_GTG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {Regions.GF_JAIL_WINDOW, function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end}
        }
    )

    --GF Near Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.GF_NEAR_GROTTO,
        world,
        {
            {
                Locations.GF_SOUTHMOST_CENTER_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_MIDDLE_SOUTH_CENTER_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_MIDDLE_NORTH_CENTER_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_NORTHMOST_CENTER_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_NEAR_GROTTO,
        world,
        {
            {Regions.THIEVES_HIDEOUT_1_TORCH_CELL, function(bundle)
                    return true
                end},
            {Regions.THIEVES_HIDEOUT_STEEP_SLOPE_CELL, function(bundle)
                    return true
                end},
            {Regions.THIEVES_HIDEOUT_KITCHEN_CORRIDOR, function(bundle)
                    return true
                end},
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end},
            {Regions.GF_JAIL_WINDOW, function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end},
            {
                Regions.GF_OUTSIDE_GTG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.GF_TOP_OF_UPPER_VINES,
                function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Regions.GF_STORMS_GROTTO,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_open_storms_grotto(bundle)
                end
            }
        }
    )

    --GF Outside GTG
    --Events
    LogicHelpers.add_events(
        Regions.GF_OUTSIDE_GTG,
        world,
        {
            {
                EventLocations.GTG_GATE,
                LocalEvents.GTG_GATE_OPEN,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle)) and
                        LogicHelpers.has_item(Items.CHILD_WALLET, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_OUTSIDE_GTG,
        world,
        {
            --TODO: Check for entrance rando
            {
                Regions.GF_TO_GTG,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.GTG_GATE_OPEN, bundle) and LogicHelpers.is_adult(bundle)
                end
            },
            {Regions.GF_JAIL_WINDOW, function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end},
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end},
            {
                Regions.GF_NEAR_GROTTO,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.GF_ABOVE_GTG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.GF_TOP_OF_UPPER_VINES,
                function(bundle)
                    return LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle) and
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Regions.GF_HBA_RANGE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle)
                end
            }
        }
    )

    --GF to GTG
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_TO_GTG,
        world,
        {
            {Regions.GERUDO_TRAINING_GROUND_ENTRYWAY, function(bundle)
                    return true
                end}
        }
    )

    --GF Exiting GTG
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_EXITING_GTG,
        world,
        {
            {
                Regions.GF_OUTSIDE_GTG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle)
                end
            },
            {Regions.GF_JAIL_WINDOW, function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end},
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end}
        }
    )

    --GF Above GTG
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_ABOVE_GTG,
        world,
        {
            {Regions.THIEVES_HIDEOUT_DOUBLE_CELL, function(bundle)
                    return true
                end},
            {Regions.THIEVES_HIDEOUT_KITCHEN_CORRIDOR, function(bundle)
                    return true
                end},
            {Regions.GF_JAIL_WINDOW, function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end},
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end},
            {Regions.GF_NEAR_GROTTO, function(bundle)
                    return true
                end},
            {
                Regions.GF_OUTSIDE_GTG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_pass_enemy(bundle, Enemies.GERUDO_GUARD)
                end
            },
            {
                Regions.GF_BOTTOM_OF_LOWER_VINES,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.GF_JUMP, bundle)
                end
            }
        }
    )

    --GF Bottom of Lower Vines
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_BOTTOM_OF_LOWER_VINES,
        world,
        {
            {Regions.THIEVES_HIDEOUT_STEEP_SLOPE_CELL, function(bundle)
                    return true
                end},
            {Regions.GF_NEAR_GROTTO, function(bundle)
                    return true
                end},
            {Regions.GF_TOP_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {Regions.GF_ABOVE_GTG, function(bundle)
                    return true
                end},
            {
                Regions.GF_BELOW_GS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_ground_jump(bundle)
                end
            }
        }
    )

    --GF Top of Lower Vines
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_TOP_OF_LOWER_VINES,
        world,
        {
            {Regions.THIEVES_HIDEOUT_KITCHEN_TOP, function(bundle)
                    return true
                end},
            {Regions.THIEVES_HIDEOUT_DOUBLE_CELL, function(bundle)
                    return true
                end},
            {Regions.GF_ABOVE_GTG, function(bundle)
                    return true
                end},
            {Regions.GF_BOTTOM_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_BOTTOM_OF_UPPER_VINES,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.GF_JUMP, bundle)
                end
            }
        }
    )

    --GF Near GS
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_NEAR_GS,
        world,
        {
            {Regions.THIEVES_HIDEOUT_KITCHEN_TOP, function(bundle)
                    return true
                end},
            {Regions.GF_BOTTOM_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {Regions.GF_TOP_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_SLOPED_ROOF,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or LogicHelpers.can_ground_jump(bundle)
                end
            },
            {
                Regions.GF_LONG_ROOF,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.GF_JUMP, bundle)
                end
            },
            {Regions.GF_NEAR_CHEST, function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end},
            {Regions.GF_BELOW_GS, function(bundle)
                    return true
                end},
            {
                Regions.GF_GS_KILL_ZONE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOMB_THROW) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            }
        }
    )

    --GF GS Top Floor
    --Location
    LogicHelpers.add_locations(
        Regions.GF_GS_KILL_ZONE,
        world,
        {
            {Locations.GF_GS_TOP_FLOOR, function(bundle)
                    return true
                end}
        }
    )

    --GF Sloped Roof
    --Connection
    LogicHelpers.connect_regions(
        Regions.GF_SLOPED_ROOF,
        world,
        {
            {Regions.GF_TOP_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {Regions.GF_NEAR_GS, function(bundle)
                    return true
                end},
            {Regions.GF_BOTTOM_OF_UPPER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_TOP_OF_UPPER_VINES,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.GF_JUMP, bundle)
                end
            }
        }
    )

    --GF Bottom of Upper Vines
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_BOTTOM_OF_UPPER_VINES,
        world,
        {
            {Regions.GF_OUTSIDE_GTG, function(bundle)
                    return true
                end},
            {Regions.GF_TOP_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_SLOPED_ROOF,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_do_trick(Tricks.GF_JUMP, bundle))
                end
            },
            {Regions.GF_TOP_OF_UPPER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_TO_GTG,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.GF_LEDGE_CLIP_INTO_GTG, bundle)
                end
            }
        }
    )

    --GF Top of Upper Vines
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_TOP_OF_UPPER_VINES,
        world,
        {
            {Regions.GF_TOP_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {Regions.GF_SLOPED_ROOF, function(bundle)
                    return true
                end},
            {Regions.GF_BOTTOM_OF_UPPER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_NEAR_CHEST,
                function(bundle)
                    return LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.SCARECROW, bundle) and
                            LogicHelpers.can_use(Items.HOOKSHOT, bundle)) or
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Regions.GF_GS_KILL_ZONE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.SHORT_JUMPSLASH) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            }
        }
    )

    --GF Near Chest
    --Locations
    LogicHelpers.add_locations(
        Regions.GF_NEAR_CHEST,
        world,
        {
            {Locations.GF_CHEST, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_NEAR_CHEST,
        world,
        {
            {Regions.GF_NEAR_GS, function(bundle)
                    return true
                end},
            {Regions.GF_LONG_ROOF, function(bundle)
                    return true
                end},
            {
                Regions.GF_GS_KILL_ZONE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            }
        }
    )

    --GF Long Roof
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_LONG_ROOF,
        world,
        {
            {Regions.GF_BOTTOM_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_NEAR_GS,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.can_do_trick(Tricks.GF_JUMP, bundle)) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)
                end
            },
            {Regions.GF_BELOW_GS, function(bundle)
                    return true
                end},
            {Regions.GF_NEAR_CHEST, function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end},
            {Regions.GF_BELOW_CHEST, function(bundle)
                    return true
                end}
        }
    )

    --GF Below GS
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_BELOW_GS,
        world,
        {
            {Regions.THIEVES_HIDEOUT_DEAD_END_CELL, function(bundle)
                    return true
                end},
            {Regions.GF_BOTTOM_OF_LOWER_VINES, function(bundle)
                    return true
                end},
            {
                Regions.GF_GS_KILL_ZONE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.LONGSHOT) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            }
        }
    )

    --GF Below Chest
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_BELOW_CHEST,
        world,
        {
            {Regions.THIEVES_HIDEOUT_BREAK_ROOM, function(bundle)
                    return true
                end},
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end}
        }
    )

    --GF Above Jail
    --Locations
    LogicHelpers.add_locations(
        Regions.GF_ABOVE_JAIL,
        world,
        {
            {Locations.GF_ABOVE_JAIL_CRATE, function(bundle)
                    return true
                end}
        }
    )
    --Connection
    LogicHelpers.connect_regions(
        Regions.GF_ABOVE_JAIL,
        world,
        {
            {
                Regions.GERUDO_FORTRESS_OUTSKIRTS,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.GF_JUMP, bundle)
                end
            },
            {Regions.GF_NEAR_CHEST, function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end},
            {Regions.GF_BELOW_CHEST, function(bundle)
                    return LogicHelpers.take_damage(bundle)
                end},
            {Regions.GF_JAIL_WINDOW, function(bundle)
                    return LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end},
            {Regions.THIEVES_HIDEOUT_BREAK_ROOM_CORRIDOR, function(bundle)
                    return true
                end}
        }
    )

    --GF Jail Window
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_JAIL_WINDOW,
        world,
        {
            {Regions.GERUDO_FORTRESS_OUTSKIRTS, function(bundle)
                    return true
                end},
            {Regions.GF_BELOW_CHEST, function(bundle)
                    return true
                end}
        }
    )

    --GF HBA Range
    --Locations
    LogicHelpers.add_locations(
        Regions.GF_HBA_RANGE,
        world,
        {
            {
                Locations.GF_HBA_1000_POINTS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and
                        LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle) and
                        LogicHelpers.can_use(Items.EPONA, bundle) and
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                        LogicHelpers.at_day(bundle)
                end
            },
            {
                Locations.GF_HBA_1500_POINTS,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.CHILD_WALLET, bundle) and
                        LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle) and
                        LogicHelpers.can_use(Items.EPONA, bundle) and
                        LogicHelpers.can_use(Items.FAIRY_BOW, bundle) and
                        LogicHelpers.at_day(bundle)
                end
            },
            {
                Locations.GF_GS_ARCHERY_RANGE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        LogicHelpers.can_get_enemy_drop(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.BOOMERANG) and
                        LogicHelpers.can_get_nighttime_gs(bundle)
                end
            },
            {Locations.GF_HBA_RANGE_CRATE_1, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end},
            {Locations.GF_HBA_RANGE_CRATE_2, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end},
            {Locations.GF_HBA_RANGE_CRATE_3, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end},
            {Locations.GF_HBA_RANGE_CRATE_4, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end},
            {Locations.GF_HBA_RANGE_CRATE_5, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end},
            {Locations.GF_HBA_RANGE_CRATE_6, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end},
            {Locations.GF_HBA_RANGE_CRATE_7, function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end},
            {
                Locations.GF_HBA_CANOPY_EAST_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_HBA_CANOPY_WEST_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_NORTH_TARGET_EAST_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_NORTH_TARGET_WEST_CRATE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) or
                        (LogicHelpers.blast_or_smash(bundle) or LogicHelpers.hookshot_or_boomerang(bundle) or
                            LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))
                end
            },
            {
                Locations.GF_NORTH_TARGET_CHILD_CRATE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.blast_or_smash(bundle)
                end
            },
            {
                Locations.GF_SOUTH_TARGET_EAST_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.GF_SOUTH_TARGET_WEST_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_HBA_RANGE,
        world,
        {
            {
                Regions.GF_OUTSIDE_GTG,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle)
                end
            }
        }
    )

    --GF Outside Gate
    --Events
    LogicHelpers.add_events(
        Regions.GF_OUTSIDE_GATE,
        world,
        {
            {
                EventLocations.GF_GATE_OUTSIDE,
                LocalEvents.GF_GATE_OPEN,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(Items.GERUDO_MEMBERSHIP_CARD, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_OUTSIDE_GATE,
        world,
        {
            {
                Regions.GERUDO_FORTRESS_OUTSKIRTS,
                function(bundle)
                    return LogicHelpers.has_item(LocalEvents.GF_GATE_OPEN, bundle)
                end
            },
            {Regions.WASTELAND_NEAR_FORTRESS, function(bundle)
                    return true
                end}
        }
    )

    --GF Storms Grotto
    --Events
    LogicHelpers.add_events(
        Regions.GF_STORMS_GROTTO,
        world,
        {
            {
                EventLocations.GF_STORMS_GROTTO_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.GF_STORMS_GROTTO,
        world,
        {
            {Locations.GF_FAIRY_GROTTO_FAIRY1, function(bundle)
                    return true
                end},
            {Locations.GF_FAIRY_GROTTO_FAIRY2, function(bundle)
                    return true
                end},
            {Locations.GF_FAIRY_GROTTO_FAIRY3, function(bundle)
                    return true
                end},
            {Locations.GF_FAIRY_GROTTO_FAIRY4, function(bundle)
                    return true
                end},
            {Locations.GF_FAIRY_GROTTO_FAIRY5, function(bundle)
                    return true
                end},
            {Locations.GF_FAIRY_GROTTO_FAIRY6, function(bundle)
                    return true
                end},
            {Locations.GF_FAIRY_GROTTO_FAIRY7, function(bundle)
                    return true
                end},
            {Locations.GF_FAIRY_GROTTO_FAIRY8, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.GF_STORMS_GROTTO,
        world,
        {
            {Regions.GF_NEAR_GROTTO, function(bundle)
                    return true
                end}
        }
    )
end

return set_region_rules
