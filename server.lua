-- QBCore Exports
local QBCore = exports['qb-core']:GetCoreObject()

local function OnStart(resource)
    if (GetCurrentResourceName() ~= resource) then
        return
    end
    print(resource .. ' started successfully')
end

-- Police Count Callback
local function PoliceCount(source, callback)
    local player_ids = QBCore.Functions.GetPlayers()
    local police_count = 0

    for i = 1, #player_ids do
        local player = QBCore.Functions.GetPlayer(player_ids[i])
        if player and player.PlayerData.job and player.PlayerData.job.name == 'police' and player.PlayerData.job.onduty then
            police_count = police_count + 1
        end
    end

    if police_count < Config.RequiredPolice then
        callback(false)
        TriggerClientEvent('QBCore:Notify', source, Config.NotEnoughCops, 'error')
        return
    end
    callback(true)
end

-- Remove Config Item
local function RemoveItem()
    local player = QBCore.Functions.GetPlayer(source)
    player.Functions.RemoveItem(Config.RequiredItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RequiredItem], "remove", 1)
end

-- Give Rewards
local function GiveRewards()
    local player = QBCore.Functions.GetPlayer(source)

    -- Give Cash
    do
        local chance = math.random(1,100)
        if chance <= Config.CashChance then
            local amount = math.random(Config.MinReward, Config.MaxReward)
            player.Functions.AddMoney('cash', amount)
            TriggerClientEvent('QBCore:Notify', source, "You grabbed $" .. amount .. " from the machine!", 'success')
        end
    end

    -- Give Common items
    do
        local chance = math.random(1,100)
        if chance <= Config.CommonItemsChance then
            local item = Config.CommonItems[math.random(1, #Config.CommonItems)]
            player.Functions.AddItem(item, Config.CommonItemAmount)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add",  Config.CommonItemAmount)
            TriggerClientEvent('QBCore:Notify', source, Config.CommonRewardText, 'success')
        end
    end

    -- Give Rare items
    do
        local chance = math.random(1,100)
        if chance <= Config.RareItemsChance then
            local item = Config.RareItems[math.random(1, #Config.RareItems)]
            player.Functions.AddItem(item, Config.RareItemAmount)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add",  Config.RareItemAmount)
            TriggerClientEvent('QBCore:Notify', source, "You found something special...", 'success')
        end
    end
end

-- Registration follows ----------------------------------------------------------------------------

-- Event Handler for Resource Start
AddEventHandler('onResourceStart', OnStart)

-- Callback for Police Count
QBCore.Functions.CreateCallback('mad-vendrob:server:PoliceCount', PoliceCount)

-- Remove Config Item Server Event
RegisterServerEvent('mad-vendrob:server:RemoveItem', RemoveItem)

-- Add Rewards Server Event
RegisterServerEvent('mad-vendrob:server:GiveRewards', GiveRewards)