local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('repairbench', function(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('astrobench:openMenu', source)
end)