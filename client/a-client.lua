LoggedIn, InsideMain, zonecreated, boxshown, nozonesyet, seachlocations = false, false, false, false, false, false

QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Citizen.SetTimeout(1250, function()
        QBCore.Functions.TriggerCallback('qb-vangelico:server:get:config', function(ConfigData)
            Config = ConfigData
        end)
        Citizen.Wait(350)
        LoggedIn = true
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    LoggedIn = false
end)

-- Code

RegisterNetEvent('qb-vangelico:client:hacksystem')
AddEventHandler('qb-vangelico:client:hacksystem', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = "open"})
end)


RegisterNetEvent("qb-vangelico:client:searchcode")
AddEventHandler("qb-vangelico:client:searchcode", function()
    if not Config.Info['Searched'] then
        QBCore.Functions.TriggerCallback('qb-jewellery:server:getCops', function(cops)
            if cops >= Config.CopsNeeded then
                local animDict = "anim@gangops@facility@servers@"
                local anim = "hotwire"
                QBCore.Functions.Progressbar("disable_power", Lang:t('info.seach_for_code'), math.random(3000, 6000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@gangops@facility@servers@",
                    anim = "hotwire",
                    flags = 16,
                }, {}, {}, function() -- Done
                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                    TriggerServerEvent('qb-vangelico:server:CodeEvent')
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                    QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                end)
            else
                QBCore.Functions.Notify(Lang:t('error.minimum_police', {value = Config.RequiredCops}), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t('info.already_searched'), 'error')
    end
end)


RegisterNetEvent("qb-vangelico:client:disablepower")
AddEventHandler("qb-vangelico:client:disablepower", function()
    QBCore.Functions.TriggerCallback('qb-jewellery:server:getCops', function(cops)
        if cops >= Config.CopsNeeded then
            if not Config.Info['Searched'] then
                local animDict = "anim@gangops@facility@servers@"
                local anim = "hotwire"
                QBCore.Functions.Progressbar("work_electric", Lang:t("info.progressbar_power"), math.random(5000, 12000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@gangops@facility@servers@",
                    anim = "hotwire",
                    flags = 16,
                }, {}, {}, function() -- Done
                TriggerServerEvent('qb-vangelico:server:setPower')
                TriggerServerEvent('qb-vangelico:server:setTimeout')
                end, function() -- Cancel
                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                    QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                end)
            else
                QBCore.Functions.Notify(Lang:t('error.power_alreadyoff'), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('error.minimum_police', {value = Config.RequiredCops}), 'error')
        end
    end)
end)

-- NUI Callbacks

RegisterNUICallback('PinpadClose', function(data)
    SetNuiFocus(false, false)
end)

RegisterNUICallback('ErrorMessage', function(data)
    QBCore.Functions.Notify(data.message, 'error')
end)

RegisterNUICallback('EnterPincode', function(data)
  QBCore.Functions.TriggerCallback('qb-vangelico:server:get:code', function(Code)
      if tonumber(data.pin) ~= nil then
          if tonumber(data.pin) == Code then
            TriggerServerEvent('qb-doorlock:server:updateState', 'VaultDoor', false, false, false, true)
          else
            PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
          end
      end
  end)  
end)

RegisterNUICallback('Click', function(data)
    PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
end)

RegisterNUICallback('ClickFail', function(data)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
end)

RegisterNetEvent("qb-vangelico:client:use")
AddEventHandler("qb-vangelico:client:use", function(data)
    if data.naam == "Vitrine" then
        RobVitrine(data.selectie)
    elseif data.naam == "Vault" then
        RobVault(data.selectie)
    end
end)

-- Functions
function RobVault(Id)
    QBCore.Functions.TriggerCallback('qb-jewellery:server:getCops', function(cops)
        if cops >= Config.CopsNeeded then
            if not Config.Info['LootSafe'][Id]['Open'] then
                if not firstAlarm then
                    TriggerServerEvent('police:server:policeAlert', 'Suspicious Activity')
                    firstAlarm = true
                end
                local animDict = "anim@gangops@facility@servers@"
                local anim = "hotwire"
                local ped = PlayerPedId()
                local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
                TriggerServerEvent('qb-vangelico:server:setVaultState', "Busy", true, Id)
                QBCore.Functions.Progressbar("rob_vaultloot", Lang:t("info.progressbar_vaultsafe"), math.random(5000, 10000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@gangops@facility@servers@",
                    anim = "hotwire",
                    flags = 16,
                }, {}, {}, function() -- Done
                    TriggerServerEvent('qb-vangelico:server:VaultRewards', Id, plyCoords.x, plyCoords.y, plyCoords.z)
                end, function() -- Cancel
                    TriggerServerEvent('qb-vangelico:server:setVaultState', "Busy", false, Id)
                    StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                    QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.already_looted"), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('error.minimum_police', {value = Config.RequiredCops}), 'error')
        end
    end)
end

function RobVitrine(Id)
    QBCore.Functions.TriggerCallback('qb-jewellery:server:getCops', function(cops)
        if cops >= Config.CopsNeeded then
            if not Config.Info['Loot'][Id]['Open'] then
                if not firstAlarm then
                    TriggerServerEvent('police:server:policeAlert', 'Suspicious Activity')
                    firstAlarm = true
                end
                local animDict = "missheist_jewel"
                local animName = "smash_case"
                local ped = PlayerPedId()
                local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
                smashing = true
                QBCore.Functions.Progressbar("smash_vitrine", Lang:t('info.progressbar'), math.random(6000, 9000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('qb-vangelico:server:vitrineReward', Id, plyCoords.x, plyCoords.y, plyCoords.z)
                    TriggerServerEvent('police:server:policeAlert', 'Robbery in progress')
                    smashing = false
                    TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
                end, function() -- Cancel
                    TriggerServerEvent('qb-vangelico:server:setVitrineState', "Busy", false, Id)
                    smashing = false
                    TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
                end)
                TriggerServerEvent('qb-vangelico:server:setVitrineState', "Busy", true, Id)

                CreateThread(function()
                    while smashing do
                        loadAnimDict(animDict)
                        TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
                        Wait(500)
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "breaking_vitrine_glass", 0.25)
                        loadParticle()
                        StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                        Wait(2500)
                    end
                end)
            else
                QBCore.Functions.Notify(Lang:t("error.already_looted"), 'error')
            end
        else
            QBCore.Functions.Notify(Lang:t('error.minimum_police', {value = Config.RequiredCops}), 'error')
        end
    end)
end

function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(3)
    end
end


RegisterNetEvent('qb-vangelico:client:setState', function(Type, State, Id)
    Config.Info['Loot'][Id][Type] = State
end)

RegisterNetEvent('qb-vangelico:client:setVState', function(Type, State, Id)
    Config.Info['LootSafe'][Id][Type] = State
end)

RegisterNetEvent('qb-vangelico:client:setStateGeneral', function(stateType, state)
    Config.Info[stateType] = state
end)

RegisterNetEvent('qb-vangelico:client:setNewPassword', function(newPass)
    Config.Info["Code"] = newPass
end)

-- Exports
exports('InVengelico', function()
    return InsideMain
end)

exports('PowerOff', function()
    return Config.Info['Power']
end)

exports('Started', function()
    return Config.Info['Started']
end)

exports('Searched', function()
    return Config.Info['Searched']
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then

    end
end)