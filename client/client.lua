-- ESX
local ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


local searched = {}
local timer = {}
local canSearch = true
local aircons = {827943275, 605277920, 1426534598, 1413477803, 1195939145, 1369811908, 1131941737, 1948414141, 1709954128, 1366469466, 1709954128}
local parkingmeter = {2108567945, -1940238623}
local payphones = {1281992692,1158960338}
local LootBin = {1437508529}

-- qtarget
exports['qtarget']:AddTargetModel(aircons, {
    options = {
        {
            event = 'supreme_aircon:SearchAircon',
            icon = 'fas fa-layer-group',
            label = 'Search aircon'
        },
    },
    job = {'all'},
    distance = 1.5
})

exports['qtarget']:AddTargetModel(parkingmeter, {
    options = {
        {
            event = 'supreme_aircon:RobMeter',
            icon = 'fas fa-layer-group',
            label = 'Rob Parking Meter'
        },
    },
    job = {'all'},
    distance = 1.5
})

exports['qtarget']:AddTargetModel(payphones, {
    options = {
        {
            event = 'supreme_aircon:RobPayPhone',
            icon = 'fas fa-layer-group',
            label = 'Rob Pay Phone'
        },
    },
    job = {'all'},
    distance = 1.5
})

exports['qtarget']:AddTargetModel(LootBin, {
    options = {
        {
            event = 'supreme_aircon:PickFruit',
            icon = 'fas fa-layer-group',
            label = 'Loot Bin'
        },
    },
    job = {'all'},
    distance = 1.5
})

-- Callback qtarget
RegisterNetEvent('supreme_aircon:SearchAircon')
AddEventHandler('supreme_aircon:SearchAircon', function()
    local pos = GetEntityCoords(PlayerPedId())

    if not canSearch then
        return
    end

    for i = 1, #aircons do
        local aircon = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, aircons[i], false, false, false)

        if aircon ~= 0 then

            if searched[aircon] then
                exports['mythic_notify']:SendAlert('error', 'This aircon has already been searched')
            else 
                exports['mythic_notify']:SendAlert('inform', 'You begin to search the aircon')
                StartSearching(aircon)
                searched[aircon] = true
            end

            break -- We have already found the aircon, so we stop the loop to not waste resources
        end
    end
end)

-- Callback parking meter qtarget
RegisterNetEvent('supreme_aircon:RobMeter')
AddEventHandler('supreme_aircon:RobMeter', function()
    local pos = GetEntityCoords(PlayerPedId())

    if not canSearch then
        return
    end

    for i = 1, #parkingmeter do
        local parkingmeter = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, parkingmeter[i], false, false, false)

        if parkingmeter ~= 0 then

            if searched[parkingmeter] then
                exports['mythic_notify']:SendAlert('error', 'This parking meter has already been robbed')
            else 
                exports['mythic_notify']:SendAlert('inform', 'You begin to rob the parking meter')
                StartSearching2(parkingmeter)
                searched[parkingmeter] = true
            end

            break -- We have already found the aircon, so we stop the loop to not waste resources
        end
    end
end)

-- Callback parking meter qtarget
RegisterNetEvent('supreme_aircon:RobPayPhone')
AddEventHandler('supreme_aircon:RobPayPhone', function()
    local pos = GetEntityCoords(PlayerPedId())

    if not canSearch then
        return
    end

    for i = 1, #payphones do
        local payphones = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, payphones[i], false, false, false)

        if payphones ~= 0 then

            if searched[payphones] then
                exports['mythic_notify']:SendAlert('error', 'This pay phone has already been robbed')
            else 
                exports['mythic_notify']:SendAlert('inform', 'You begin to rob the pay phone')
                StartSearching3(payphones)
                searched[payphones] = true
            end

            break -- We have already found the aircon, so we stop the loop to not waste resources
        end
    end
end)

-- Callback parking meter qtarget
RegisterNetEvent('supreme_aircon:PickFruit')
AddEventHandler('supreme_aircon:PickFruit', function()
    local pos = GetEntityCoords(PlayerPedId())

    if not canSearch then
        return
    end

    for i = 1, #LootBin do
        local LootBin = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, LootBin[i], false, false, false)

        if LootBin ~= 0 then

            if searched[LootBin] then
                exports['mythic_notify']:SendAlert('error', 'This bin has already been looted')
            else 
                exports['mythic_notify']:SendAlert('inform', 'You begin to search the bin')
                StartSearching4(LootBin)
                searched[LootBin] = true
            end

            break -- We have already found the aircon, so we stop the loop to not waste resources
        end
    end
end)

function StartSearching(aircon)
    canSearch = false
    local ped = PlayerPedId()

    --if not HasAnimDictLoaded("amb@prop_human_bum_bin@base") then
    --    RequestAnimDict(animDict)
    --    while not HasAnimDictLoaded(animDict) do
    --        Citizen.Wait(0)
    --    end
    --end

TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
exports["unwind-taskbar"]:taskBar(10000, 'Searching Aircon..')
--exports.rprogress:Start('Searching Aircon...', 10000)
    Wait(0)
    if not DoesEntityExist(ped) then
        ped = PlayerPedId()
    end
    ClearPedTasks(ped)
    ESX.TriggerServerCallback('supreme_aircon:PoliceOnline', function(policeonline)
		if policeonline then 
            TriggerServerEvent("supreme_aircon:GiveReward")
            TriggerEvent("supreme_aircon:PoliceNotify")
		else
			TriggerServerEvent('supreme_aircon:GiveReward2')
		end
	end)
   -- TriggerEvent("supreme_aircon:PoliceNotify")
    timer[aircon] = 0
    canSearch = true
    DeleteObject(entity)
end

function StartSearching2(parkingmeter)
    canSearch = false
    local ped = PlayerPedId()

    --if not HasAnimDictLoaded("amb@prop_human_bum_bin@base") then
    --    RequestAnimDict(animDict)
    --    while not HasAnimDictLoaded(animDict) do
    --        Citizen.Wait(0)
    --    end
    --end

--[[TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
exports["unwind-taskbar"]:taskBar(10000, 'Robbing Parking Meter..')
--exports.rprogress:Start('Searching Aircon...', 10000)
    Wait(0)
    if not DoesEntityExist(ped) then
        ped = PlayerPedId()
    end
    ClearPedTasks(ped)
    ESX.TriggerServerCallback('supreme_aircon:PoliceOnline', function(policeonline)
		if policeonline then 
            TriggerServerEvent("supreme_aircon:GiveReward")
            TriggerEvent("supreme_aircon:PoliceNotify")
		else
			TriggerServerEvent('supreme_aircon:GiveReward2')
		end
	end)
   -- TriggerEvent("supreme_aircon:PoliceNotify")
    timer[parkingmeter] = 0
    canSearch = true
    DeleteObject(entity)]]
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Stealing cash from parking meter",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
        animation = {
          animDict = "veh@break_in@0h@p_m_one@",
          anim = "low_force_entry_ds",
        },
        prop = {
          model = "prop_paper_bag_small",
        }
       }, 
        function(status)
              ClearPedTasks(GetPlayerPed(-1))
              ESX.TriggerServerCallback('supreme_aircon:PoliceOnline', function(policeonline)
                if policeonline then 
                    TriggerServerEvent("supreme_aircon:GiveMeterReward")
                    TriggerEvent("supreme_aircon:PoliceNotify2")
                else
                    TriggerServerEvent('supreme_aircon:GiveMeterReward2')
                end
            end)
           -- TriggerEvent("supreme_aircon:PoliceNotify")
            timer[parkingmeter] = 0
            canSearch = true
            DeleteObject(entity)
            FreezeEntityPosition(PlayerPedId(), false)
      end)
end

function StartSearching3(payphones)
    canSearch = false
    local ped = PlayerPedId()

    --if not HasAnimDictLoaded("amb@prop_human_bum_bin@base") then
    --    RequestAnimDict(animDict)
    --    while not HasAnimDictLoaded(animDict) do
    --        Citizen.Wait(0)
    --    end
    --end

--[[TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
exports["unwind-taskbar"]:taskBar(10000, 'Robbing Parking Meter..')
--exports.rprogress:Start('Searching Aircon...', 10000)
    Wait(0)
    if not DoesEntityExist(ped) then
        ped = PlayerPedId()
    end
    ClearPedTasks(ped)
    ESX.TriggerServerCallback('supreme_aircon:PoliceOnline', function(policeonline)
		if policeonline then 
            TriggerServerEvent("supreme_aircon:GiveReward")
            TriggerEvent("supreme_aircon:PoliceNotify")
		else
			TriggerServerEvent('supreme_aircon:GiveReward2')
		end
	end)
   -- TriggerEvent("supreme_aircon:PoliceNotify")
    timer[parkingmeter] = 0
    canSearch = true
    DeleteObject(entity)]]
    FreezeEntityPosition(PlayerPedId(), true)
    ExecuteCommand('e weld')
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Stealing cash from pay phone",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
       }, 
        function(status)
              ClearPedTasks(GetPlayerPed(-1))
              ESX.TriggerServerCallback('supreme_aircon:PoliceOnline', function(policeonline)
                if policeonline then 
                    TriggerServerEvent("supreme_aircon:GiveMeterReward")
                    TriggerEvent("supreme_aircon:PoliceNotify3")
                else
                    TriggerServerEvent('supreme_aircon:GiveMeterReward2')
                end
            end)
           -- TriggerEvent("supreme_aircon:PoliceNotify")
            timer[payphones] = 0
            canSearch = true
            DeleteObject(entity)
            FreezeEntityPosition(PlayerPedId(), false)
            ExecuteCommand('e c')
      end)
end

function StartSearching4(LootBin)
    canSearch = false
    local ped = PlayerPedId()

    --if not HasAnimDictLoaded("amb@prop_human_bum_bin@base") then
    --    RequestAnimDict(animDict)
    --    while not HasAnimDictLoaded(animDict) do
    --        Citizen.Wait(0)
    --    end
    --end

--[[TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
exports["unwind-taskbar"]:taskBar(10000, 'Robbing Parking Meter..')
--exports.rprogress:Start('Searching Aircon...', 10000)
    Wait(0)
    if not DoesEntityExist(ped) then
        ped = PlayerPedId()
    end
    ClearPedTasks(ped)
    ESX.TriggerServerCallback('supreme_aircon:PoliceOnline', function(policeonline)
		if policeonline then 
            TriggerServerEvent("supreme_aircon:GiveReward")
            TriggerEvent("supreme_aircon:PoliceNotify")
		else
			TriggerServerEvent('supreme_aircon:GiveReward2')
		end
	end)
   -- TriggerEvent("supreme_aircon:PoliceNotify")
    timer[parkingmeter] = 0
    canSearch = true
    DeleteObject(entity)]]
    FreezeEntityPosition(PlayerPedId(), true)
    ExecuteCommand('e medic')
    TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 10000,
        label = "Searching Bin",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
        },
       }, 
        function(status)
              ClearPedTasks(GetPlayerPed(-1))
                    TriggerServerEvent("supreme_aircon:PickLootBinReward")
           -- TriggerEvent("supreme_aircon:PoliceNotify")
            timer[payphones] = 0
            canSearch = true
            DeleteObject(entity)
            FreezeEntityPosition(PlayerPedId(), false)
            ExecuteCommand('e c')
      end)
end


-- ATimer
Citizen.CreateThread(function()
    while true do
        for entity,time in pairs(timer) do
            if time == 0 then
                searched[entity] = false
                timer[entity] = nil
            else
                time = time - 1
            end
        end
        Citizen.Wait(300000)
    end
end)

RegisterNetEvent("supreme_aircon:PoliceNotify")
AddEventHandler("supreme_aircon:PoliceNotify", function()
    local chancetocall = math.random(10,100)
    if chancetocall < 45 then
--if exports['linden_outlawalert']:zoneChance('Custom', 2) then
local pos = GetEntityCoords(PlayerPedId())
local data = {displayCode = '10-31', description = 'Aircon unit theft in progress', isImportant = 1, recipientList = {'police'}, length = '4000'}
local dispatchData = {dispatchData = data, caller = 'Local', coords = vector3(pos.x, pos.y, pos.z)}
TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end
end)

RegisterNetEvent("supreme_aircon:PoliceNotify2")
AddEventHandler("supreme_aircon:PoliceNotify2", function()
    local chancetocall = math.random(10,100)
    if chancetocall < 45 then
--if exports['linden_outlawalert']:zoneChance('Custom', 2) then
local pos = GetEntityCoords(PlayerPedId())
local data = {displayCode = '10-31', description = 'Someone robbing parking meters ', isImportant = 1, recipientList = {'police'}, length = '4000'}
local dispatchData = {dispatchData = data, caller = 'Local', coords = vector3(pos.x, pos.y, pos.z)}
TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end
end)

RegisterNetEvent("supreme_aircon:PoliceNotify3")
AddEventHandler("supreme_aircon:PoliceNotify3", function()
    local chancetocall = math.random(10,100)
    if chancetocall < 45 then
--if exports['linden_outlawalert']:zoneChance('Custom', 2) then
local pos = GetEntityCoords(PlayerPedId())
local data = {displayCode = '10-31', description = 'Someone seen robbing pay phones ', isImportant = 1, recipientList = {'police'}, length = '4000'}
local dispatchData = {dispatchData = data, caller = 'Local', coords = vector3(pos.x, pos.y, pos.z)}
TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end
end)

