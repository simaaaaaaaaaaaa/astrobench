local QBCore = exports['qb-core']:GetCoreObject()
local isMenuOpen = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for _, location in pairs(Config.Locations) do
            local distance = #(playerCoords - vector3(location.x, location.y, location.z))
            if distance < 2.0 then
                DrawText3D(location.x, location.y, location.z, "[E] Open/Close Repair Bench")
                if IsControlJustReleased(0, 38) then -- E key
                    if isMenuOpen then
                        print("Closing Repair Bench NUI")
                        SetNuiFocus(false, false)
                        SendNUIMessage({
                            action = 'close'
                        })
                        isMenuOpen = false
                    else
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        if vehicle ~= 0 then
                            print("Opening Repair Bench NUI")
                            SetNuiFocus(true, true)
                            SendNUIMessage({
                                action = 'open'
                            })
                            isMenuOpen = true
                        else
                            QBCore.Functions.Notify('You need to be in a vehicle to use the repair bench!', 'error')
                        end
                    end
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0, 0, 0, 75)
end

RegisterNetEvent('astrobench:openMenu', function()
    print("Received openMenu event")
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle ~= 0 then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open'
        })
        isMenuOpen = true
    else
        QBCore.Functions.Notify('You need to be in a vehicle to use the repair bench!', 'error')
    end
end)

RegisterNUICallback('repairVehicle', function(data, cb)
    print("Repair Vehicle Callback")
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle then
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0.0)
        QBCore.Functions.Notify('Vehicle repaired!', 'success')
    end
    cb('ok')
end)

RegisterNUICallback('setExtra', function(data, cb)
    print("Set Extra Callback")
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle then
        SetVehicleExtra(vehicle, data.extra, not IsVehicleExtraTurnedOn(vehicle, data.extra))
        QBCore.Functions.Notify('Extra set!', 'success')
    end
    cb('ok')
end)

RegisterNUICallback('setLivery', function(data, cb)
    print("Set Livery Callback")
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle then
        SetVehicleLivery(vehicle, data.livery)
        QBCore.Functions.Notify('Livery set!', 'success')
    end
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    print("Close Callback")
    SetNuiFocus(false, false)
    isMenuOpen = false
    cb('ok')
end)