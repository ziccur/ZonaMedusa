local ownerOfMedusa = Config.defaultOwner
local jobNameOfOwner = nil
local playersOnMedusa = {}
local isCountingDown = false
ESX = exports["es_extended"]:getSharedObject()

--! player crash client

--[[ 
    Removes a player from the 'playersOnMedusa' table when they disconnect.
    
    Parameters:
    - None
    
    Returns:
    - None
--]]
AddEventHandler('playerDropped', function()
    for i, player in ipairs(playersOnMedusa) do
        if player == source then
            table.remove(playersOnMedusa, i)
            break
        end
    end
end)

--! player enter zone
RegisterServerEvent('ZonaMedusa:playerEnteredZone')
AddEventHandler('ZonaMedusa:playerEnteredZone', function() 
    local _source = source
    table.insert(playersOnMedusa, _source)
end)

--! player leave zone
RegisterServerEvent('ZonaMedusa:playerLeftZone')
AddEventHandler('ZonaMedusa:playerLeftZone', function()
    local _source = source
    table.remove(playersOnMedusa, _source)
end)
--! player disconnect
RegisterNetEvent('ZonaMedusa:playerDisconnecting')
AddEventHandler('ZonaMedusa:playerDisconnecting', function(reason)
    local source = source
    if playersOnMedusa[source] then
        playersOnMedusa[source] = nil
    end
end)

--! NPC spawn ped
if Config.NPCspawn then
    local pedCoords = Config.location
    local pedModel = Config.pedModel

    netIdTable = {}

    ped = CreatePed(0, pedModel, pedCoords.x, pedCoords.y, pedCoords.z, 100, true, true)
    netIdTable[1]= NetworkGetNetworkIdFromEntity(ped)
    TriggerClientEvent('esx_banking:pedHandler', -1, netIdTable)

end

--! return owner of medusa
RegisterNetEvent('getOwnerOfMedusa')
AddEventHandler('getOwnerOfMedusa', function()
    local _source = source
    TriggerClientEvent('receiveOwnerOfMedusa', _source, ownerOfMedusa)
end)


--! player conquer zone
RegisterNetEvent('conquerZone')
AddEventHandler('conquerZone', function()
    local _source = source
    isCountingDown = true
    ownerOfMedusa = ESX.GetPlayerFromId(_source).job.label
    jobNameOfOwner = ESX.GetPlayerFromId(_source).job.name
end)

--! get countdown
RegisterNetEvent('getCountingDown')
AddEventHandler('getCountingDown', function()
    local _source = source
    TriggerClientEvent('receiveOtherConquering', _source, isCountingDown)
end)

--! stop counting down
RegisterNetEvent('stopCountingDown')
AddEventHandler('stopCountingDown', function()
    isCountingDown = false
    getPlayersToReward() 
end)

--! return if are others in zone
RegisterNetEvent('getAreOthers')
AddEventHandler('getAreOthers', function()
    local _source = source
    job = ESX.GetPlayerFromId(_source).job.label

    for i, _ in pairs(playersOnMedusa) do
        if ESX.GetPlayerFromId(i).job.label ~= job then
            TriggerClientEvent('receiveAreOthers', _source, true)
        end
    end
    TriggerClientEvent('receiveAreOthers', _source, false)
end)

--! event conquer zone
RegisterNetEvent('conquerZone')
AddEventHandler('conquerZone', function()
    local _source = source

end)

--! ---------------------------------------------------------------
--! ----------------------  Functions  ------------------------------
--! ---------------------------------------------------------------

CreateThread(function()
    while true do
       
        Wait(1000 * Config.timeToReward)
        if jobNameOfOwner ~= nil then
            
            for k, i in ipairs(Config.allowedJobs) do
                if jobNameOfOwner == i then
                    giveRewards('legal', _source, getPlayersToReward())
                    break
                end
            end
            for k, i in ipairs(Config.allowedIllegalJobs) do
                if jobNameOfOwner == i then
                    giveRewards('ilegal', _source, getPlayersToReward())
                    break
                end
            end
        end
    end
end)


--[[ 
    Retrieves a list of players to reward based on their job label.

    @return table playersToReward - A table containing the IDs of players to reward.
]]
function getPlayersToReward() 
    local playersToReward = {}
    players = GetPlayers()

    for k, i in pairs(players) do
        if ESX.GetPlayerFromId(i).job.label == ownerOfMedusa then
            table.insert(playersToReward, i)
        end
    end
    
    return playersToReward
end


--[[
    giveRewards(typeofJob, source, listOfPlayersToReward)

    This function gives rewards to players for conquering a zone.

    Parameters:
    - typeofJob (string): The type of job, can be either 'legal' or 'ilegal'.
    - source (number): The source of the event.
    - listOfPlayersToReward (table): A table containing the list of players to reward.

    Returns:
    - None
]]
function giveRewards(typeofJob, source, listOfPlayersToReward) --! typeofJob = 'legal' or 'ilegal'
    if ownerOfMedusa ~= Config.defaultOwner then

        for k, i in pairs(listOfPlayersToReward) do
            TriggerClientEvent('esx:showNotification', i, 'Has recibido tu recompensa por conquistar la zona')

            local rewards = Config[typeofJob .. 'Reward']

            for k, v in pairs(rewards) do
                print('Dando recompensa a ' .. i .. ' de ' .. k .. ' con ' .. v)
                giveItemToPlayer(i, k, v)
            end
        end
    end
end

--[[
    giveItemToPlayer(player, item, amount)

    This function is used to give an item to a player.

    Parameters:
        - player (number): The player ID.
        - item (string): The item to give.
        - amount (number): The amount of the item to give.

    Returns:
        - None
]]
function giveItemToPlayer(player, item, amount)
    if item == 'money' then
        ESX.GetPlayerFromId(player).addMoney(amount)
    elseif item == 'bank' then
        ESX.GetPlayerFromId(player).addAccountMoney('bank', amount)
    else 
        ESX.GetPlayerFromId(player).addInventoryItem(item, amount)
    end
end

--! admin command
-- RegisterCommand: Registers a command that allows changing the owner of the Medusa zone.
-- Parameters:
--   - source: The source of the command.
--   - args: The arguments passed to the command.
--   - rawCommand: The raw command string.
-- Returns: None.

RegisterCommand('changeOwnerOfMedusa', function(source, args, rawCommand)
    local player = ESX.GetPlayerFromId(source)

    if player.getGroup() == 'admin' then

        if args[1] == nil or args[2] == nil then
            TriggerClientEvent('esx:showNotification', source, 'Debes especificar un dueño para la zona Medusa. Uso: /changeOwnerOfMedusa [nombre del trabajo] [label del trabajo] ')
            return
        end

        ownerOfMedusa = args[2]
        jobNameOfOwner = args[1]
        TriggerClientEvent('esx:showNotification', source, 'Has cambiado el dueño de la zona Medusa a ' .. ownerOfMedusa    )
    else
        TriggerClientEvent('esx:showNotification', source, 'No tienes permisos para ejecutar este comando.')
    end
end)

