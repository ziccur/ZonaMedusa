local location = Config.location
local defaultOwner = Config.defaultOwner
local xPlayer = ESX.GetPlayerData()
local isConquering = false
local isInside = false


CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - location)

        if xPlayer then --! Alive case
                
        else --! Dead case

            if isConquering then --! Dead while conquering
                --TODO: Server event to stop conquering
                isConquering = false
            else --! Dead and not conquering
                if isInside and allowedJob then
                    local isInside = false
                   --TODO: Server event to leave zone
                end
            end
            
        end

    end
end)


function allowedJob()
    for i = 1, #Config.allowedJobs do
        if xPlayer.job.name == Config.allowedJobs[i] then
            return true
        end
    end
    return false
end
