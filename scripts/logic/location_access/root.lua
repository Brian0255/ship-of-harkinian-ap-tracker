local EventLocations = {
    ROOT_AMMO_DROP = "Root Ammo Drop",
    ROOT_DEKU_SHIELD = "Root Deku Shield",
    ROOT_HYLIAN_SHIELD = "Root Hylian Shield",
    TRIFORCE_HUNT_COMPLETION = "Triforce Hunt Completion",
    ZELDAS_LETTER_FROM_SKIP_OPTION = "Zeldas Letter From Skip Option"
}

local function set_region_rules(world)
    LogicHelpers.add_locations(
        Regions.ROOT,
        world,
        {
            {
                Locations.LINKS_POCKET,
                function(bundle)
                    return true
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.ROOT,
        world,
        {
            {
                Regions.ROOT_EXITS,
                function(bundle)
                    return LogicHelpers.starting_age(bundle) or LogicHelpers.has_item(Events.TIME_TRAVEL, bundle)
                end
            }
        }
    )

    LogicHelpers.add_locations(
        Regions.ROOT_EXITS,
        world,
        {
            {
                Locations.LINKS_POCKET,
                function(bundle)
                    return true
                end
            }
        }
    )

    LogicHelpers.add_events(
        Regions.ROOT,
        world,
        {
            {
                EventLocations.ZELDAS_LETTER_FROM_SKIP_OPTION,
                Items.ZELDAS_LETTER,
                function(bundle)
                    return bundle[3]:get_option("skip_child_zelda")
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.ROOT,
        world,
        {
            {
                Regions.HC_GARDEN_SONG_FROM_IMPA,
                function(bundle)
                    return bundle[3]:get_option("skip_child_zelda")
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.ROOT,
        world,
        {
            {
                Regions.MASTER_SWORD_PEDESTAL,
                function(bundle)
                    return bundle[3]:get_option("starting_age") == Options.STARTING_AGE_ADULT and
                        not bundle[3]:get_option("shuffle_master_sword")
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.ROOT_EXITS,
        world,
        {
            {
                Regions.CHILD_SPAWN,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Regions.ADULT_SPAWN,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Regions.MINUET_OF_FOREST_WARP,
                function(bundle)
                    return true
                end
            },
            {
                Regions.BOLERO_OF_FIRE_WARP,
                function(bundle)
                    return true
                end
            },
            {
                Regions.SERENADE_OF_WATER_WARP,
                function(bundle)
                    return true
                end
            },
            {
                Regions.NOCTURNE_OF_SHADOW_WARP,
                function(bundle)
                    return true
                end
            },
            {
                Regions.REQUIEM_OF_SPIRIT_WARP,
                function(bundle)
                    return true
                end
            },
            {
                Regions.PRELUDE_OF_LIGHT_WARP,
                function(bundle)
                    return true
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.CHILD_SPAWN,
        world,
        {
            {
                Regions.KF_LINKS_HOUSE,
                function(bundle)
                    return true
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.ADULT_SPAWN,
        world,
        {
            {
                Regions.TEMPLE_OF_TIME,
                function(bundle)
                    return true
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.MINUET_OF_FOREST_WARP,
        world,
        {
            {
                Regions.SACRED_FOREST_MEADOW,
                function(bundle)
                    return LogicHelpers.can_use(Items.MINUET_OF_FOREST, bundle)
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.BOLERO_OF_FIRE_WARP,
        world,
        {
            {
                Regions.DMC_CENTRAL_LOCAL,
                function(bundle)
                    return LogicHelpers.can_use(Items.BOLERO_OF_FIRE, bundle)
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.SERENADE_OF_WATER_WARP,
        world,
        {
            {
                Regions.LAKE_HYLIA,
                function(bundle)
                    return LogicHelpers.can_use(Items.SERENADE_OF_WATER, bundle)
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.REQUIEM_OF_SPIRIT_WARP,
        world,
        {
            {
                Regions.DESERT_COLOSSUS,
                function(bundle)
                    return LogicHelpers.can_use(Items.REQUIEM_OF_SPIRIT, bundle)
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.NOCTURNE_OF_SHADOW_WARP,
        world,
        {
            {
                Regions.GRAVEYARD_WARP_PAD_REGION,
                function(bundle)
                    return LogicHelpers.can_use(Items.NOCTURNE_OF_SHADOW, bundle)
                end
            }
        }
    )

    LogicHelpers.connect_regions(
        Regions.PRELUDE_OF_LIGHT_WARP,
        world,
        {
            {
                Regions.TEMPLE_OF_TIME,
                function(bundle)
                    return LogicHelpers.can_use(Items.PRELUDE_OF_LIGHT, bundle)
                end
            }
        }
    )
end

return set_region_rules
