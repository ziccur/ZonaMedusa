local location = Config.location
local ownerOfMedusa = Config.defaultOwner
local isInside = false
local countdownTime = Config.timeToConquer 
local isCountingDown = false
local jobAllowed = false

CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        
        -- Comprueba si el jugador está en el rango del punto
        if (#(coords - vector3(location.x, location.y, location.z)) < Config.Size.x) then

            print(ESX.PlayerData.job.label .. " y " .. ownerOfMedusa)

            
            for i = 1, #Config.allowedJobs do
                if ESX.PlayerData.job.name == Config.allowedJobs[i] then
                    jobAllowed = true
                    break
                end
            end
            
            if jobAllowed then
                if ESX.PlayerData.job.label == ownerOfMedusa then
                    ESX.TextUI('Ya eres dueño de la zona Medusa')
                else 
                    ESX.TextUI("Pulsa ~g~E~s~ para conquistar Medusa")
                end
    
                if not isInside then
                    TriggerServerEvent('ZonaMedusa:playerEnteredZone')
                    print('Has entrado en la zona Medusa')
                    
                    isInside = true
    
                    while not IsControlJustPressed(0, 38) do -- Control de la tecla E
                        coords = GetEntityCoords(PlayerPedId())
                        if not (#(coords - vector3(location.x, location.y, location.z)) < Config.Size.x) then
                            break
                        end
                        Wait(0)
                    end
    
                    if ESX.PlayerData.job.label == ownerOfMedusa then
                    else
                        local ConquerCode = -1 -- -1= default 1= conflict 2 = success
    
                        RegisterNetEvent('receiveConquerCode')
                        AddEventHandler('receiveConquerCode', function(code)
                            ConquerCode = code
                        end) 
                        
                        if ConquerCode == 1 then
                            ESX.ShowNotification('~r~Elimina primero a las fuerzas enemigas de la zona')
                        else
                            ESX.ShowNotification('~g~Has comenzado a conquistar la zona Medusa')
                            isCountingDown = true
                        end

                        --ESX.ShowNotification('~g~ ')
                        --isCountingDown = true
                    end
                    ESX.HideUI()
                    
                end
                    isInside = true
                else if isInside then
                    TriggerServerEvent('ZonaMedusa:playerLeftZone')
                    print('Has salido de la zona Medusa')
                else
                    ESX.HideUI()
                end
            end

            if not isInside then
                ESX.ShowNotification('~g~Has entrado en la zona Medusa')
                isInside = true
            else
                ESX.HideUI()
            end

        else
            if isInside then
                TriggerServerEvent('ZonaMedusa:playerLeftZone')
                ESX.ShowNotification('~r~Has salido de la zona de Medusa')
                print('Has salido de la zona Medusa')
                ESX.HideUI()
                isInside = false
            end
        end
        
        Wait(1000)
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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) 
        if isCountingDown then
            countdownTime = countdownTime - 1 

            if not isInside then 
                countdownTime = Config.timeToConquer
                isCountingDown = false
                ESX.ShowNotification('~r~ Ya no estas conquistando la zona Medusa')
            end

            if countdownTime <= 0 then
                countdownTime = 0
                isCountingDown = false
                ESX.ShowNotification('~g~Medusa conquistada por '.. ESX.PlayerData.job.label)
                countdownTime = Config.timeToConquer
            end
        end    
    end
end)


