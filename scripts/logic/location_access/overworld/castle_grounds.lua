


EventLocations = {
    HC_GOSSIP_STONE_SONG_FAIRY = "HC Gossip Stone Song Fairy",
    HC_BUTTERFLY_FAIRY = "HC Butterfly Fairy",
    HC_BUG_ROCK = "HC Bug Rock",
    HC_STORMS_GROTTO_BEHIND_WALLS_NUT_POT = "HC Storms Grotto Behind Walls Nut Pot",
    HC_STORMS_GROTTO_BEHIND_WALLS_GOSSIP_STONE_SONG_FAIRY = "HC Storms Grotto Behind Walls Gossip Stone Song Fairy",
    HC_STORMS_GROTTO_BEHIND_WALLS_WANDERING_BUGS = "HC Storms Grotto Behind Walls Wandering Bugs",
    HC_OGC_RAINBOW_BRIDGE = "HC OGC Rainbow Bridge",
    HC_DAY_NIGHT_CYCLE_CHILD = "HC Day Night Cycle Child",
}


LocalEvents = {
    HC_OGC_RAINBOW_BRIDGE_BUILT = "HC OGC Rainbow Bridge Built"
}


local function set_region_rules(world)
    --Castle Grounds
    --Connections
   LogicHelpers.connect_regions(Regions.CASTLE_GROUNDS, world, {
        {Regions.MARKET, function(bundle) return true end},
        {Regions.HYRULE_CASTLE_GROUNDS, function(bundle) return LogicHelpers.is_child(bundle) end},
        {Regions.GANONS_CASTLE_GROUNDS, function(bundle) return LogicHelpers.is_adult(bundle) end}
    })

    --Hyrule Castle Grounds
    --Events
    LogicHelpers.add_events(Regions.HYRULE_CASTLE_GROUNDS, world, {
        {EventLocations.HC_GOSSIP_STONE_SONG_FAIRY, Events.CAN_ACCESS_FAIRIES,
         function(bundle) return LogicHelpers.call_gossip_fairy(bundle) end},
        {EventLocations.HC_BUTTERFLY_FAIRY, Events.CAN_ACCESS_FAIRIES,
         function(bundle) return LogicHelpers.can_use(Items.STICKS, bundle) end},
        {EventLocations.HC_BUG_ROCK, Events.CAN_ACCESS_BUGS, function(bundle) return true end},
        {EventLocations.HC_DAY_NIGHT_CYCLE_CHILD,
         Events.CHILD_CAN_PASS_TIME, function(bundle) return LogicHelpers.is_child(bundle) end},
    })
    --Locations
   LogicHelpers.add_locations(Regions.HYRULE_CASTLE_GROUNDS, world, {
        {Locations.HC_MALON_EGG, function(bundle) return true end},
        {Locations.HC_GS_TREE,
         function(bundle) return LogicHelpers.can_kill_enemy(bundle, Enemies.GOLD_SKULLTULA, EnemyDistance.CLOSE) and LogicHelpers.can_bonk_trees(bundle) end },
        {Locations.HC_MALON_GOSSIP_STONE_FAIRY,
         function(bundle) return LogicHelpers.call_gossip_fairy(bundle) end},
        {Locations.HC_MALON_GOSSIP_STONE_BIG_FAIRY,
         function(bundle) return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)end},
        {Locations.HC_ROCK_WALL_GOSSIP_STONE_FAIRY,
         function(bundle) return LogicHelpers.call_gossip_fairy(bundle)end},
        {Locations.HC_ROCK_WALL_GOSSIP_STONE_BIG_FAIRY,
         function(bundle) return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle)end},
        {Locations.HC_NEAR_STORMS_GROTTO_GRASS1,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle)end},
        {Locations.HC_NEAR_STORMS_GROTTO_GRASS2,
         function(bundle) return LogicHelpers.can_cut_shrubs(bundle)end},
        {Locations.HC_GROTTO_TREE, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        {Locations.HC_SKULLTULA_TREE, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        {Locations.HC_NEAR_GUARDS_TREE_1, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        {Locations.HC_NEAR_GUARDS_TREE_2, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        {Locations.HC_NEAR_GUARDS_TREE_3, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        {Locations.HC_NEAR_GUARDS_TREE_4, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        {Locations.HC_NEAR_GUARDS_TREE_5, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        {Locations.HC_NEAR_GUARDS_TREE_6, function(bundle) return LogicHelpers.can_bonk_trees(bundle)end},
        })
    --Connections
   LogicHelpers.connect_regions(Regions.HYRULE_CASTLE_GROUNDS, world, {
        {Regions.CASTLE_GROUNDS, function(bundle) return true end},
        {Regions.HC_GREAT_FAIRY_FOUNTAIN, function(bundle) return LogicHelpers.blast_or_smash(bundle) end},
        {Regions.HC_STORMS_GROTTO, function(bundle) return LogicHelpers.can_open_storms_grotto(bundle) end},
    })
       LogicHelpers.connect_regions(Regions.HYRULE_CASTLE_GROUNDS, world, {
            {Regions.HC_GARDEN,
             function(bundle) return world:get_option("skip_child_zelda") == false and LogicHelpers.can_use(Items.WEIRD_EGG, bundle) or
              LogicHelpers.can_do_trick(Tricks.DAMAGE_BOOST_SIMPLE, bundle) and LogicHelpers.has_explosives(bundle) and LogicHelpers.can_jump_slash(bundle) end},
        })


    --Hyrule Castle Garden
    --Locations
       LogicHelpers.add_locations(Regions.HC_GARDEN, world, {
            {Locations.HC_ZELDAS_LETTER, function(bundle) return world:get_option("skip_child_zelda") == false end}
        })
        --Connections
       LogicHelpers.connect_regions(Regions.HC_GARDEN, world, {
            {Regions.HYRULE_CASTLE_GROUNDS, function(bundle) return world:get_option("skip_child_zelda") == false end},
            {Regions.HC_GARDEN_SONG_FROM_IMPA, function(bundle) return world:get_option("skip_child_zelda") == false end}
        })



    --Hyrule Castle Garden Song From Impa
   LogicHelpers.add_locations(Regions.HC_GARDEN_SONG_FROM_IMPA, world, {
        {Locations.SONG_FROM_IMPA, function(bundle) return true end},
    })

    --Hyrule Castle Great Fairy Fountain
    --Locations
   LogicHelpers.add_locations(Regions.HC_GREAT_FAIRY_FOUNTAIN, world, {
        {Locations.HC_GREAT_FAIRY_REWARD,
         function(bundle) return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) end}
    })
    --Connections
   LogicHelpers.connect_regions(Regions.HC_GREAT_FAIRY_FOUNTAIN, world, {
        {Regions.CASTLE_GROUNDS, function(bundle) return true end}
    })

    --Hyrule Castle Storms Grotto
    --Connections
   LogicHelpers.connect_regions(Regions.HC_STORMS_GROTTO, world, {
        {Regions.CASTLE_GROUNDS, function(bundle) return true end},
        {Regions.HC_STORMS_GROTTO_BEHIND_WALLS,
         function(bundle) return LogicHelpers.can_break_mud_walls(bundle) end},
        {Regions.HC_STORMS_SKULLTULA, function(bundle) return LogicHelpers.can_use(
            Items.BOOMERANG, bundle) and LogicHelpers.can_do_trick(Tricks.HC_STORMS_GS, bundle) end}
    })

    --Hyrule Castle Storms Grotto Behind Walls
    --Events
    LogicHelpers.add_events(Regions.HC_STORMS_GROTTO_BEHIND_WALLS, world, {
        {EventLocations.HC_STORMS_GROTTO_BEHIND_WALLS_NUT_POT,
         Events.CAN_FARM_NUTS, function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {EventLocations.HC_STORMS_GROTTO_BEHIND_WALLS_GOSSIP_STONE_SONG_FAIRY, Events.CAN_ACCESS_FAIRIES,
         function(bundle) return LogicHelpers.call_gossip_fairy(bundle) end},
        {EventLocations.HC_STORMS_GROTTO_BEHIND_WALLS_WANDERING_BUGS,
         Events.CAN_ACCESS_BUGS, function(bundle) return true end}

    })
    --Locations
   LogicHelpers.add_locations(Regions.HC_STORMS_GROTTO_BEHIND_WALLS, world, {
        {Locations.HC_STORMS_GROTTO_GOSSIP_STONE_FAIRY,
         function(bundle) return LogicHelpers.call_gossip_fairy(bundle) end},
        {Locations.HC_STORMS_GROTTO_GOSSIP_STONE_BIG_FAIRY,
         function(bundle) return LogicHelpers.can_use(Items.SONG_OF_STORMS, bundle) end},
        {Locations.HC_STORMS_GROTTO_POT1, function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.HC_STORMS_GROTTO_POT2, function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.HC_STORMS_GROTTO_POT3, function(bundle) return LogicHelpers.can_break_pots(bundle) end},
        {Locations.HC_STORMS_GROTTO_POT4, function(bundle) return LogicHelpers.can_break_pots(bundle) end}
    })
    --Connections
   LogicHelpers.connect_regions(Regions.HC_STORMS_GROTTO_BEHIND_WALLS, world, {
        {Regions.HC_STORMS_GROTTO, function(bundle) return true end},
        {Regions.HC_STORMS_SKULLTULA, function(bundle) return LogicHelpers.hookshot_or_boomerang(bundle) end}
    })

    --Hyrule Castle Storms Skulltule
    --This is a deviation from the original SOH logic because of the union of locations
    --Locations
   LogicHelpers.add_locations(Regions.HC_STORMS_SKULLTULA, world, {
        {Locations.HC_GS_STORMS_GROTTO, function(bundle) return true end}
    })

    --Ganon's Castle Grounds
    --Events
    LogicHelpers.add_events(Regions.GANONS_CASTLE_GROUNDS, world, {
        {EventLocations.HC_OGC_RAINBOW_BRIDGE, LocalEvents.HC_OGC_RAINBOW_BRIDGE_BUILT,
         function(bundle) return LogicHelpers.can_build_rainbow_bridge(bundle) end}
    })
    --Locations
   LogicHelpers.add_locations(Regions.GANONS_CASTLE_GROUNDS, world, {
        {Locations.HC_OGC_GS, function(bundle) return LogicHelpers.can_jump_slash_except_hammer(bundle) or
         LogicHelpers.can_use_projectile(bundle) or
        (LogicHelpers.can_shield(bundle) and LogicHelpers.can_use(Items.MEGATON_HAMMER, bundle)) or
         LogicHelpers.can_use(Items.DINS_FIRE, bundle) end}
    })
    --Connections
   LogicHelpers.connect_regions(Regions.GANONS_CASTLE_GROUNDS, world, {
        {Regions.CASTLE_GROUNDS, function(bundle) return LogicHelpers.at_night(bundle) end},
        {Regions.OGC_GREAT_FAIRY_FOUNTAIN, function(bundle) return LogicHelpers.can_use(
            Items.GOLDEN_GAUNTLETS, bundle) and LogicHelpers.at_night(bundle) end},
        {Regions.GANONS_CASTLE_LEDGE, function(bundle) return LogicHelpers.has_item(
            LocalEvents.HC_OGC_RAINBOW_BRIDGE_BUILT, bundle) end}
    })

    --OGC Great Fairy Fountain
    --Locations
   LogicHelpers.add_locations(Regions.OGC_GREAT_FAIRY_FOUNTAIN, world, {
        {Locations.OGC_GREAT_FAIRY_REWARD,
         function(bundle) return LogicHelpers.can_use(Items.ZELDAS_LULLABY, bundle) end}
    })
    --Connections
   LogicHelpers.connect_regions(Regions.OGC_GREAT_FAIRY_FOUNTAIN, world, {
        {Regions.CASTLE_GROUNDS, function(bundle) return true end}
    })

    --Castle Grounds from Ganon's Castle
    --Connections
   LogicHelpers.connect_regions(Regions.CASTLE_GROUNDS_FROM_GANONS_CASTLE, world, {
        {Regions.HYRULE_CASTLE_GROUNDS, function(bundle) return LogicHelpers.is_child(bundle) end},
        {Regions.GANONS_CASTLE_LEDGE, function(bundle) return LogicHelpers.is_adult(bundle) end }
    })

    --Ganon's Castle Ledge
    --Connections
   LogicHelpers.connect_regions(Regions.GANONS_CASTLE_LEDGE, world, {
        {Regions.GANONS_CASTLE_GROUNDS, function(bundle) return LogicHelpers.has_item(
            LocalEvents.HC_OGC_RAINBOW_BRIDGE_BUILT, bundle)end},
        {Regions.GANONS_CASTLE_ENTRYWAY, function(bundle) return LogicHelpers.is_adult(bundle) end }
    })


        end

        return set_region_rules