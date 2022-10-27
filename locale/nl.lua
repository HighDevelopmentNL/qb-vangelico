local Translations = {
    error = {
        fingerprints = 'Je hebt een vingerafdruk op het glas achtergelaten',
        minimum_police = 'Minimaal %{value} politie nodig',
        wrong_weapon = 'Je wapen is niet sterk genoeg..',
        to_much = 'Je hebt te veel in je zak',
        already_looted = 'Deze locatie is al gechecked en geleegd',
        power_alreadyoff = 'De stroom is al uitgeschakeld',
        already_searched = 'De code is al gevonden',
        cancelled = 'Geannuleerd'
    },
    success = {},
    info = {
        progressbar = 'De vitrine kapot maken',
        progressbar_power = 'Stroom aan het overladen',
        progressbar_vaultsafe = 'Zoeken naar spullen',
        search_for_code = 'Searching for code'
    },
    general = {
        target_label = 'De vitrine kapot slaan',
        drawtextui_grab = '[E] Vitrine kapot slaan',
        drawtextui_broken = 'Vitrine is kapot',
        loot_text = 'Beroven',
        search_for_code = 'Zoeken naar code'
    }
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
