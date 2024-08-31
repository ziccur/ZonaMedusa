
local pedCoords = Config.location
local pedModel = Config.pedModel

netIdTable = {}


ped = CreatePed(0, pedModel, pedCoords.x, pedCoords.y, pedCoords.z, 100, true, true)
netIdTable[1]= NetworkGetNetworkIdFromEntity(ped)
TriggerClientEvent('esx_banking:pedHandler', -1, netIdTable)

