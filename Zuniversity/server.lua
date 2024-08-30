
local pedCoords = vector3(-1637.1189, 180.4041, 61.7573)
local pedModel = "a_m_m_business_01"

netIdTable = {}


ped = CreatePed(0, pedModel, pedCoords.x, pedCoords.y, pedCoords.z, 100, true, true)
netIdTable[1]= NetworkGetNetworkIdFromEntity(ped)
TriggerClientEvent('esx_banking:pedHandler', -1, netIdTable)

