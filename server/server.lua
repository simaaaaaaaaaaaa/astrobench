local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('repairbench', function(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('astrobench:openMenu', source)
end)

--check for vehicle--
RegisterNetEvent('qb-repairbench:open')
AddEventHandler('qb-repairbench:open', function()
    local src = source
    local playerPed = GetPlayerPed(src)
    if IsPedInAnyVehicle(playerPed, false) then
        TriggerClientEvent('qb-repairbench:openNUI', src)
    else
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = 'You need to be in a vehicle to use the repair bench!'})
    end
end)