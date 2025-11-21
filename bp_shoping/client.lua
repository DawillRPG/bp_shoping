local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    local model = Config.NPC.model
    local coords = Config.NPC.coords
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end

    local ped = CreatePed(0, model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'npc_shop_menu',
            icon = 'fas fa-cart-shopping',
            label = 'Comprar Equipos',
            onSelect = function()
                openShopMenu()
            end
        }
    })
end)

function openShopMenu()
    local options = {}

    for _, item in pairs(Config.ShopItems) do
        table.insert(options, {
            title = ("%s - $%d"):format(item.label, item.price),
            icon = 'shopping-bag',
            onSelect = function()
                TriggerServerEvent('bp_shoping:buyItem', item.name)
            end
        })
    end

    exports.ox_lib:registerContext({
        id = 'npc_shop_menu',
        title = 'Tienda de Equipos',
        options = options
    })

    exports.ox_lib:showContext('npc_shop_menu')
end
