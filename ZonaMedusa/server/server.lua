local ownerOfMedusa = nil
local playersOnMedusa = {}

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


    RegisterNetEvent('myServerEvent')
    AddEventHandler('myServerEvent', function(someData)
        local xPlayer = ESX.GetPlayerFromId(source) -- Obtén el objeto xPlayer del jugador que llamó el evento
        xPlayer.addMoney(5)
    end)
end


