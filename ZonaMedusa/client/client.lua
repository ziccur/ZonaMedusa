function allowedJob()
    for i = 1, #Config.allowedJobs do
        if ESX.PlayerData.job.name == Config.allowedJobs[i] then
            return true
        end
    end
    return false
end


function inZone()
    local playerCoords = GetEntityCoords(PlayerPedId())
    return (#(playerCoords - Config.location) < Config.Size.x)
end


--! -------------------------------------------------------------------------------------------------------------------

local location = Config.location
local defaultOwner = Config.defaultOwner
local isConquering = false
local isInside = false
local areOtherConquering = false


CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()

        if not IsEntityDead(playerPed) then --! Alive case

            if inZone() then --! Alive and in zone

                if not isInside then --! Mark as inside zone
                    isInside = true
                    ESX.ShowNotification('~g~ Has entrado a la zona Medusa')
                    
                    if allowedJob() then --! Alive, in zone and allowed job
                        print("ENVIANDO AL SERVIDOR: ENTRAR A LA ZONA")
                        --TODO: Server event to enter zone
                    end

                end
                

                if allowedJob() then --! Alive, in zone and allowed job

                    if isConquering then --! Alive, in zone, allowed job and already conquering
                        ESX.ShowNotification('~r~ Ya estás conquistando la zona')
                        print('Ya estás conquistando la zona')
                    end 

                    
                    if not isConquering then 
                        
                        --areOtherConquering = --TODO: Server event to check if other players are conquering
                        print("ENVIANDO AL SERVIDOR: CHEQUEAR SI OTROS JUGADORES ESTÁN CONQUISTANDO")

                        if areOtherConquering then --! Alive, in zone, allowed job and other players are conquering
                            ESX.ShowNotification('~r~ Hay otros jugadores conquistando la zona')
                            print('Hay otros jugadores conquistando la zona')
                            return
                        else --! Alive, in zone, allowed job and no one is conquering
                            isConquering = true 
                            print("ENVIANDO AL SERVIDOR: COMENZAR A CONQUISTAR")
                            --TODO: Server event to start conquering
                            ESX.ShowNotification('~g~ Has comenzado a conquistar la zona Medusa')
                        end
                    end

                else --! Alive, in zone and not allowed job
                    ESX.TextUI('~r~ No tienes permiso para conquistar la zona')
                    print('No tienes permiso para conquistar la zona')
                end

            else --! Alive and not in zone
                    isConquering = false
                    if isInside then --! Mark as outside zone
                        ESX.HideUI()
                        isInside = false
                        ESX.ShowNotification('~r~ Has salido de la zona Medusa')
                        if allowedJob() then --! Alive, just leave zone and allowed job
                            print("ENVIANDO AL SERVIDOR: SALIR DE LA ZONA")
                            --TODO: Server event to leave zone
                        end
                    end
            end
            
        else --! Dead case

            if isConquering then --! Dead while conquering
                print("ENVIANDO AL SERVIDOR: DETENER CONQUISTA")
                --TODO: Server event to stop conquering
                isConquering = false
            else --! Dead and not conquering

                if isInside and allowedJob then  --! Dead and was inside zone AND has allowed job

                    print("ENVIANDO AL SERVIDOR: SALIR DE LA ZONA")
                    --TODO: Server event to leave zone
                    isInside = false 
                    
                end
                
            end

        end

    end
end)





