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

-- bt-target
exports['bt-target']:AddTargetModel(aircons, {
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

-- Callback bt-target
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
                exports['mythic_notify']:DoHudText('error', 'This aircon has already been searched')
            else 
                exports['mythic_notify']:DoHudText('inform', 'You begin to search the aircon')

                StartSearching(aircon)
                searched[aircon] = true
            end

            break -- We have already found the aircon, so we stop the loop to not waste resources
        end
    end
end)

function StartSearching(aircon)
    canSearch = false
    local ped = PlayerPedId()

    if not HasAnimDictLoaded("amb@prop_human_bum_bin@base") then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(0)
        end
    end

TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
exports.rprogress:Start('Searching Aircon...', 10000)
    Wait(0)
    if not DoesEntityExist(ped) then
        ped = PlayerPedId()
    end
    ClearPedTasks(ped)
    TriggerServerEvent("supreme_aircon:GiveReward")
    TriggerEvent("supreme_aircon:PoliceNotify")
    timer[aircon] = 10
    canSearch = true
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
        Citizen.Wait(60000)
    end
end)

RegisterNetEvent("supreme_aircon:PoliceNotify")
AddEventHandler("supreme_aircon:PoliceNotify", function()
local randomReport = math.random(1, Config.CallCopsPercent)
if randomReport == Config.CallCopsPercent then
local pos = GetEntityCoords(PlayerPedId())
local data = {displayCode = '420', description = 'Aircon unit theft in progress', isImportant = 1, recipientList = {'police'}, length = '4000'}
local dispatchData = {dispatchData = data, caller = 'Local', coords = vector3(pos.x, pos.y, pos.z)}
TriggerServerEvent('wf-alerts:svNotify', dispatchData)
end
end)

