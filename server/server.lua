local ownerOfMedusa = Config.defaultOwner
local playersOnMedusa = {}
local isCountingDown = false
ESX = exports["es_extended"]:getSharedObject()

--! player crash client
AddEventHandler('playerDropped', function() 
    print("ID del crash: ".. _source)
    local _source = source
    table.remove(playersOnMedusa, _source)
end)

--! player enter zone
RegisterServerEvent('ZonaMedusa:playerEnteredZone')
AddEventHandler('ZonaMedusa:playerEnteredZone', function() 
    local _source = source
    print(_source)
    table.insert(playersOnMedusa, _source)
    print("Jugadores en medusa: " .. json.encode(playersOnMedusa))
end)

--! player leave zone
RegisterServerEvent('ZonaMedusa:playerLeftZone')
AddEventHandler('ZonaMedusa:playerLeftZone', function()
    local _source = source
    table.remove(playersOnMedusa, _source)
    print("Jugadores en medusa: " .. json.encode(playersOnMedusa))
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
    giveRewards('legal', source, playersOnMedusa)
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

function giveRewards(typeofJob, source, listOfPlayersToReward) --! typeofJob = 'legal' or 'ilegal'
    if ownerOfMedusa ~= Config.defaultOwner then

        for i, _ in pairs(listOfPlayersToReward) do
            TriggerClientEvent('esx:showNotification', i, 'Has recibido tu recompensa por conquistar la zona')

            local rewards = Config[typeofJob .. 'Reward']

            for k, v in pairs(rewards) do
                print('Dando recompensa a ' .. i .. ' de ' .. k .. ' con ' .. v)
                giveItemToPlayer(i, k, v)
            end
        end
    end
end

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

        if args[1] == nil then
            TriggerClientEvent('esx:showNotification', source, 'Debes especificar un dueño para la zona Medusa. Uso: /changeOwnerOfMedusa [nombre]')
            return
        end

        ownerOfMedusa = args[1]
        TriggerClientEvent('esx:showNotification', source, 'Has cambiado el dueño de la zona Medusa a ' .. ownerOfMedusa    )
    else
        TriggerClientEvent('esx:showNotification', source, 'No tienes permisos para ejecutar este comando.')
    end
end)

