local location = Config.location
local ownerOfMedusa = Config.defaultOwner
local isInside = false


CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        
        -- Comprueba si el jugador está en el rango del punto
        if (#(coords - vector3(location.x, location.y, location.z)) < Config.Size.x) then
            if not isInside then
                TriggerServerEvent('ZonaMedusa:playerEnteredZone')
                ESX.ShowNotification('~g~Has entrado en la zona Medusa')
                isInside = true
            end
            isInside = true
        else if isInside then
            ESX.ShowNotification('~r~Has salido de la zona de Medusa')
            isInside = false
            TriggerServerEvent('ZonaMedusa:playerLeftZone')
        end
        end       
        Wait(3000)
    end
end)


blipPos = Config.location
local blip = AddBlipForCoord(Config.location)
SetBlipSprite (blip, Config.BlipSprite)
SetBlipScale  (blip, 1.0)
SetBlipColour (blip, Config.BlipColour)
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName('STRING')
blipRadius = AddBlipForRadius(blipPos.x, blipPos.y, blipPos.z, Config.range)
SetBlipColour(blipRadius, 1) 
SetBlipAlpha(blipRadius, 50) 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) 

        TriggerServerEvent('getOwnerOfMedusa')
        RegisterNetEvent('receiveOwnerOfMedusa')
        AddEventHandler('receiveOwnerOfMedusa', function(owner)
            ownerOfMedusa = owner
        end) 

        AddTextComponentSubstringPlayerName('Zona Medusa - '.. ownerOfMedusa)
        EndTextCommandSetBlipName(blip)

    end
end)
