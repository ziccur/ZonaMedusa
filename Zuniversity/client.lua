ESX = exports["es_extended"]:getSharedObject()
local menuIsShowed = false

local data = {
    title = "Mi Menú",
    align = "top-left",
    elements = {
      {label = "Opción 1", value = "opcion1"},
      {label = "Opción 2", value = "opcion2"}
    }
  }
   

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
            menuIsShowed = true
                ESX.UI.Menu.Open("default", "Zuniversity", "Universidad", data, submit, cancel, change, close)

        else -- si el jugador no esta en el rango elimina la notificación
            ESX.UI.Menu.Close("default", "Zuniversity", "Universidad")
        end
        Wait(500)
    end
end)


  