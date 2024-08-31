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
        
        --? Comprueba si el jugador esta en el rango del punto
        if (#(coords - vector3(location.x, location.y, location.z)) < Size.x ) then
            if not menuIsShowed then
                ESX.UI.Menu.Open("default", "Zuniversity", "Universidad", data, submit, cancel, change, close)
                menuIsShowed = true
            end
           
            --? si el jugador se aleja del punto elimina el menu
            while menuIsShowed and not (#(coords - vector3(location.x, location.y, location.z)) < Size.x ) do 
                ESX.UI.Menu.Close("default", "Zuniversity", "Universidad")
                menuIsShowed = false
                Wait(0)
            end


        else --? si el jugador no esta en el rango elimina el menu
            ESX.UI.Menu.Close("default", "Zuniversity", "Universidad")
            menuIsShowed = false
        end
        Wait(500)
    end
end)


  