QBCore = exports['qb-core']:GetCoreObject()
local timeOut = false


QBCore.Functions.CreateCallback("qb-vangelico:server:get:config", function(source, cb)
    cb(Config)
end)

QBCore.Functions.CreateCallback("qb-vangelico:server:get:code", function(source, cb)
    cb(Config.Info['Code'])
end)

RegisterNetEvent('qb-vangelico:server:setPower', function()
    Config.Info["Power"] = true
    TriggerClientEvent('qb-vangelico:client:setStateGeneral', -1, 'Power', true)
    TriggerEvent('qb-doorlock:server:updateState', 'VengelicoPower', false, false, false, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        Config.Info['Code'] = math.random(1111,9999)
        -- print('Needs to be:', Config.Info['Code'])
        -- print('Vangelico KeyPad Reset.')
        Citizen.Wait((1000 * 60) * 60)
    end
end)

RegisterNetEvent('qb-vangelico:server:CodeEvent', function(safe)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local luck = math.random(1, 50)
    if luck <= 10 then
        local info = {
            label = "Vangelico Keypad: " ..Config.Info['Code']
        }
        Player.Functions.AddItem("stickynote", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stickynote"], "add")

        Config.Info["Searched"] = true
        TriggerClientEvent('qb-vangelico:client:setStateGeneral', -1, 'Searched', true)
     end
end)

RegisterNetEvent('qb-vangelico:server:VaultRewards', function(k, XH, YH, ZH)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local plrPed = GetPlayerPed(src)
    local plrCoords = GetEntityCoords(plrPed)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)
    local cheating = false
    local dist = #(plrCoords - vector3(XH, YH, ZH))
    if dist <= 2.0 then
        Config.Info['LootSafe'][k]['Open'] = true
        TriggerClientEvent('qb-vangelico:client:setVState', -1, 'Open', true, k)
        if otherchance == odd then
            local item = math.random(1, #Config.Info['VaultRewards'])
            local amount = math.random(Config.Info['VaultRewards'][item]["amount"]["min"], Config.Info['VaultRewards'][item]["amount"]["max"])
            if Player.Functions.AddItem(Config.Info['VaultRewards'][item]["item"], amount) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Info['VaultRewards'][item]["item"]], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
            end
        else
            local amount = math.random(2, 4)
            if Player.Functions.AddItem("10kgoldchain", amount) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["10kgoldchain"], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
            end
        end
    else
        cheating = true
    end

    if cheating then
        local license = Player.PlayerData.license
        if flags[license] then
            flags[license] = flags[license] + 1
        else
            flags[license] = 1
        end
        if flags[license] >= 3 then
            exploitBan("Getting flagged many times from exploiting the \"qb-vangelico:server:VaultReward\" event")
        else
            DropPlayer(src, "Exploiting")
        end
    end
end)

RegisterNetEvent('qb-vangelico:server:vitrineReward', function(k, XH, YH, ZH)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local plrPed = GetPlayerPed(src)
    local plrCoords = GetEntityCoords(plrPed)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)
    local cheating = false
    local dist = #(plrCoords - vector3(XH, YH, ZH))
    Config.Info['Loot'][k]['Open'] = true
    TriggerClientEvent('qb-vangelico:client:setState', -1, 'Open', true, k)
    if dist <= 2.0 then
        if otherchance == odd then
            local item = math.random(1, #Config.Info['Rewards'])
            local amount = math.random(Config.Info['Rewards'][item]["amount"]["min"], Config.Info['Rewards'][item]["amount"]["max"])
            if Player.Functions.AddItem(Config.Info['Rewards'][item]["item"], amount) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Info['Rewards'][item]["item"]], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
            end
        else
            local amount = math.random(2, 4)
            if Player.Functions.AddItem("10kgoldchain", amount) then
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["10kgoldchain"], 'add')
            else
                TriggerClientEvent('QBCore:Notify', src, Lang:t('error.to_much'), 'error')
            end
        end
    else
        cheating = true
    end

    if cheating then
        local license = Player.PlayerData.license
        if flags[license] then
            flags[license] = flags[license] + 1
        else
            flags[license] = 1
        end
        if flags[license] >= 3 then
            exploitBan("Getting flagged many times from exploiting the \"qb-vangelico:server:vitrineReward\" event")
        else
            DropPlayer(src, "Exploiting")
        end
    end
end)

RegisterNetEvent('qb-vangelico:server:setVitrineState', function(Type, State, Id)
    Config.Info['Loot'][Id][Type] = State
    TriggerClientEvent('qb-vangelico:client:setState', -1, Type, State, Id)  
end)

RegisterNetEvent('qb-vangelico:server:setVaultState', function(Type, State, Id)
    Config.Info['LootSafe'][Id][Type] = State
    TriggerClientEvent('qb-vangelico:client:setVState', -1, Type, State, Id)  
end)

RegisterNetEvent('qb-vangelico:server:setTimeout', function()
    if not timeOut then
        timeOut = true
        Config.Info["Started"] = true
        TriggerClientEvent('qb-vangelico:client:setStateGeneral', -1, 'Started', true)
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "jewellery", true)
        Citizen.CreateThread(function()
            Citizen.Wait(Config.ResetTime)
            Config.Info["Power"] = false
            Config.Info["Started"] = false
            Config.Info["Code"] = math.random(1111,9999)
            TriggerClientEvent('qb-vangelico:client:setStateGeneral', -1, 'Power', false)
            TriggerClientEvent('qb-vangelico:client:setStateGeneral', -1, 'Started', false)
            TriggerClientEvent('qb-vangelico:client:setNewPassword', -1, Config.Info["Code"])
            TriggerClientEvent('qb-vangelico:client:setAlertState', -1, false)
            TriggerEvent('qb-scoreboard:server:SetActivityBusy', "jewellery", false)
            for k, _ in pairs(Config.Info) do
                Config.Info['Loot'][k]["Open"] = false
                Config.Info['Loot'][k]["Busy"] = false
                TriggerClientEvent('qb-vangelico:client:setState', -1, 'Open', false, k)
                TriggerClientEvent('qb-vangelico:client:setState', -1, 'Busy', false, k)
            end
            TriggerEvent('qb-doorlock:server:updateState', 'FirstDoor', false, false, false, false)
            TriggerEvent('qb-doorlock:server:updateState', 'OfficeDoor', false, false, false, false)
            TriggerEvent('qb-doorlock:server:updateState', 'VengelicoPower', false, false, false, false)
            timeOut = false
        end)
    end
end)

QBCore.Commands.Add("resetvangelico", "Reset vangelico heist", {}, false, function(source, args)
    Config.Info["Power"] = false
    Config.Info["Started"] = false
    Config.Info["Code"] = math.random(1111,9999)
    TriggerClientEvent('qb-vangelico:client:setStateGeneral', -1, 'Power', false)
    TriggerClientEvent('qb-vangelico:client:setStateGeneral', -1, 'Started', false)
    TriggerClientEvent('qb-vangelico:client:setNewPassword', -1, Config.Info["Code"])
    TriggerClientEvent('qb-vangelico:client:setAlertState', -1, false)
    TriggerEvent('qb-scoreboard:server:SetActivityBusy', "jewellery", false)
    for k, _ in pairs(Config.Info['Loot']) do
        Config.Info['Loot'][k]["Open"] = false
        Config.Info['Loot'][k]["Busy"] = false
        TriggerClientEvent('qb-vangelico:client:setState', -1, 'Open', false, k)
        TriggerClientEvent('qb-vangelico:client:setState', -1, 'Busy', false, k)
    end
    for k, _ in pairs(Config.Info['LootSafe']) do
        Config.Info['LootSafe'][k]["Open"] = false
        Config.Info['LootSafe'][k]["Busy"] = false
        TriggerClientEvent('qb-vangelico:client:setVState', -1, 'Open', false, k)
        TriggerClientEvent('qb-vangelico:client:setVState', -1, 'Busy', false, k)
    end
    TriggerEvent('qb-doorlock:server:updateState', 'FirstDoor', false, false, false, false)
    TriggerEvent('qb-doorlock:server:updateState', 'OfficeDoor', false, false, false, false)
    TriggerEvent('qb-doorlock:server:updateState', 'VengelicoPower', false, false, false, false)
end, "admin")