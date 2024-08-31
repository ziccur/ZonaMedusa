ESX = exports["es_extended"]:getSharedObject()
local menuIsShowed = false
local menuIsClosed = false

local location = Config.location
local options = Config.options

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
            if not menuIsShowed and not menuIsClosed then
                ESX.UI.Menu.Open("default", "Zuniversity", "Universidad", Config.dataMenu, 

                function(data, menu)
                    local selectedOption = data.current.value
                    for i = 1, #options do
                        if options[i].value == selectedOption then
                            selectedOption = options[i]
                        end
                    end

                    while ESX.GetPlayerData().accounts == nil do
                        Citizen.Wait(10)
                    end
                
                    -- Acceder al saldo bancario
                    local avaliableMoney = nil
                    for _, account in ipairs(ESX.GetPlayerData().accounts) do
                        if account.name == Config.payMethod then
                            avaliableMoney = account
                            break
                        end
                    end

                    if selectedOption.money > 0 then
                        if avaliableMoney.money < selectedOption.money then -- Player don't have enough money
                            ESX.ShowNotification("No tienes suficiente dinero")
                        else
                            ESX.ShowNotification("Has pagado " .. selectedOption.money .. "$")
                        end
                    end

                    TriggerServerEvent('myServerEvent', 'Datos enviados desde el cliente')

                    menu.close()
                    menuIsShowed = false
                    menuIsClosed = true
                end, 
                cancel, change, close)
                menuIsShowed = true
            end
           
            --? si el jugador se aleja del punto elimina el menu
            while menuIsShowed and not (#(coords - vector3(location.x, location.y, location.z)) < Size.x ) do 
                ESX.UI.Menu.Close("default", "Zuniversity", "Universidad")
                menuIsShowed = false
                menuIsClosed = false
                Wait(0)
            end


        else --? si el jugador no esta en el rango elimina el menu
            ESX.UI.Menu.Close("default", "Zuniversity", "Universidad")
            menuIsShowed = false
            menuIsClosed = false
        end
        Wait(500)
    end
end)

-- Función que se ejecuta cuando el usuario selecciona una opción en el menú


  