local EventLocations = {
    LW_GOSSIP_STONE_SONG_FAIRY = "LW Gossip Stone Song Fairy",
    LW_BEAN_PLANT_FAIRY = "LW Bean Plant Fairy",
    LW_BUG_GRASS = "LW Bug Grass",
    LW_SKULL_KID_MASK_TRADE = "LW Skull Kid Mask Trade",
    LW_BUTTERFLY_FAIRY = "LW Butterfly Fairy",
    LW_NEAR_SHORTCUTS_GROTTO_GOSSIP_STONE_SONG_FAIRY = "LW Near Shortcuts Grotto Gossip Stone Song Fairy",
    LW_NEAR_SHORTCUTS_GROTTO_BUTTERFLY_FAIRY = "LW Near Shortcuts Grotto Butterfly Fairy",
    LW_NEAR_SHORTCUTS_GROTTO_BUG_GRASS = "LW Near Shortcuts Grotto Bug Grass",
    LW_NEAR_SHORTCUTS_GROTTO_PUDDLE_FISH = "LW Near Shortcuts Grotto Puddle Fish",
    LW_BRIDGE_BEAN_PATCH = "LW Bridge Bean Patch",
    LW_THEATER_BEAN_PATCH = "LW Theater Bean Patch"
}

local LocalEvents = {
    LW_BRIDGE_BEAN_PLANTED = "LW Bridge Bean Planted",
    LW_THEATER_BEAN_PLANTED = "LW Theater Bean Planted"
}

local function set_region_rules(world)
    --LW Forest Exit
    --Connections
    LogicHelpers.connect_regions(
        Regions.LW_FOREST_EXIT,
        world,
        {
            {Regions.KOKIRI_FOREST, function(bundle)
                    return true
                end}
        }
    )

    --Lost Woods
    --Events
    LogicHelpers.add_events(
        Regions.LOST_WOODS,
        world,
        {
            {
                EventLocations.LW_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                EventLocations.LW_BEAN_PLANT_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                EventLocations.LW_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                EventLocations.LW_SKULL_KID_MASK_TRADE,
                Events.SOLD_SKULL_MASK,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SARIAS_SONG, bundle) and
                        LogicHelpers.has_item(Events.CAN_BORROW_SKULL_MASK, bundle) and
                        LogicHelpers.has_item(Items.CHILD_WALLET, bundle)
                end
            },
            {
                EventLocations.LW_BRIDGE_BEAN_PATCH,
                LocalEvents.LW_BRIDGE_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.LOST_WOODS,
        world,
        {
            {
                Locations.LW_SKULL_KID,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.SARIAS_SONG, bundle)
                end
            },
            {
                Locations.LW_TRADE_COJIRO,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.COJIRO, bundle)
                end
            },
            {
                Locations.LW_TRADE_ODD_POTION,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_use(Items.ODD_POTION, bundle)
                end
            },
            {
                Locations.LW_OCARINA_MEMORY_GAME,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.FAIRY_OCARINA, bundle) and
                        LogicHelpers.ocarina_button_count(bundle) >= 5
                end
            },
            {
                Locations.LW_TARGET_IN_WOODS,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.FAIRY_SLINGSHOT, bundle)
                end
            },
            {
                Locations.LW_DEKU_SCRUB_NEAR_BRIDGE,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.LW_DEKU_SCRUB_NEAR_BRIDGE,bundle)
                end
            },
            {
                Locations.LW_GS_BEAN_PATCH_NEAR_BRIDGE,
                function(bundle)
                    return LogicHelpers.can_spawn_soil_skull(bundle) and LogicHelpers.can_attack(bundle)
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE4,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE5,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE6,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE7,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_UNDERWATER_SHORTCUT_RUPEE8,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or LogicHelpers.can_use(Items.IRON_BOOTS, bundle))
                end
            },
            {
                Locations.LW_BEAN_SPROUT_NEAR_BRIDGE_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                            LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.LW_BEAN_SPROUT_NEAR_BRIDGE_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                            LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.LW_BEAN_SPROUT_NEAR_BRIDGE_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and
                        (LogicHelpers.can_use(Items.MAGIC_BEAN, bundle) and
                            LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle))
                end
            },
            {
                Locations.LW_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy_except_suns(bundle)
                end
            },
            {
                Locations.LW_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LW_SHORTCUTS_SONG_OF_STORMS_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {Locations.LW_NEAR_SHORTCUTS_GRASS1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LW_NEAR_SHORTCUTS_GRASS2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LW_NEAR_SHORTCUTS_GRASS3, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LOST_WOODS,
        world,
        {
            {Regions.LW_FOREST_EXIT, function(bundle)
                    return true
                end},
            {Regions.GC_WOODS_WARP, function(bundle)
                    return true
                end},
            {
                Regions.LW_BRIDGE,
                function(bundle)
                    return (LogicHelpers.is_adult(bundle) and
                        (LogicHelpers.has_item(LocalEvents.LW_BRIDGE_BEAN_PLANTED, bundle) or
                            LogicHelpers.can_do_trick(Tricks.LW_BRIDGE, bundle))) or
                        LogicHelpers.can_use(Items.HOVER_BOOTS, bundle) or
                        LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end
            },
            {
                Regions.ZR_FROM_SHORTCUT,
                function(bundle)
                    return LogicHelpers.has_item(Items.SILVER_SCALE, bundle) or
                        LogicHelpers.can_use(Items.IRON_BOOTS, bundle) or
                        (LogicHelpers.can_do_trick(Tricks.LOST_WOOD_NAVI_DIVE, bundle) and LogicHelpers.is_child(bundle) and
                            LogicHelpers.has_item(Items.BRONZE_SCALE, bundle) and
                            LogicHelpers.can_jump_slash(bundle))
                end
            },
            {
                Regions.LW_BEYOND_MIDO,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.SARIAS_SONG, bundle) or
                        LogicHelpers.can_do_trick(Tricks.LW_MIDO_BACKFLIP, bundle)
                end
            },
            {Regions.LW_NEAR_SHORTCUTS_GROTTO, function(bundle)
                    return LogicHelpers.blast_or_smash(bundle)
                end}
        }
    )

    --LW Beyond Mido
    --Events
    LogicHelpers.add_events(
        Regions.LW_BEYOND_MIDO,
        world,
        {
            {
                EventLocations.LW_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.STICKS, bundle)
                end
            },
            {
                EventLocations.LW_THEATER_BEAN_PATCH,
                LocalEvents.LW_THEATER_BEAN_PLANTED,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_use(Items.MAGIC_BEAN, bundle)
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.LW_BEYOND_MIDO,
        world,
        {
            {
                Locations.LW_DEKU_SCRUB_NEAR_DEKU_THEATER_RIGHT,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices", Locations.LW_DEKU_SCRUB_NEAR_DEKU_THEATER_RIGHT,bundle)
                end
            },
            {
                Locations.LW_DEKU_SCRUB_NEAR_DEKU_THEATER_LEFT,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.can_stun_deku(bundle)
                    and LogicHelpers.can_afford_item("scrub_prices", Locations.LW_DEKU_SCRUB_NEAR_DEKU_THEATER_LEFT,bundle)
                end
            },
            {
                Locations.LW_GS_ABOVE_THEATER,
                function(bundle)
                    return LogicHelpers.is_adult(bundle) and LogicHelpers.can_get_nighttime_gs(bundle) and
                        (LogicHelpers.has_item(LocalEvents.LW_THEATER_BEAN_PLANTED, bundle) and
                            (LogicHelpers.can_attack(bundle)) or
                            (LogicHelpers.can_do_trick(Tricks.LW_GS_BEAN, bundle) and
                                LogicHelpers.can_use(Items.LONGSHOT, bundle) and
                                LogicHelpers.can_use_any(
                                    {Items.FAIRY_BOW, Items.FAIRY_SLINGSHOT, Items.BOMBCHUS_5, Items.DINS_FIRE},
                                    bundle
                                )))
                end
            },
            {
                Locations.LW_GS_BEAN_PATCH_NEAR_THEATER,
                function(bundle)
                    return LogicHelpers.can_spawn_soil_skull(bundle) and
                        (LogicHelpers.can_attack(bundle) or
                            (world:get_option("shuffle_scrubs") == false and LogicHelpers.can_reflect_nuts(bundle)))
                end
            },
            {Locations.LW_BOULDER_RUPEE, function(bundle)
                    return LogicHelpers.blast_or_smash(bundle)
                end},
            {
                Locations.LW_BEAN_SPROUT_NEAR_THEATRE_FAIRY1,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LW_BEAN_SPROUT_NEAR_THEATRE_FAIRY2,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LW_BEAN_SPROUT_NEAR_THEATRE_FAIRY3,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Items.MAGIC_BEAN, bundle) and
                        LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {Locations.LW_AFTER_MIDO_GRASS1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LW_AFTER_MIDO_GRASS2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LW_AFTER_MIDO_GRASS3, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LW_NEAR_SFM_GRASS1, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LW_NEAR_SFM_GRASS2, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end},
            {Locations.LW_NEAR_SFM_GRASS3, function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LW_BEYOND_MIDO,
        world,
        {
            {Regions.LW_FOREST_EXIT, function(bundle)
                    return true
                end},
            {
                Regions.LOST_WOODS,
                function(bundle)
                    return LogicHelpers.is_child(bundle) or LogicHelpers.can_use(Items.SARIAS_SONG, bundle)
                end
            },
            {Regions.SFM_ENTRYWAY, function(bundle)
                    return true
                end},
            {Regions.DEKU_THEATER, function(bundle)
                    return true
                end},
            {Regions.LW_SCRUBS_GROTTO, function(bundle)
                    return LogicHelpers.blast_or_smash(bundle)
                end}
        }
    )

    --LW Near Shortcuts Grotto
    --Events
    LogicHelpers.add_events(
        Regions.LW_NEAR_SHORTCUTS_GROTTO,
        world,
        {
            {
                EventLocations.LW_NEAR_SHORTCUTS_GROTTO_GOSSIP_STONE_SONG_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                EventLocations.LW_NEAR_SHORTCUTS_GROTTO_BUTTERFLY_FAIRY,
                Events.CAN_ACCESS_FAIRIES,
                function(bundle)
                    return LogicHelpers.can_use(Items.STICKS, bundle)
                end
            },
            {
                EventLocations.LW_NEAR_SHORTCUTS_GROTTO_BUG_GRASS,
                Events.CAN_ACCESS_BUGS,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                EventLocations.LW_NEAR_SHORTCUTS_GROTTO_PUDDLE_FISH,
                Events.CAN_ACCESS_FISH,
                function(bundle)
                    return true
                end
            }
        }
    )
    --Locations
    LogicHelpers.add_locations(
        Regions.LW_NEAR_SHORTCUTS_GROTTO,
        world,
        {
            {Locations.LW_NEAR_SHORTCUTS_GROTTO_CHEST, function(bundle)
                    return true
                end},
            {
                Locations.LW_NEAR_SHORTCUTS_GROTTO_FISH,
                function(bundle)
                    return LogicHelpers.has_bottle(bundle)
                end
            },
            {
                Locations.LW_TUNNEL_GROTTO_GOSSIP_STONE_FAIRY,
                function(bundle)
                    return LogicHelpers.call_gossip_fairy(bundle)
                end
            },
            {
                Locations.LW_TUNNEL_GROTTO_GOSSIP_STONE_BIG_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)
                end
            },
            {
                Locations.LW_TUNNEL_GROTTO_BEEHIVE_LEFT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.LW_TUNNEL_GROTTO_BEEHIVE_RIGHT,
                function(bundle)
                    return LogicHelpers.can_break_lower_hives(bundle)
                end
            },
            {
                Locations.LW_NEAR_SHORTCUTS_GROTTO_GRASS1,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.LW_NEAR_SHORTCUTS_GROTTO_GRASS2,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.LW_NEAR_SHORTCUTS_GROTTO_GRASS3,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            },
            {
                Locations.LW_NEAR_SHORTCUTS_GROTTO_GRASS4,
                function(bundle)
                    return LogicHelpers.can_cut_shrubs(bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LW_NEAR_SHORTCUTS_GROTTO,
        world,
        {
            {Regions.LOST_WOODS, function(bundle)
                    return true
                end}
        }
    )

    --Deku Theater
    --Locations
    LogicHelpers.add_locations(
        Regions.DEKU_THEATER,
        world,
        {
            {
                Locations.LW_DEKU_THEATER_SKULL_MASK,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Events.CAN_BORROW_SKULL_MASK, bundle)
                end
            },
            {
                Locations.LW_DEKU_THEATER_MASK_OF_TRUTH,
                function(bundle)
                    return LogicHelpers.is_child(bundle) and LogicHelpers.has_item(Events.CAN_BORROW_MASK_OF_TRUTH, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.DEKU_THEATER,
        world,
        {
            {Regions.LOST_WOODS, function(bundle)
                    return true
                end}
        }
    )

    --LW Scrubs Grotto
    LogicHelpers.add_locations(
        Regions.LW_SCRUBS_GROTTO,
        world,
        {
            {
                Locations.LW_DEKU_SCRUB_GROTTO_REAR,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.LW_DEKU_SCRUB_GROTTO_REAR,bundle)
                end
            },
            {
                Locations.LW_DEKU_SCRUB_GROTTO_FRONT,
                function(bundle)
                    return LogicHelpers.can_stun_deku(bundle) and
                    LogicHelpers.can_afford_item("scrub_prices", Locations.LW_DEKU_SCRUB_GROTTO_FRONT,bundle)
                end
            },
            {
                Locations.LW_DEKU_SCRUB_GROTTO_BEEHIVE,
                function(bundle)
                    return LogicHelpers.can_break_upper_beehives(bundle)
                end
            },
            {
                Locations.LW_DEKU_SCRUB_GROTTO_SUN_FAIRY,
                function(bundle)
                    return LogicHelpers.can_use(Items.SUNS_SONG, bundle)
                end
            }
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LW_SCRUBS_GROTTO,
        world,
        {
            {Regions.LW_BEYOND_MIDO, function(bundle)
                    return true
                end}
        }
    )

    --LW Bridge From Forest
    --Location
    LogicHelpers.add_locations(
        Regions.LW_BRIDGE_FROM_FOREST,
        world,
        {
            {Locations.LW_GIFT_FROM_SARIA, function(bundle)
                    return true
                end}
        }
    )
    --Connections
    LogicHelpers.connect_regions(
        Regions.LW_BRIDGE_FROM_FOREST,
        world,
        {
            {Regions.LW_BRIDGE, function(bundle)
                    return true
                end}
        }
    )

    --LW Bridge
    --Connections
    LogicHelpers.connect_regions(
        Regions.LW_BRIDGE,
        world,
        {
            {Regions.KOKIRI_FOREST, function(bundle)
                    return true
                end},
            {Regions.HYRULE_FIELD, function(bundle)
                    return true
                end},
            {Regions.LOST_WOODS, function(bundle)
                    return LogicHelpers.can_use(Items.LONGSHOT, bundle)
                end}
        }
    )
end

return set_region_rules
