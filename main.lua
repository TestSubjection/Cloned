
--- This is spaghetti code. This is my first attempt at proper coding. There is probably a comical amount of things wrong here. ---
--- Special thanks to the Discord Server, they were a huge help (as much as they made fun of me sometimes) ---
--- HUGE thanks to VanillaRemade and it's contributors, since most of this code is copied and frankensteined together based on what they made. ---
--- Finally, thank you for looking at this mod, it was a passion project that I'm really only doing for myself ---
--- That said, if you have any ideas, suggestions, or bugs, send them all to my post on the Balatro Discord or DM me directly (TestSubjection) ---

SMODS.Atlas({
    key = "modicon",
    path = "modicon.png", 
    px = 32,
    py = 32,
})

SMODS.Atlas({
    key = "tsinogat",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "tsinogat",
    loc_txt = { name = 'Tsinogat',
    text = { 'All played {C:attention}Aces{} give',
    '{C:mult}+10{} Mult when scored'} ,
    },
    pos = { x = 0, y = 0 },
    atlas = 'tsinogat',
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = { extra = { mult = 10} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult} }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end
}

SMODS.Atlas({
    key = "revar",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "revar",
    loc_txt = { name = 'Revar',
    text = { 'Gains {C:money}$10{} in',
    '{C:attention}sell value{} when a',
    '{C:attention}Blind{} is skipped'}
    },
    pos = { x = 3, y = 0 },
    atlas = 'revar',
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    cost = 6,
    config = { extra = { price = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}

SMODS.Atlas({
    key = "arewt",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "arewt",
    loc_txt = { name = 'Arewt',
    text = { 'This Joker gains',
    '{C:chips}+20{} Chips if played hand',
    'contains a {C:attention}Flush',
    '{C:inactive}(Currently {C:chips}+#1#{} Chips{C:inactive})'}
    },
    pos = { x = 0, y = 1 },
    atlas = 'arewt',
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    config = { extra = { chips = 0, chip_mod = 20, type = 'Flush' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.before and next(context.poker_hands[card.ability.extra.type]) and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
    end
end
}

SMODS.Atlas({
    key = "sarsg",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "sarsg",
    loc_txt = { name = 'Sarsg',
    text = { 'This Joker gains',
    '{C:mult}+3{} Mult if played hand',
    'contains a {C:attention}Flush',
    '{C:inactive}(Currently {C:mult}+#1#{} Mult{C:inactive})'}
    },
    pos = { x = 1, y = 1 },
    atlas = 'sarsg',
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
    config = { extra = { mult = 0, mult_gain = 3, type = 'Flush' } },
    loc_vars = function(self, info_queue, card)
        local extra = card.ability and card.ability.extra or {}
        return { vars = { extra.mult or 0, extra.mult_gain or 0, localize(extra.type or 'Flush', 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        card.ability = card.ability or {}
        card.ability.extra = card.ability.extra or {}
        card.ability.extra.mult = card.ability.extra.mult or 0
        card.ability.extra.mult_gain = card.ability.extra.mult_gain or 0
        card.ability.extra.type = card.ability.extra.type or 'Flush'

        if context.before and next(context.poker_hands[card.ability.extra.type]) and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end

        if context.joker_main and not next(context.poker_hands[card.ability.extra.type]) then
            local last_mult = card.ability.extra.mult or 0
            card.ability.extra.mult = 0
            if last_mult > 0 then
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Atlas({
    key = "crior",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "crior",
    loc_txt = { name = 'Crior Unpot',
    text = { 'All played Kings become',
    '{C:attention}Glass Cards{} when scored'} ,
    },
    pos = { x = 1, y = 0 },
    atlas = 'crior',
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 13 then
                    faces = faces + 1
                    scored_card:set_ability('m_glass', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = 'Glass.',
                    colour = G.C.PURPLE
                }
            end
        end
    end
}

SMODS.Atlas({
    key = "tort",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "tort",
    loc_txt = { name = 'Tort',
    text = { 'After the {C:attention}first hand{}',
    'of a round is scored,',
    'this Joker {C:red}destroys',
    '{C:red}every playing card{}',
    '{C:red}on screen{} then gives',
    '{C:money}$3{} per destroyed card' } ,
    },
    pos = { x = 2, y = 0 },
    atlas = 'tort',
    rarity = 3,
    blueprint_compat = false,
    cost = 7,
    config = { extra = { dollars = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.destroy_card and not context.blueprint then
            if #context.scoring_hand and G.GAME.current_round.hands_played == 0 then
                return {
                    dollars = card.ability.extra.dollars,
                    remove = true
                }
            end
        end
    end
}

SMODS.Atlas({
    key = "korc",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker {
    key = "korc",
    loc_txt = { name = 'Korc',
    text = { 'First played {C:attention}Stone',
    'card gives {X:mult,C:white}X3{} Mult',
    'when scored'} ,
    },
    pos = { x = 2, y = 1 },
    atlas = 'korc',
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    config = { extra = { xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
            local is_first_stone = false
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_stone') then
                    is_first_stone = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first_stone then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Atlas({
    key = "esideas",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "esideas",
    loc_txt = { name = 'Esideas',
    text = { 'When {C:attention}Blind{} is selected,',
    '{C:attention}half the Blind size',
    '{C:blue}-2{} hands each round'}
    },
    pos = { x = 5, y = 0 },
    atlas = 'esideas',
    rarity = 3,
    blueprint_compat = false,
    cost = 8,
    config = { extra = { h_plays = -2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { -card.ability.extra.h_plays } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.h_plays
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.h_plays
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.blind.chips = G.GAME.blind.chips / 2
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
}

SMODS.Atlas({
    key = "snad",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker {
    key = "snad",
    loc_txt = { name = 'Snad',
    text = { 'Sets all listed',
    'probabilities to 0',
    '{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}0 in 3{C:inactive})'}
    },
    pos = { x = 4, y = 2 },
    atlas = 'snad',
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 2,
    cost = 6,
   calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = 0
            }
        end
    end
}

SMODS.Atlas({
    key = "senel",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker {
    key = "senel",
    loc_txt = { name = 'Senel',
    text = { '{X:mult,C:white}X5{} Mult',
    'if this Joker is',
    '{C:dark_edition}Negative'}
    },
    pos = { x = 2, y = 2 },
    atlas = 'senel',
    blueprint_compat = true,
    rarity = 2,
    cost = 4,
    config = { extra = { xmult = 5 } },
    calculate = function(self, card, context)
        if context.joker_main and card.edition and card.edition.key == "e_negative" then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Atlas({
    key = "aaron",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker {
    key = "aaron",
    loc_txt = { name = 'Aaron',
    text = { '{C:green}#1# in 4{} chance to',
    'create a {C:attention}Double Tag',
    'when {C:attention}Blind{} is selected'}
    },
    pos = { x = 1, y = 2 },
    atlas = 'aaron',
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_double', set = 'Tag' }
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'clo_aaron')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and SMODS.pseudorandom_probability(card, 'clo_aaron', 1, card.ability.extra.odds) then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_double'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}

SMODS.Atlas({
    key = "baronscientist",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker {
    key = "baronscientist",
    loc_txt = { name = 'Baron (The scientist, not the other one)',
    text = { '{C:green}#1# in 8{} chance to',
    'create a {C:attention}Cloned Tag',
    'when {C:attention}Blind{} is selected'}
    },
    pos = { x = 0, y = 2 },
    atlas = 'baronscientist',
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    config = { extra = { odds = 8 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set = "Tag", key = 'tag_clo_cloner' }
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'clo_baronscientist')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and SMODS.pseudorandom_probability(card, 'clo_baronscientist', 1, card.ability.extra.odds) then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_clo_cloner'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}

SMODS.Atlas({
    key = "drolldolly",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker {
    key = "drolldolly",
    loc_txt = { name = 'Droll Dolly',
    text = { 'If played hand',
'contains {C:attention}1 card{}, gain a',
'{C:tarot}Death{} Card',
'{C:inactive}(Must have room)'}
    },
    pos = { x = 3, y = 1 },
    atlas = 'drolldolly',
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
        if context.before and #context.scoring_hand == 1 and not context.blueprint then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card({key = 'c_death'})
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = 'Death!',
                    colour = G.C.SECONDARY_SET.Spectral,
                    remove = true
                }
            end
            return {
                remove = true
            }
        end
    end
}


SMODS.Atlas({
    key = "testsub",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker {
    key = "testsub",
    loc_txt = { name = 'Test Subjoker',
    text = { '{C:attention}+1{} Joker Slot',
    '{C:inactive}Why am I here?'}
    },
    pos = { x = 5, y = 1 },
    atlas = 'testsub',
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    rarity = 3,
    cost = 1, 
config = {
		extra = {
			slots = 1,
		},
		immutable = {
			max_slots = 100,
		},
	},
	loc_vars = function(self, info_queue, center)
		return { vars = { number_format(center.ability.extra.slots) } }
	end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.slots > card.ability.immutable.max_slots then
            card.ability.extra.slots = card.ability.immutable.max_slots
        end
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
    end,
}





SMODS.Atlas({
    key = "kard",
    path = 'jokers.png',
    px = 71,
    py = 95,
})

SMODS.Joker{
    key = "kard",
    loc_txt = { 
        name = 'Kard',
        text = { 'When a {C:attention}card{} is sold,',
        'this {C:attention}Joker{} gains {X:mult,C:white}X Mult',
        'equal to {C:attention}half{} the',
        '{C:attention}sold card\'s{} sell value',
        '{C:inactive}(Currently {X:mult,C:white}X#1#{}{C:inactive})'}
    },
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    atlas = 'kard',
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
    config = { extra = { xmult_gain = 1, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_card then
            local sliced_card = context.sliced_card or context.card or context.selling_card
            if sliced_card then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra = card.ability.extra or {}
                        card.ability.extra.xmult = (card.ability.extra.xmult or card.ability.extra.xmult_gain or 0)
                            + (sliced_card.sell_cost or 0) * 0.5
                        card:juice_up(0.8, 0.8)
                        if sliced_card.start_dissolve then
                            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        end
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult + 1 } },
                    colour = G.C.UI.TEXT_DARK,
                    no_juice = true
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Atlas({
    key = "cloner",
    path = 'tags.png',
    px = 32,
    py = 32,
})

SMODS.Tag {
    key = "cloner",
    atlas = 'cloner',
    pos = { x = 0, y = 0 },
    loc_txt = { 
        name = 'Cloned Tag',
        text = { 'Duplicates a random {C:attention}Joker',
        'between shops and next blind',
    '{C:inactive}(Must have room)'}
    },
    min_ante = 2,
    config = { spawn_jokers = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.spawn_jokers } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                local jokers = G.jokers.cards
                for _ = 1, tag.config.spawn_jokers do
                    if #jokers > 0 then
                        if #G.jokers.cards < G.jokers.config.card_limit then
                            local chosen_joker = pseudorandom_element(jokers, 'clo_cloner')
                            local copied_joker = copy_card(chosen_joker, nil, nil, nil,
                                chosen_joker.edition and chosen_joker.edition.negative)
                            copied_joker:add_to_deck()
                            G.jokers:emplace(copied_joker)
                        end
                    end
                end
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

SMODS.Atlas({
    key = "tagsub",
    path = 'tags.png',
    px = 32,
    py = 32,
})

SMODS.Tag {
    key = "tagsub",
    atlas = 'tagsub',
    pos = { x = 1, y = 0 },
    loc_txt = { 
        name = 'TagSubjection',
        text = { 'Creates {C:attention}TestSubjoker' }
    },
    min_ante = 1,
    config = { spawn_jokers = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.spawn_jokers } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_clo_testsub")
                card:add_to_deck()
                G.jokers:emplace(card)
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

}

