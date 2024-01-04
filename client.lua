-- QBCore Exports / Variables
local QBCore = exports['qb-core']:GetCoreObject()
local NextRobberyMinTime = 0

-- Function to Load Animation Dictionary
local function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

-- Notify wrapper
local function Notify(text, level)
    exports['ps-ui']:Notify(text, level)
end

-- VendingMachineRobbery wrapper
local function VendingMachineRobbery()
    exports['ps-dispatch']:VendingMachineRobbery()
end

-- Register Target Models for Vending Objects
exports['qb-target']:AddTargetModel(
    Config.VendingObjects,
    {
        options = {
            {
                type = 'client',
                event = 'madcap-vendrob:client:RobObject',
                icon = Config.ObjectIcon,
                label = Config.ObjectLabel,
                item = Config.RequiredItem,
            },
        },
        distance = 2.5,
    })

-- Define RobObject handler
local function RobObject()

    -- Can't do the heist if it's too soon since the last one, or if we don't have a lock pick
    if GetGameTimer() < NextRobberyMinTime or not QBCore.Functions.HasItem(Config.RequiredItem) then
        Notify(Config.HeistCooldownNotify, 'error')
        return
    end

    local ped = PlayerPedId() -- Used by the function closures below

    function EndRobbery()
        NextRobberyMinTime = GetGameTimer() + Config.HeistCooldown
        StopAnimTask(ped, 'missheistfbi3b_ig7', 'lift_fibagent_loop', 1.0)
        TriggerServerEvent('mad-vendrob:server:GiveRewards')
    end

    function EndCircle(success)
        StopAnimTask(ped, 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds', 1.0)
        if not success then
            Notify(Config.RobberyFail, 'error')
            TriggerServerEvent('mad-vendrob:server:RemoveItem')
            ClearPedTasks(ped)
            return
        end

        local luck = math.random(1,100)
        if luck <= Config.PoliceAlert then
            VendingMachineRobbery()
        end

        Notify(Config.RobberySuccess, 'success')

        LoadAnimDict('missheistfbi3b_ig7')
        TaskPlayAnim(ped, 'missheistfbi3b_ig7', 'lift_fibagent_loop', 8.0, 1.0, -1, 49, 0, 0, 0, 0)

        QBCore.Functions.Progressbar(
            'robbing_machine',
            Config.ProgressBarText,
            Config.ProgressBarSpeed,
            false,
            true,
            {
                disableMovement     = true,
                disableCarMovement  = true,
                disableMouse        = false,
                disableCombat       = true,
            },
            {},
            {},
            function() end,
            EndRobbery)
    end

    function BeginCircle(success)
        if not success then
            return
        end
        for i = 1, #Config.VendingObjects do
            local object = GetClosestObjectOfType(GetEntityCoords(ped), 2.5, GetHashKey(Config.VendingObjects[i]), false, false, false)
            TaskTurnPedToFaceEntity(ped, object, -1)
        end
        LoadAnimDict('veh@break_in@0h@p_m_one@')
        TaskPlayAnim(ped, 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        Notify(Config.AttemptRobbery, 'warning')
        exports['ps-ui']:Circle(EndCircle, Config.MinigameNumberofCircles, Config.MinigameMS) -- TODO wrap Circle function
    end
    QBCore.Functions.TriggerCallback('mad-vendrob:server:PoliceCount', BeginCircle)
end

-- Connect RobObject function to client event
RegisterNetEvent('madcap-vendrob:client:RobObject', RobObject)