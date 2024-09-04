local ownerOfMedusa = Config.defaultOwner
local playersOnMedusa = {}
local isCountingDown = false
ESX = exports["es_extended"]:getSharedObject()

--! player crash client
AddEventHandler('playerDropped', function() 
    print("ID del crash: ".. _source)
    local _source = source
    table.remove(playersOnMedusa, _source)
end)

--! player enter zone
RegisterServerEvent('ZonaMedusa:playerEnteredZone')
AddEventHandler('ZonaMedusa:playerEnteredZone', function() 
    local _source = source
    print(_source)
    table.insert(playersOnMedusa, _source)
    print("Jugadores en medusa: " .. json.encode(playersOnMedusa))
end)

--! player leave zone
RegisterServerEvent('ZonaMedusa:playerLeftZone')
AddEventHandler('ZonaMedusa:playerLeftZone', function()
    local _source = source
    table.remove(playersOnMedusa, _source)
    print("Jugadores en medusa: " .. json.encode(playersOnMedusa))
end)
--! player disconnect
RegisterNetEvent('ZonaMedusa:playerDisconnecting')
AddEventHandler('ZonaMedusa:playerDisconnecting', function(reason)
    local source = source
    if playersOnMedusa[source] then
        playersOnMedusa[source] = nil
    end
end)

--! NPC spawn ped
if Config.NPCspawn then
    local pedCoords = Config.location
    local pedModel = Config.pedModel

    netIdTable = {}

    ped = CreatePed(0, pedModel, pedCoords.x, pedCoords.y, pedCoords.z, 100, true, true)
    netIdTable[1]= NetworkGetNetworkIdFromEntity(ped)
    TriggerClientEvent('esx_banking:pedHandler', -1, netIdTable)

end

--! return owner of medusa
RegisterNetEvent('getOwnerOfMedusa')
AddEventHandler('getOwnerOfMedusa', function()
    local _source = source
    TriggerClientEvent('receiveOwnerOfMedusa', _source, ownerOfMedusa)
end)


--! player conquer zone
RegisterNetEvent('conquerZone')
AddEventHandler('conquerZone', function()
    local _source = source
    isCountingDown = true
    ownerOfMedusa = ESX.GetPlayerFromId(_source).job.label
end)

--! return if are others in zone
RegisterNetEvent('getAreOthers')
AddEventHandler('getAreOthers', function()
    local _source = source
    job = ESX.GetPlayerFromId(_source).job.label

    for i, _ in pairs(playersOnMedusa) do
        if ESX.GetPlayerFromId(i).job.label ~= job then
            TriggerClientEvent('receiveAreOthers', _source, true)
        end
    end
    TriggerClientEvent('receiveAreOthers', _source, false)
end)

--! event conquer zone
RegisterNetEvent('conquerZone')
AddEventHandler('conquerZone', function()
    local _source = source

end)


