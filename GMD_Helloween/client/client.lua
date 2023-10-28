ESX = exports['es_extended']:getSharedObject()

local PropCoords = {}
local PorpName
local PlayerInGame = false

local HelpDistance = 15

RegisterCommand('testmov', function(source, args)
	SendNUIMessage({
        type = "screem"
    })
end, false)

function ScreamShock()
    SendNUIMessage({
        type = "screem"
    })
end
-- LOOPS

CreateThread(function()
    SpawnEnterNPC()
end)

local EnteredRadius = false

CreateThread(function()
    while true do
        for k, v in ipairs(Config.NPC) do
            Wait(0)
            EnteredRadius = false
            local dist = #(GetEntityCoords(PlayerPedId()) - vector3(v.Coords))

            if dist <= 3.0 then
                EnteredRadius = true
                ESX.ShowHelpNotification(Config.Language[Config.Locale]['press_interact'])
                if IsControlJustReleased(0, 38) then
                    CheckPlayerAction(v)
                end
            end
        end

        if not EnteredRadius then
            Wait(1000)
        end
    end
end)

CreateThread(function()
    local collectingProp = false

    while true do
        Wait(1)

        if #PropCoords > 0 and not collectingProp then
            for k, v in pairs(PropCoords) do
                local dist = #(GetEntityCoords(PlayerPedId()) - vector3(v.x, v.y, v.z))

                if dist <= HelpDistance then
                    showsubtitle(Config.Language[Config.Locale]['near_artifact'], 2000)

                    if dist <= 2.0 then
                        ESX.ShowHelpNotification(Config.Language[Config.Locale]['press_investigate'])
                        
                        if IsControlJustReleased(0, 38) then
                            collectingProp = true
                            TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_KNEEL', 6000, false)
                            SearchTask('mini@repair', 'fixing_a_ped', 5000)
                            Wait(1500)
                            local closestProp = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, GetHashKey(PorpName), false)

                            if DoesEntityExist(closestProp) then
                                DeleteObject(closestProp)
                                table.remove(PropCoords, k)
                                showsubtitle(Config.Language[Config.Locale]['search_counter']:format(#PropCoords), 3000)
                                Wait(1500)
                            end

                            ClearPedTasks(PlayerPedId())

                            local randomNumber = math.random(1, 2)
                            if randomNumber == 1 then
                                ScreamShock()
                            end
                            
                            collectingProp = false

                            if #PropCoords == 0 then
                                local playerPed = PlayerPedId()
                                local randomCount = math.random(1, 5)
                                showsubtitle(Config.Language[Config.Locale]['search_finished'], 2500)
                                Wait(1000)
                                DoScreenFadeOut(2500)
                                Wait(3500)
                                SetEntityCoords(playerPed, -1700.025, -217.255, 57.532, false, false, false, false)
                                SetEntityHeading(playerPed, 178.235)
                                ClearPedTasksImmediately(playerPed)
                                SetPedMotionBlur(playerPed, false)
                                ClearPedTasks(playerPed)
                                ClearTimecycleModifier()
                                SetArtificialLightsState(false)
                                SetWeatherTypeNowPersist("CLEAR")
                                ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 0.0)
                                Wait(5000)
                                DoScreenFadeIn(3000)
                                Wait(3500)
                                showsubtitle(Config.Language[Config.Locale]['doctor_voice_line_3'], 2500)
                                TriggerServerEvent('GMD_Helloween:GiveHelloweenLoose', randomCount)
                                PlayerInGame = false
                                Wait(1000)
                            end
                        end
                    end
                end
            end
        else
            Wait(5000)
        end
    end
end)


CreateThread(function()
    while true do
        Wait(500)
        if not PlayerInGame then
            local ped = PlayerPedId()
            local distance = #(GetEntityCoords(ped) - vector3(-1724.858, -192.280, 60.091))
            if distance <= 135 then
                SetWeatherTypeNowPersist("FOGGY")
            else
                SetWeatherTypeNowPersist("CLEAR")
            end
        end
    end 
end)


-- FUNCTIONS

function showsubtitle(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end


function SearchTask(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end


function CheckPlayerAction(NPCAction)
    if NPCAction.Type == 'Search' then
        StartSearch(NPCAction)
    end
end

function StartSearch(NPCAction)
    local playerPed = PlayerPedId()
    PlayerInGame = true
    showsubtitle(Config.Language[Config.Locale]['doctor_voice_line_1'], 3000)
    Wait(3000)
    showsubtitle(Config.Language[Config.Locale]['doctor_voice_line_2']:format(NPCAction.PropCount), 3000)
    Wait(1000)
    DoScreenFadeOut(3000)
    Wait(3000)
    TriggerServerEvent('GMD_Helloween:SetDimension')
    SetEntityCoords(playerPed, -1703.126, -239.069, 54.715, false, false, false, false)
    SetEntityHeading(playerPed, 117.302)
    SetArtificialLightsState(true)
    SetWeatherTypeNowPersist("HALLOWEEN")
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    ClearPedTasksImmediately(playerPed)
    SetPedMotionBlur(playerPed, true)
    SetTimecycleModifier("spectator5")
    ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
    AnimpostfxPlay("Rampage", 10000001, true)
    SpawnSearchProps(NPCAction)
    Wait(1000)
    DoScreenFadeIn(3000)
    Wait(3500)
end

function SpawnSearchProps(NPCAction)
    local shuffled = {}

    for i = 1, NPCAction.PropCount do
        local randIndex = math.random(1, #NPCAction.SpawnCoordsProps)
        table.insert(shuffled, NPCAction.SpawnCoordsProps[randIndex])
        table.remove(NPCAction.SpawnCoordsProps, randIndex)
    end

    PropCoords = shuffled
    PorpName = NPCAction.PropName
    for k, coord in ipairs(shuffled) do
        PropSpawn = CreateObject(GetHashKey(NPCAction.PropName), coord.x, coord.y, coord.z + 0.2, false, false)
        local randomHeading = math.random() * 360
        SetEntityHeading(PropSpawn, randomHeading)
        FreezeEntityPosition(PropSpawn, true)
        PlaceObjectOnGroundProperly(PropSpawn)
    end
end

function SpawnEnterNPC()
    for k, v in ipairs(Config.NPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(15)
        end

        local ped = CreatePed(4, GetHashKey(v.model), v.Coords, 3374176, false, true)
        SetEntityHeading(ped, v.heading)
        PlaceObjectOnGroundProperly(ped)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end
end