
--! VARIABLES

local location = Config.location
local ownerOfMedusa = "ERROR" --! if server-client error communication
local isConquering = false
local isInside = false
local wantToConquer = false
local blip = nil
local ownerOfMedusaShowed = ownerOfMedusa --! check if this is
local areOthers = false
local time = Config.timeToConquer
local isCountingDown = false

--! Recive Owner of Medusa <- server
RegisterNetEvent('receiveOwnerOfMedusa')
AddEventHandler('receiveOwnerOfMedusa', function(ownerOfMedusaServer)
    ownerOfMedusa = ownerOfMedusaServer
end)

--! Recive if are others in zone
RegisterNetEvent('receiveAreOthers')
AddEventHandler('receiveAreOthers', function(areOthersServer)
    areOthers = areOthersServer
end)

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

function conquer()
     
    TriggerServerEvent('getOwnerOfMedusa')

    if areOthers then --! Alive, in zone, allowed job, and others on zone
        ESX.ShowNotification('~r~ Hay otros jugadores conquistando la zona')
        print('Hay otros jugadores conquistando la zona')
        return false
    else --! Alive, in zone, allowed job and no one is conquering
        isConquering = true 
        ownerOfMedusa = ESX.PlayerData.job.label
        ESX.ShowNotification('~g~ Has comenzado a conquistar la zona Medusa')
        return true
    end
end

function createBlip()

    TriggerServerEvent('getOwnerOfMedusa')
    location = Config.location

    -- Crear el blip principal en las coordenadas especificadas
    blip = AddBlipForCoord(location.x, location.y, location.z)
    SetBlipSprite(blip, Config.BlipSprite)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, Config.BlipColour)
    SetBlipAsShortRange(blip, true)

    -- Configurar el nombre del blip
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Zona Medusa - ' .. ownerOfMedusa)
    EndTextCommandSetBlipName(blip)

    -- Crear el blip de radio (zona)
    local blipRadius = AddBlipForRadius(location.x, location.y, location.z, Config.range)
    SetBlipColour(blipRadius, 1)
    SetBlipAlpha(blipRadius, 50)
end

--! -------------------------------------------------------------------------------------------------------------------------------------------------


createBlip()

--! 


CreateThread(function()
    while true do
        Wait(1000)

        TriggerServerEvent('getOwnerOfMedusa')
        local playerPed = PlayerPedId()

        if not IsEntityDead(playerPed) then --! Alive case

            if inZone() then --! Alive and in zone

                if not isInside then --! Mark as inside zone
                    isInside = true
                    ESX.ShowNotification('~g~ Has entrado a la zona Medusa')
                    
                    if allowedJob() then --! Alive, in zone and allowed job
                        TriggerServerEvent("ZonaMedusa:playerEnteredZone")
                    end

                end
                
                if allowedJob() then --! Alive, in zone and allowed job

                    if not isConquering then --! Alive, in zone, allowed job and already conquering
                        CreateThread(function() --! CHECK E KEY FOR CONQUER
                            while not IsControlPressed(0, Config.conquerKey) do 
                                Wait(0)
                            end
                            wantToConquer = true
                        end)


                        if wantToConquer then --! Alive, in zone, allowed job and pressing keys
                            if inZone() then --! Alive, in zone, allowed job, not conquering and pressing keys, and still in zone
                                isConquering = conquer()
                                if not isConquering then
                                    wantToConquer = false
                                end
                            end

                        end
                    end

                else --! Alive, in zone and not allowed job
                    ESX.TextUI('~r~ No tienes permiso para conquistar la zona')
                    print('No tienes permiso para conquistar la zona')
                end

                if isConquering and not isCountingDown  then --! Alive, in zone and conquering
                    CreateThread(function() --! CONQUER COUNTDOWN
                        isCountingDown = true
                        while isConquering and time ~= nill and time > 0 do
                            Wait(1000)
                            SetTextComponentFormat("STRING")
                            print(time)
                            AddTextComponentString("Mantente en zona medusa para conquistarla - Tiempo restante: " .. time)
                            DisplayHelpTextFromStringLabel(0, 0, 1, 1000)
                            time = time - 1
                        end
                        if time ~= nill and time <= 0 then
                            ESX.ShowNotification('~g~ Has conquistado la zona Medusa')
                            TriggerServerEvent("conquerZone")
                        end
                        time = Config.timeToConquer
                        isConquering = false
                        isCountingDown = false
                        wantToConquer = false
                    end)
                end


            else --! Alive and not in zone
                    if isInside then --! Mark as outside zone
                        ESX.HideUI()
                        isInside = false
                        ESX.ShowNotification('~r~ Has salido de la zona Medusa')
                        if allowedJob() then --! Alive, just leave zone and allowed job

                            if isConquering then --! Alive, just leave zone, allowed job and was conquering
                                print("ENVIANDO AL SERVIDOR: DETENER CONQUISTA")
                                --TODO: Server event to stop conquering

                                isConquering = false
                                wantToConquer = false
                            end

                            TriggerServerEvent("ZonaMedusa:playerLeftZone")
                        end
                    end
            end

            if ownerOfMedusa ~= ownerOfMedusaShowed then --! Update blip name only if player is alive and owner changed                
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentString('Zona Medusa - ' .. ownerOfMedusa)
                EndTextCommandSetBlipName(blip)
                ownerOfMedusaShowed = ownerOfMedusa
            end
            
        else --! Dead case

            if isConquering then --! Dead while conquering
                print("ENVIANDO AL SERVIDOR: DETENER CONQUISTA")
                --TODO: Server event to stop conquering
                isConquering = false
                wantToConquer = false
            else --! Dead and not conquering

                if isInside and allowedJob then  --! Dead and was inside zone AND has allowed job

                    TriggerServerEvent("ZonaMedusa:playerLeftZone")
                    isInside = false 
                    
                end

            end

        end

    end
end)

