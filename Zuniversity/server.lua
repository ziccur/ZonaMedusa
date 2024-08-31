
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