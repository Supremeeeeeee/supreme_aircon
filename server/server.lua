local ESX = nil

local airconItems = { 
    [1] = {chance = -1, id = 'scrappart', name = 'AC Unit Part', quantity = math.random(10,50), limit = 500},
    [2] = {chance = 9, id = 'steel', name = 'Steel', quantity = math.random(1,2), limit = 500},
   }

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('supreme_aircon:GiveReward')
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
end)
