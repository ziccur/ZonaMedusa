ESX = exports["es_extended"]:getSharedObject()
local menuIsShowed = false

local location = vector3(-1637.1189, 180.4041, 61.7573)

Size = {
    x = 3.0,
    y = 3.0,
    z = 0.5,
}

CreateThread(function()
    while true do
        local playerPed = ESX.PlayerData.ped
        local coords = GetEntityCoords(playerPed)
        if (#(coords - vector3(location.x, location.y, location.z)) < Size.x ) then
            ESX.TextUI("Pulsa E para acceder a la universidad")
            
            while not IsControlJustPressed(0, 38) do -- Control de la tecla E
                Wait(0)
            end
            menuIsShowed = true

        else -- si el jugador no esta en el rango elimina la notificación
            ESX.HideUI()
        end
        Wait(500)
    end
end)


CreateThread(function()

    




end)