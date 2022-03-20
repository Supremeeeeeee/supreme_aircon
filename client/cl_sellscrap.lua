local ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
Citizen.CreateThread(function()    
        Citizen.Wait(100)
        
        for locationIndex = 1, #Config.SellScrapLocations do
            local locationPos = Config.SellScrapLocations[locationIndex]

            local blip = AddBlipForCoord(locationPos)

            SetBlipSprite (blip, 409)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, 0.7)
            SetBlipColour (blip, 3)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Sell scrap")
            EndTextCommandSetBlipName(blip)
        end
end)

exports['qtarget']:AddCircleZone("sellscrap", vector3(-460.2915, -1702.0350, 18.8374), 1.35, {
    name="sellscrap",
    debugPoly=false,
    useZ=true,
    }, {
        options = {
            {
                event = 'supreme_aircon:sellScrapMenu',
                icon = 'fas fa-dollar-sign',
                label = 'Sell Scrap'
            },
        },
        distance = 1.5
    })


-- nh-context
RegisterNetEvent('supreme_aircon:sellScrapMenu', function(data)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Sell Scrap menu",
            txt = "",
            params = {
                event = ""
            }
        },
        {
            id = 2,
            header = "🔴 Sell Scrap Parts",
            txt = "",
            params = {
                event = "supreme_aircon:SellScrap"
            }
        },
        {
            id = 3,
            header = "🔴 Sell Steel",
            txt = "",
            params = {
                event = "supreme_aircon:SellSteel"
            }
        },
    })
end)

-- Server Scrap
RegisterNetEvent("supreme_aircon:SellScrap")
AddEventHandler("supreme_aircon:SellScrap", function()
TriggerServerEvent('supreme_aircon:sellScrap')
end)

-- Server Steel
RegisterNetEvent("supreme_aircon:SellSteel")
AddEventHandler("supreme_aircon:SellSteel", function()
TriggerServerEvent('supreme_aircon:sellSteel')
end)
