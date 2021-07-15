local ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent("supreme_aircon:sellScrap")
AddEventHandler("supreme_aircon:sellScrap", function()
    local player = ESX.GetPlayerFromId(source)

    local currentBottles = player.getInventoryItem("scrappart")["count"]
    
    if currentBottles > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random(1000,7000)

        player.removeInventoryItem("scrappart", currentBottles)
        player.addMoney(randomMoney)

			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You got payed $' .. randomMoney, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You dont have any scrap', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    end
end)

RegisterServerEvent("supreme_aircon:sellSteel")
AddEventHandler("supreme_aircon:sellSteel", function()
    local player = ESX.GetPlayerFromId(source)

    local currentSteel = player.getInventoryItem("steel")["count"]
    
    if currentSteel > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random(300,900)

        player.removeInventoryItem("steel", 3)
        player.addMoney(randomMoney * currentSteel)

			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You got payed $' .. randomMoney, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You dont have any steel or you have less than 3', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    end
end)
