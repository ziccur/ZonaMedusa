local location = Config.location

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


