local EventLocations = {
    DMC_GOSSIP_STONE_SONG_FAIRY = "DMC Gossip Stone Song Fairy",
    DMC_BEAN_PLANT_FAIRY = "DMC Bean Plant Fairy",
    DMC_UPPER_GROTTO_GOSSIP_STONE_SONG_FAIRY = "DMC Upper Grotto Gossip Stone Song Fairy",
    DMC_UPPER_GROTTO_BUTTERFLY_FAIRY = "DMC Upper Grotto Butterfly Fairy",
    DMC_UPPER_GROTTO_BUG_GRASS = "DMC Upper Grotto Bug Grass",
    DMC_UPPER_GROTTO_PUDDLE_FISH = "DMC Upper Grotto Puddle Fish",
    DMC_BEAN_PATCH = "DMC Bean Patch"
}

local LocalEvents = {
    DMC_BEAN_PLANTED = "DMC Bean Planted"
}

local function set_region_rules(world)
    --Death Mountain Crater Upper Nearby
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_UPPER_NEARBY,
        world,
        {
            {
                Regions.DMC_UPPER_LOCAL,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 48
                end
            },
            {
                Regions.DEATH_MOUNTAIN_SUMMIT,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DMC_UPPER_GROTTO,
                function(bundle)
                    return LogicHelpers.blast_or_smash(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            }
        }
    )

    --Death Mountain Crater Upper Local
    --Events
    LogicHelpers.add_events(
        Regions.DMC_UPPER_LOCAL,
        world,
        {
            {
                EventLocations.DMC_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.has_explosives(bundle) and LogicHelpers.call_gossip_fairy_except_suns(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 16 or LogicHelpers.hearts(bundle) >= 3)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_UPPER_LOCAL,
        world,
        {
            {
                Locations.DMC_WALL_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 16 or LogicHelpers.hearts(bundle) >= 3
                end
            },
            {
                Locations.DMC_GS_CRATE,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3) and
                        LogicHelpers.is_child(bundle) and
                        LogicHelpers.can_attack(bundle) and
                        LogicHelpers.can_break_crates(bundle)
                end
            },
            {
                Locations.DMC_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle) and LogicHelpers.has_explosives(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 16 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 16 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_CRATE,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3) and
                        LogicHelpers.is_child(bundle) and
                        LogicHelpers.can_break_crates(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_UPPER_LOCAL,
        world,
        {
            {
                Regions.DMC_UPPER_NEARBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DMC_LADDER_REGION_NEARBY,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 16 or LogicHelpers.hearts(bundle) >= 3
                end
            },
            {
                Regions.DMC_CENTRAL_NEARBY,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.GORON_TUNIC, bundle) and
                        LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle) and
                        (LogicHelpers.effective_health(
                            --TODO Implement Dungeon Shuffle Option to replace false
                            bundle
                        ) > 2 or
                            (LogicHelpers.can_use(Items.BOTTLE_WITH_FAIRY, bundle) and false or
                                LogicHelpers.can_use(Items.NAYRUS_LOVE, bundle)))
                end
            },
            {
                Regions.DMC_LOWER_NEARBY,
                function(bundle)
                    return false
                end
            },
            {
                Regions.DMC_DISTANT_PLATFORM,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 48 or LogicHelpers.hearts(bundle) >= 2) or
                        LogicHelpers.hearts(bundle) >= 3
                end
            }
        }
    )

    --Death Mountain Crater Ladder Area Nearby
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_LADDER_REGION_NEARBY,
        world,
        {
            {
                Locations.DMC_DEKU_SCRUB,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.DMC_DEKU_SCRUB, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_LADDER_REGION_NEARBY,
        world,
        {
            {
                Regions.DMC_UPPER_NEARBY,
                function(bundle)
                    return LogicHelpers.hearts(bundle) >= 3
                end
            },
            {
                Regions.DMC_LOWER_NEARBY,
                function(bundle)
                    return LogicHelpers.hearts(bundle) >= 3 and
                        (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.DMC_BOULDER_JS, bundle) and LogicHelpers.is_adult(bundle) and
                                LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)) or
                            (LogicHelpers.can_do_trick(Tricks.DMC_BOULDER_SKIP, bundle) and LogicHelpers.is_adult(bundle)))
                end
            }
        }
    )

    --Death Mountain Crater Lower Nearby
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_LOWER_NEARBY,
        world,
        {
            {
                Locations.DMC_NEAR_GCPOT1,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DMC_NEAR_GCPOT2,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DMC_NEAR_GCPOT3,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            },
            {
                Locations.DMC_NEAR_GCPOT4,
                function(bundle)
                    return LogicHelpers.can_break_pots(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_LOWER_NEARBY,
        world,
        {
            {
                Regions.DMC_LOWER_LOCAL,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 48
                end
            },
            {
                Regions.GC_DARUNIAS_CHAMBER,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DMC_GREAT_FAIRY_FOUNTAIN,
                function(bundle)
                    return LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            },
            {
                Regions.DMC_HAMMER_GROTTO,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)
                end
            }
        }
    )

    --Death Mountain Crater Lower Local
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_LOWER_LOCAL,
        world,
        {
            {
                Regions.DMC_LOWER_NEARBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DMC_LADDER_REGION_NEARBY,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3
                end
            },
            {
                Regions.DMC_CENTRAL_NEARBY,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle)) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Regions.DMC_CENTRAL_LOCAL,
                function(bundle)
                    return (LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or LogicHelpers.can_use(Items.HOOKSHOT, bundle) or
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.can_shield(bundle) and
                            LogicHelpers.can_do_trick(Tricks.DMC_BOLERO_JUMP, bundle))) and
                        LogicHelpers.fire_timer(bundle) >= 24
                end
            }
        }
    )

    --Death Mountain Crater Central Nearby
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_CENTRAL_NEARBY,
        world,
        {
            {
                Locations.SHEIK_IN_CRATER,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_VOLCANO_FREESTANDING_POH,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.hearts(bundle) >= 3 and
                        (LogicHelpers.has_item(LocalEvents.DMC_BEAN_PLANTED, bundle) or
                            (LogicHelpers.can_do_trick(Tricks.DMC_HOVER_BEAN_POH, bundle) and
                                LogicHelpers.can_use(Items.HOVER_BOOTS, bundle)))
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_CENTRAL_NEARBY,
        world,
        {
            {
                Regions.DMC_CENTRAL_LOCAL,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 48
                end
            }
        }
    )

    --Death Mountain Crater Central Local
    --Events
    LogicHelpers.add_events(
        Regions.DMC_CENTRAL_LOCAL,
        world,
        {
            {
                EventLocations.DMC_BEAN_PLANT_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                EventLocations.DMC_BEAN_PATCH,
                LocalEvents.DMC_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_CENTRAL_LOCAL,
        world,
        {
            {
                Locations.DMC_GS_BEAN_PATCH,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3) and
                        LogicHelpers.can_spawn_soil_skull(bundle) and
                        LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.DMC_NEAR_WARP_PLATFORM_RED_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle)
                end
            },
            {
                Locations.DMC_MIDDLE_PLATFORM_RED_RUPEE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_MIDDLE_PLATFORM_BLUE_RUPEE1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_MIDDLE_PLATFORM_BLUE_RUPEE2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_MIDDLE_PLATFORM_BLUE_RUPEE3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_MIDDLE_PLATFORM_BLUE_RUPEE4,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_MIDDLE_PLATFORM_BLUE_RUPEE5,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_MIDDLE_PLATFORM_BLUE_RUPEE6,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_BEAN_SPROUT_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_BEAN_SPROUT_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            },
            {
                Locations.DMC_BEAN_SPROUT_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) and
                        (LogicHelpers.fire_timer(bundle) >= 8 or LogicHelpers.hearts(bundle) >= 3)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_CENTRAL_LOCAL,
        world,
        {
            {
                Regions.DMC_CENTRAL_NEARBY,
                function(bundle)
                    return true
                end
            },
            {
                Regions.DMC_LOWER_NEARBY,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(LocalEvents.DMC_BEAN_PLANTED, bundle)) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.HOOKSHOT, bundle)
                end
            },
            {
                Regions.DMC_UPPER_NEARBY,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.has_item(LocalEvents.DMC_BEAN_PLANTED, bundle)
                end
            },
            {
                Regions.FIRE_TEMPLE_ENTRYWAY,
                function(bundle)
                    return (LogicHelpers.is_child(bundle) and LogicHelpers.hearts(bundle) >= 3 and false) or
                        --TODO Implement Dungeon Shuffle Option to replace false
                        (LogicHelpers.is_adult(bundle) and LogicHelpers.fire_timer(bundle) >= 24)
                end
            },
            {
                Regions.DMC_DISTANT_PLATFORM,
                function(bundle)
                    return (LogicHelpers.fire_timer(bundle) >= 48 or LogicHelpers.hearts(bundle) >= 2) and
                        LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle)
                end
            }
        }
    )

    --Death Mountain Crater Great Fairy Fountain
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {
                Locations.DMC_GREAT_FAIRY_REWARD,
                function(bundle)
                    return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_GREAT_FAIRY_FOUNTAIN,
        world,
        {
            {
                Regions.DMC_LOWER_LOCAL,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Death Mountain Crater Upper Grotto
    --Events
    LogicHelpers.add_events(
        Regions.DMC_UPPER_GROTTO,
        world,
        {
            {
                EventLocations.DMC_UPPER_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.call_gossip_fairy(bundle))
                end
            },
            {
                EventLocations.DMC_UPPER_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return (LogicHelpers.can_use(Items.STICKS, bundle))
                end
            },
            {
                EventLocations.DMC_UPPER_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return (LogicHelpers.can_cut_shrubs(bundle))
                end
            },
            {
                EventLocations.DMC_UPPER_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_UPPER_GROTTO,
        world,
        {
            {
                Locations.DMC_UPPER_GROTTO_CHEST,
                function(bundle)
                    return true
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_FISH,
                function(bundle)
                    return LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.DMC_UPPER_GROTTO_GRASS4,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_UPPER_GROTTO,
        world,
        {
            {
                Regions.DMC_UPPER_LOCAL,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Death Mountain Crater Hammer Grotto
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_HAMMER_GROTTO,
        world,
        {
            {
                Locations.DMC_DEKU_SCRUB_GROTTO_LEFT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.DMC_DEKU_SCRUB_GROTTO_LEFT, bundle)
                end
            },
            {
                Locations.DMC_DEKU_SCRUB_GROTTO_RIGHT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.DMC_DEKU_SCRUB_GROTTO_RIGHT, bundle)
                end
            },
            {
                Locations.DMC_DEKU_SCRUB_GROTTO_CENTER,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                        LogicHelpers.can_afford_item("scrub_prices", Locations.DMC_DEKU_SCRUB_GROTTO_CENTER, bundle)
                end
            },
            {
                Locations.DMC_HAMMER_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_HAMMER_GROTTO,
        world,
        {
            {
                Regions.DMC_LOWER_LOCAL,
                function(bundle)
                    return true
                end
            }
        }
    )

    --Death Mountain Crater Distant Platform
    --Locations
    LogicHelpers.add_locations(
        Regions.DMC_DISTANT_PLATFORM,
        world,
        {
            {
                Locations.DMC_DISTANT_PLATFORM_RUPEE1,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.DMC_DISTANT_PLATFORM_RUPEE2,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.DMC_DISTANT_PLATFORM_RUPEE3,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.DMC_DISTANT_PLATFORM_RUPEE4,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.DMC_DISTANT_PLATFORM_RUPEE5,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.DMC_DISTANT_PLATFORM_RUPEE6,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            },
            {
                Locations.DMC_DISTANT_PLATFORM_RED_RUPEE,
                function(bundle)
                    return LogicHelpers.is_adult(bundle)
                end
            }
        }
    )

    --Connections
    LogicHelpers.connect_regions(
        Regions.DMC_DISTANT_PLATFORM,
        world,
        {
            {
                Regions.DMC_CENTRAL_LOCAL,
                function(bundle)
                    return LogicHelpers.fire_timer(bundle) >= 48 and LogicHelpers.can_use(Items.DISTANT_SCARECROW, bundle)
                end
            }
        }
    )
end

return set_region_rules
