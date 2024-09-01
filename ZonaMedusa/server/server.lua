local ownerOfMedusa = Config.defaultOwner
local playersOnMedusa = {}
local isCountingDown = false


AddEventHandler('playerDropped', function()
    local _source = source
    playersOnMedusa[_source] = nil
end)

RegisterServerEvent('ZonaMedusa:playerEnteredZone')
AddEventHandler('ZonaMedusa:playerEnteredZone', function()
    local _source = source
    playersOnMedusa[_source] = true
end)

RegisterServerEvent('ZonaMedusa:playerLeftZone')
AddEventHandler('ZonaMedusa:playerLeftZone', function()
    local _source = source
    playersOnMedusa[_source] = nil
end)

RegisterNetEvent('ZonaMedusa:playerDisconnecting')
AddEventHandler('ZonaMedusa:playerDisconnecting', function(reason)
    local source = source
    if playersOnMedusa[source] then
        playersOnMedusa[source] = nil
    end
end)

if Config.NPCspawn then
    local pedCoords = Config.location
    local pedModel = Config.pedModel

    netIdTable = {}

    ped = CreatePed(0, pedModel, pedCoords.x, pedCoords.y, pedCoords.z, 100, true, true)
    netIdTable[1]= NetworkGetNetworkIdFromEntity(ped)
    TriggerClientEvent('esx_banking:pedHandler', -1, netIdTable)

end

RegisterNetEvent('conquerMedusa')
AddEventHandler('conquerMedusa', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local job = xPlayer.job.name
    local conflict = false

    for i = 1, #playersOnMedusa do
        if xPlayer.job.name ~= job then
            conflict = true
            break
        end
    end

    print('conflict: ' .. tostring(conflict))

    if conflict then
        TriggerClientEvent('receiveConquerCode', _source, 1)
    else
        TriggerClientEvent('receiveConquerCode', _source, 2)
    end

end)



RegisterNetEvent('getOwnerOfMedusa')
AddEventHandler('getOwnerOfMedusa', function()
    local _source = source
    TriggerClientEvent('receiveOwnerOfMedusa', _source, ownerOfMedusa)
end)
