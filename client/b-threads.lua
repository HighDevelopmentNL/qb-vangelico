
CreateThread(function()
    if not zonecreated then
        zonecreated = true
		VengelicoHeist = BoxZone:Create(vector3(-453.0622, -71.37997, 41.285247), 35.0, 35.0, {
			name="VengelicoHeist",
			debugPoly = false,
            heading = 40,
            minZ = 39.0,
            maxZ = 50.0,
		})
		VengelicoHeist:onPlayerInOut(function(isPointInside)
			InsideVengelico = isPointInside
			    if isPointInside then
                    InsideMain = true
                        exports[Config.Triggers['Target']]:AddTargetModel("k4mb1_vjewel_keypad", {
                            options = {
                                {
                                    event = "qb-vangelico:client:hacksystem",
                                    icon = "fas fa-hands",
                                    label = "Hack Panel",
                                    item = 'stickynote',
                                    job = "all",
                                    canInteract = function()
                                            if exports[Config.Triggers['Resource']]:InVengelico() and exports[Config.Triggers['Resource']]:PowerOff() and exports[Config.Triggers['Resource']]:Started() then
                                            return true
                                        end
                                    end,
                                },
                            },
                            distance = 2.5,
                        })
                        boxshown = true
                        exports[Config.Triggers['Target']]:AddBoxZone("VengelicoElectric", vector3(-448.5977, -51.14618, 44.515605), 0.8, 1.0, {
                            name = "VengelicoElectric",
                            heading = 40,
                            debugPoly = false,
                            minZ = 43.01,
                            maxZ = 44.915605,
                        }, {
                            options = {
                                {
                                    type = "client",
                                    event = "qb-vangelico:client:disablepower",
                                    icon = "fa fa-clipboard",
                                    label = "Shut Down Power",
                                    canInteract = function()
                                        if exports[Config.Triggers['Resource']]:InVengelico() and not exports[Config.Triggers['Resource']]:PowerOff() then
                                            return true
                                        end
                                    end,
                                }
                            },
                            distance = 1.5
                        })
                else
                    InsideMain = false
                    boxshown = false
                end 
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if InsideVengelico then
            if not nozonesyet then
                nozonesyet = true
                for k, v in pairs(Config.Info['Loot']) do
                    exports[Config.Triggers['Target']]:AddBoxZone("hdven"..k,  vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']), v['Coords']['Height'], v['Coords']['Width'], {
                        name = "hdven"..k,
                        heading = v['Coords']['H'],
                        debugPoly = false,
                        minZ = v['Coords']['Z'] - 1,
                        maxZ = v['Coords']['Z'] + 0.4,
                    }, {
                        options = {
                            {
                                type = "client",
                                event = "qb-vangelico:client:use",
                                icon = "fa fa-hand",
                                label = Lang:t("general.loot_text"),
                                selectie = k,
                                naam = v['Name'],
                                canInteract = function()
                                    if exports[Config.Triggers['Resource']]:InVengelico() and exports[Config.Triggers['Resource']]:PowerOff() then
                                        return true
                                    end
                                end,
                            }
                        },
                        distance = 1.5
                    })
                end
                for k, v in pairs(Config.Info['LootSafe']) do
                    exports[Config.Triggers['Target']]:AddBoxZone("lootsafe"..k,  vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']), v['Height'], v['Width'], {
                        name = "lootsafe"..k,
                        heading = 40,
                        debugPoly = false,
                        minZ = v['Coords']['Z'] - 1,
                        maxZ = v['Coords']['Z'] + 0.4,
                    }, {
                        options = {
                            {
                                type = "client",
                                event = "qb-vangelico:client:use",
                                icon = "fa fa-hand",
                                label = Lang:t("general.loot_text"),
                                selectie = k,
                                naam = v['Name'],
                                canInteract = function()
                                    if exports[Config.Triggers['Resource']]:InVengelico() and exports[Config.Triggers['Resource']]:PowerOff() then
                                        return true
                                    end
                                end,
                            }
                        },
                        distance = 1.5
                    })
                end
            end
            
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        if InsideVengelico then
            if not seachlocations then
                seachlocations = true
                for k, v in pairs(Config.Info['SearchLocations']) do
                    exports[Config.Triggers['Target']]:AddBoxZone("search"..k,  vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']), 1.2, 1.6, {
                        name = "search"..k,
                        heading = v['Coords']['H'],
                        debugPoly = false,
                        minZ = v['Coords']['Z'] - 1,
                        maxZ = v['Coords']['Z'] + 0.8,
                    }, {
                        options = {
                            {
                                type = "client",
                                event = "qb-vangelico:client:searchcode",
                                icon = "fa fa-clipboard",
                                label = Lang:t("general.search_for_code"),
                                canInteract = function()
                                    if exports[Config.Triggers['Resource']]:InVengelico() and exports[Config.Triggers['Resource']]:PowerOff() and not exports[Config.Triggers['Resource']]:Searched() then
                                        return true
                                    end
                                end,
                            }
                        },
                        distance = 1.5
                    })
                end
            end
            
        end
    end
end)