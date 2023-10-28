ESX = exports['es_extended']:getSharedObject()
local ActiveDimension = 0

RegisterServerEvent('GMD_Helloween:SetDimension')
AddEventHandler('GMD_Helloween:SetDimension', function()
    ActiveDimension = ActiveDimension + 1
    SetPlayerRoutingBucket(source, ActiveDimension)
    SetRoutingBucketPopulationEnabled(ActiveDimension, false)
end)

RegisterCommand("setd", function(source, args)
    SetPlayerRoutingBucket(tonumber(source), tonumber(args[1]))
    SetRoutingBucketPopulationEnabled(ActiveDimension, false)
end)

RegisterServerEvent('GMD_Helloween:GiveHelloweenLoose')
AddEventHandler('GMD_Helloween:GiveHelloweenLoose', function(Count)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('helloween_loose', Count)
end)
