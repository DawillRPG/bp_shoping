local QBCore = exports['qb-core']:GetCoreObject()

local ItemPrices = {}
for _, item in ipairs(Config.ShopItems) do
    ItemPrices[item.name] = item.price
end

RegisterServerEvent('bp_shoping:buyItem', function(itemName)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    local price = ItemPrices[itemName]
    if not price then return end

    if xPlayer.Functions.RemoveMoney('cash', price) then
        xPlayer.Functions.AddItem(itemName, 1)
        TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'Has comprado ' .. itemName})
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'No tienes suficiente dinero'})
    end
end)
