local ESX = nil

local airconItems = { 
    [1] = {chance = -1, id = 'scrapmetal', name = 'AC Unit Part', quantity = math.random(10,50), limit = 500},
    [2] = {chance = 9, id = 'steel', name = 'Steel', quantity = math.random(1,2), limit = 500},
   }

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[RegisterServerEvent('supreme_aircon:GiveReward')
AddEventHandler('supreme_aircon:GiveReward', function()
 local source = tonumber(source)
 local item = {}
 local gotID = {}
 local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local police = 0
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
				police = police + 1
		end
	end
if police >= Config.PoliceRequiredToScrap then
 for i=1, math.random(1, 2) do
  item = airconItems[math.random(1, #airconItems)]
  if math.random(1, 20) >= item.chance then
   if tonumber(item.id) == 0 and not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addMoney(item.quantity)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You found $'..item.quantity, })
   elseif string.find(item.id:upper(), "WEAPON_") then
    gotID[item.id] = true
    xPlayer.addWeapon(item.id, 50)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Item Added!', })
   elseif not gotID[item.id] then
    gotID[item.id] = true
    xPlayer.addInventoryItem(item.id, item.quantity)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You Found ' ..item.quantity..  ' '  ..item.name })
end          
   end
  end
 end
end)]]

ESX.RegisterServerCallback('supreme_aircon:PoliceOnline', function(source, cb, pos)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	local police = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.getJob().name == 'police' then
			police = police + 1
		end
	end
    
	if (police >= 1) then
	    cb(true)
	else
	    cb(false)
		if police < 0 then
			TriggerClientEvent('esx:showNotification', source,'HEY')
		end
	end
end)

RegisterServerEvent('supreme_aircon:GiveReward')
AddEventHandler('supreme_aircon:GiveReward', function()
    local source = tonumber(source)
    local item = {}
    local gotID = {}
    local xPlayer = ESX.GetPlayerFromId(source)
   xPlayer.addInventoryItem('scrapmetal', math.random(12,56))
end)

RegisterServerEvent('supreme_aircon:GiveReward2')
AddEventHandler('supreme_aircon:GiveReward2', function()
 local source = tonumber(source)
 local item = {}
 local gotID = {}
 local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addInventoryItem('scrapmetal', math.random(2,11))
end)

RegisterServerEvent('supreme_aircon:GiveMeterReward')
AddEventHandler('supreme_aircon:GiveMeterReward', function()
 local source = tonumber(source)
 local item = {}
 local gotID = {}
 local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addMoney(math.random(900,1300))
end)

RegisterServerEvent('supreme_aircon:GiveMeterReward2')
AddEventHandler('supreme_aircon:GiveMeterReward2', function()
 local source = tonumber(source)
 local item = {}
 local gotID = {}
 local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addMoney(math.random(40,250))
end)

RegisterServerEvent('supreme_aircon:GivePayPhoneReward')
AddEventHandler('supreme_aircon:GivePayPhoneReward', function()
 local source = tonumber(source)
 local item = {}
 local gotID = {}
 local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addMoney(math.random(900,1300))
end)

RegisterServerEvent('supreme_aircon:GivePayPhoneReward2')
AddEventHandler('supreme_aircon:GivePayPhoneReward2', function()
 local source = tonumber(source)
 local item = {}
 local gotID = {}
 local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addMoney(math.random(900,1300))
end)

RegisterServerEvent('supreme_aircon:PickPumpkinReward')
AddEventHandler('supreme_aircon:PickPumpkinReward', function()
 local source = tonumber(source)
 local item = {}
 local gotID = {}
 local xPlayer = ESX.GetPlayerFromId(source)
xPlayer.addInventoryItem('pumpkin', math.random(1,3))
end)

RegisterServerEvent('supreme_aircon:PickLootBinReward')
AddEventHandler('supreme_aircon:PickLootBinReward', function()
    local xPlayer, randomItem2 = ESX.GetPlayerFromId(source), Config.Items2[math.random(1, #Config.Items2)]
	local xPlayer, randomItem3 = ESX.GetPlayerFromId(source), Config.Items3[math.random(1, #Config.Items3)]
        xPlayer.addInventoryItem(randomItem2, math.random(1,1))
		xPlayer.addInventoryItem(randomItem3, math.random(1,2))
end)
