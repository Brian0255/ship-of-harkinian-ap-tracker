local EventLocations = {
    WASTELAND_FAIRY_POT = "Wasteland Fairy Pot",
    WASTELAND_NUT_POT = "Wasteland Nut Pot",
    WASTELAND_CARPET_SALESMAN_STORE = "Wasteland Carpet Salesman Store"
}

local function set_region_rules(world)
    --Haunted Wasteland Near Fortress
    --Locations
    LogicHelpers.add_locations(
        Regions.WASTELAND_NEAR_FORTRESS,
        world,
        {
            {
                Locations.WASTELAND_BEFORE_QUICKSAND_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WASTELAND_NEAR_FORTRESS,
        world,
        {
            {
                Regions.GF_OUTSIDE_GATE,
                function(bundle)
                    return true
                end
            },
            {
                Regions.HAUNTED_WASTELAND,
                function(bundle)
                    return LogicHelpers.can_use_any({Items.HOVER_BOOTS, Items.LONGSHOT}, bundle) or
                        LogicHelpers.can_do_trick(Tricks.HW_CROSSING, bundle)
                end
            }
        }
    )

    --Haunted Wasteland
    --Events
    LogicHelpers.add_events(
        Regions.HAUNTED_WASTELAND,
        world,
        {
            {
                EventLocations.WASTELAND_FAIRY_POT,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return true
                end
            },
            {
                EventLocations.WASTELAND_NUT_POT,
                Events.CAN_FARM_NUTS,
                function(bundle)
                    return true
                end
            }
        }
    )
    LogicHelpers.add_events(
        Regions.HAUNTED_WASTELAND,
        world,
        {
            {
                EventLocations.WASTELAND_CARPET_SALESMAN_STORE,
                Events.CARPET_MERCHANT,
                function(bundle)
                    local shuffled = LogicHelpers.merchant_shuffled(Locations.WASTELAND_CARPET_SALESMAN, bundle)
                    return not shuffled and LogicHelpers.has_item(Items.ADULT_WALLET, bundle) and
                        (LogicHelpers.can_jump_slash(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.HAUNTED_WASTELAND,
        world,
        {
            {
                Locations.WASTELAND_CHEST,
                function(bundle)
                    return LogicHelpers.has_fire_source(bundle)
                end
            },
            {
                Locations.WASTELAND_CARPET_SALESMAN,
                function(bundle)
                    local shuffled = LogicHelpers.merchant_shuffled(Locations.WASTELAND_CARPET_SALESMAN, bundle)
                    return (not shuffled and LogicHelpers.has_item(Items.ADULT_WALLET, bundle) and
                        (LogicHelpers.can_jump_slash(bundle) or LogicHelpers.can_use(Items.HOVER_BOOTS, bundle))) or
                        (shuffled and
                            LogicHelpers.can_afford_item("merchant_prices", Locations.WASTELAND_CARPET_SALESMAN, bundle))
                end
            },
            {
                Locations.WASTELAND_GS,
                function(bundle)
                    return LogicHelpers.hookshot_or_boomerang(bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_ground_jump(bundle) and
                            LogicHelpers.can_jump_slash(bundle))
                end
            },
            {
                Locations.WASTELAND_NEAR_GS_POT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WASTELAND_NEAR_GS_POT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WASTELAND_NEAR_GS_POT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WASTELAND_NEAR_GS_POT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.WASTELAND_AFTER_QUICKSAND_CRATE1,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.WASTELAND_AFTER_QUICKSAND_CRATE2,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.WASTELAND_AFTER_QUICKSAND_CRATE3,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.HAUNTED_WASTELAND,
        world,
        {
            {
                Regions.WASTELAND_NEAR_COLOSSUS,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.LENS_HW, bundle) or
                        LogicHelpers.can_use(Items.LENS_OF_TRUTH, bundle)
                end
            },
            {
                Regions.WASTELAND_NEAR_FORTRESS,
                function(bundle)
                    return LogicHelpers.can_use_any({Items.HOVER_BOOTS, Items.LONGSHOT}, bundle) or
                        LogicHelpers.can_do_trick(Tricks.HW_CROSSING, bundle)
                end
            }
        }
    )

    --Haunted Wasteland Near Colossus
    --Locations
    LogicHelpers.add_locations(
        Regions.WASTELAND_NEAR_COLOSSUS,
        world,
        {
            {
                Locations.WASTELAND_NEAR_COLOSSUS_CRATE,
                function(bundle)
                    return LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.WASTELAND_NEAR_COLOSSUS,
        world,
        {
            {
                Regions.DESERT_COLOSSUS,
                function(bundle)
                    return true
                end
            },
            {
                Regions.HAUNTED_WASTELAND,
                function(bundle)
                    return LogicHelpers.can_do_trick(Tricks.HW_REVERSE, bundle)
                end
            }
        }
    )
end

return set_region_rules
