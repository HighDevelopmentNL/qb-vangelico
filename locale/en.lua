local Translations = {
    error = {
        fingerprints = 'You\'ve left a fingerprint on the glass',
        minimum_police = 'Minimum of %{value} police needed',
        wrong_weapon = 'Your weapon is not strong enough..',
        to_much = 'You have to much in your pocket',
        already_looted = 'It is already looted',
        power_alreadyoff = 'The power has already been hit',
        already_searched = 'Code has already been found',
        cancelled = 'Cancelled'
    },
    success = {},
    info = {
        progressbar = 'Smashing the display case',
        progressbar_power = 'Messing with the power',
        progressbar_vaultsafe = 'Searching for loot',
        search_for_code = 'Searching for code'
    },
    general = {
        target_label = 'Smash the display case',
        drawtextui_grab = '[E] Smash the display case',
        drawtextui_broken = 'Display case is broken',
        loot_text = 'Loot',
        search_for_code = 'Search for code'
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
