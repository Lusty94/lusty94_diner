local QBCore = exports['qb-core']:GetCoreObject()
local KeysEvent = Config.CoreSettings.Vehicle.Keys
local NotifyType = Config.CoreSettings.Notify.Type
local ShopType = Config.CoreSettings.Shop.Type
local InvType = Config.CoreSettings.Inventory.Type
local TargetType = Config.CoreSettings.Target.Type
local onDuty, busy = false, false
local spawnedDinerProps = {}
PlayerJob = {}
if Config.DevMode then
    onDuty = true
end

--notification function
local function SendNotify(msg,type,time,title)
    if NotifyType == nil then print("Lusty94_Diner: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Diner" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message.") return end
    if NotifyType == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif NotifyType == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, true)
    elseif NotifyType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, msg)
    elseif NotifyType == 'boii' then
        exports['boii_ui']:notify(title, msg, type, time)
    elseif NotifyType == 'ox' then
        lib.notify({ title = title, description = msg, type = type, duration = time})
    elseif NotifyType == 'custom' then
        --insert your own notify function here
    end
end

--Blips
CreateThread(function()
    for k, v in pairs(Config.Blips) do
        if v.useblip then
            v.blip = AddBlipForCoord(v['coords'].x, v['coords'].y, v['coords'].z)
            SetBlipSprite(v.blip, v.id)
            SetBlipDisplay(v.blip, 4)
            SetBlipScale(v.blip, v.scale)
            SetBlipColour(v.blip, v.colour)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(v.title)
            EndTextCommandSetBlipName(v.blip)
        end
    end
end)



-------------< JOB STUFF >---------------------

RegisterNetEvent("lusty94_diner:client:ToggleDuty", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerJob.type == Config.CoreSettings.Job.Name then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)



------------------< EVENTS >--------------

--WASHING HANDS
RegisterNetEvent("lusty94_diner:client:WashHands", function()
    if busy then
        SendNotify("You Are Already Doing Something!", 'error', 2500)
    else
        busy = true
        LockInventory(true)
        FreezeEntityPosition(PlayerPedId(), true) 
        if Config.CoreSettings.Sound.UseInteractSound then
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.WashingHands, 0.5)
        end
        if lib.progressCircle({ duration = Config.CoreSettings.Timers.WashHands, label = 'Washing Hands...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.WashingHands.dict, clip = Config.Animations.WashingHands.anim, flag = Config.Animations.WashingHands.flag, },}) then
            busy = false
            LockInventory(false)
            ClearPedTasks(PlayerPedId())
            SendNotify("Hands washed.", 'success', 2000)
            FreezeEntityPosition(PlayerPedId(), false)
        else 
            busy = false
            LockInventory(false)
            ClearPedTasks(PlayerPedId())
            SendNotify('Action cancelled.', 'error', 2000)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end)


--Prepare Tea
RegisterNetEvent("lusty94_diner:client:PrepareTea", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourHotDrinks, label = 'Preparing drink...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourHotDrinks.dict, clip = Config.Animations.PourHotDrinks.anim, flag = Config.Animations.PourHotDrinks.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateTea')
                            SendNotify("Hot drink prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Coffee
RegisterNetEvent("lusty94_diner:client:PrepareCoffee", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourHotDrinks, label = 'Preparing drink...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourHotDrinks.dict, clip = Config.Animations.PourHotDrinks.anim, flag = Config.Animations.PourHotDrinks.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateCoffee')
                            SendNotify("Hot drink prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare HotChocolate
RegisterNetEvent("lusty94_diner:client:PrepareHotChocolate", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourHotDrinks, label = 'Preparing drink...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourHotDrinks.dict, clip = Config.Animations.PourHotDrinks.anim, flag = Config.Animations.PourHotDrinks.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateHotChocolate')
                            SendNotify("Hot drink prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare E-Cola
RegisterNetEvent("lusty94_diner:client:PrepareECola", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSoftDrinks, label = 'Preparing drink...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateECola')
                            SendNotify("Soft drink prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare E-Cola Light
RegisterNetEvent("lusty94_diner:client:PrepareEColaLight", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSoftDrinks, label = 'Preparing drink...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateEColaLight')
                            SendNotify("Soft drink prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Sprunk
RegisterNetEvent("lusty94_diner:client:PrepareSprunk", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSoftDrinks, label = 'Preparing drink...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateSprunk')
                            SendNotify("Soft drink prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Orange Soda
RegisterNetEvent("lusty94_diner:client:PrepareOrangeSoda", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSoftDrinks, label = 'Preparing drink...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateOrangeSoda')
                            SendNotify("Soft drink prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--------------------------< SLUSHIES >-------------------------

--Prepare BlueRaspberrySlushie
RegisterNetEvent("lusty94_diner:client:PrepareBlueRaspberrySlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:BlueRaspberrySlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSlushies, label = 'Preparing slushie...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateBlueRaspberrySlushie')
                            SendNotify("Slushie prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Tropical Slushie
RegisterNetEvent("lusty94_diner:client:PrepareTropicalSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TropicalSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSlushies, label = 'Preparing slushie...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateBlueRaspberrySlushie')
                            SendNotify("Slushie prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Strawberry Slushie
RegisterNetEvent("lusty94_diner:client:PrepareStrawberrySlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:StrawberrySlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSlushies, label = 'Preparing slushie...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateStrawberrySlushie')
                            SendNotify("Slushie prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare LemonLime Slushie
RegisterNetEvent("lusty94_diner:client:PrepareLemonLimeSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:LemonLimeSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSlushies, label = 'Preparing slushie...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateLemonLimeSlushie')
                            SendNotify("Slushie prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Orange Slushie
RegisterNetEvent("lusty94_diner:client:PrepareOrangeSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:OrangeSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSlushies, label = 'Preparing slushie...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateOrangeSlushie')
                            SendNotify("Slushie prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Grape Slushie
RegisterNetEvent("lusty94_diner:client:PrepareGrapeSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:GrapeSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSlushies, label = 'Preparing slushie...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateGrapeSlushie')
                            SendNotify("Slushie prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Cherry Slushie
RegisterNetEvent("lusty94_diner:client:PrepareCherrySlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:CherrySlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.PourSlushies, label = 'Preparing slushie...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateCherrySlushie')
                            SendNotify("Slushie prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--------------------< INGREDIENTS >------------------

--Prepare Sliced Bread
RegisterNetEvent("lusty94_diner:client:PrepareSlicedBread", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Bread', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.SliceIngredients, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, prop = { model = 'v_ind_cfknife', bone = 57005, pos = vec3(0.2, 0.14, -0.01), rot = vec3(1.0, 4.0, 57.0),},}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateSlicedBread')
                            SendNotify("Ingredient prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare Sliced Bacon
RegisterNetEvent("lusty94_diner:client:PrepareSlicedBacon", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Bacon', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.SliceIngredients, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, prop = { model = 'v_ind_cfknife', bone = 57005, pos = vec3(0.2, 0.14, -0.01), rot = vec3(1.0, 4.0, 57.0),},}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateSlicedBacon')
                            SendNotify("Ingredient prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare TunaChunks
RegisterNetEvent("lusty94_diner:client:PrepareTunaChunks", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Tuna', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.SliceIngredients, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, prop = { model = 'v_ind_cfknife', bone = 57005, pos = vec3(0.2, 0.14, -0.01), rot = vec3(1.0, 4.0, 57.0),},}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateTunaChunks')
                            SendNotify("Ingredient prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare Sliced Avocado
RegisterNetEvent("lusty94_diner:client:PrepareSlicedAvocado", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Avocado', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.SliceIngredients, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, prop = { model = 'v_ind_cfknife', bone = 57005, pos = vec3(0.2, 0.14, -0.01), rot = vec3(1.0, 4.0, 57.0),},}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateSlicedAvocado')
                            SendNotify("Ingredient prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Turkey Slices
RegisterNetEvent("lusty94_diner:client:PrepareTurkeySlices", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Turkey', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.SliceIngredients, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, prop = { model = 'v_ind_cfknife', bone = 57005, pos = vec3(0.2, 0.14, -0.01), rot = vec3(1.0, 4.0, 57.0),},}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateTurkeySlices')
                            SendNotify("Ingredient prepared.", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)



------------------------------< COOK FOODS >----------------------


--Prepare Grilled Cheese
RegisterNetEvent("lusty94_diner:client:PrepareGrilledCheese", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:GrilledCheese', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.CookFood, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateGrilledCheese')
                            SendNotify("Meal cooked!", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare Chicken & Mozzarella
RegisterNetEvent("lusty94_diner:client:PrepareChickenMozzarella", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:ChickenMozzarella', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.CookFood, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateChickenMozzarella')
                            SendNotify("Meal cooked!", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare Bacon & Avocado
RegisterNetEvent("lusty94_diner:client:PrepareBaconAvocado", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:BaconAvocado', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.CookFood, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateBaconAvocado')
                            SendNotify("Meal cooked!", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare Tuna & Sweetcorn
RegisterNetEvent("lusty94_diner:client:PrepareTunaSweetcorn", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TunaSweetcorn', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.CookFood, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateTunaSweetcorn')
                            SendNotify("Meal cooked!", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

--Prepare Turkey & Cranberry
RegisterNetEvent("lusty94_diner:client:PrepareTurkeyCranberry", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TurkeyCranberry', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.CookFood, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateTurkeyCranberry')
                            SendNotify("Meal cooked!", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--Prepare Eggs & Bacon
RegisterNetEvent("lusty94_diner:client:PrepareEggsBacon", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:EggsBacon', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify("You Are Already Doing Something!", 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        FreezeEntityPosition(PlayerPedId(), true) 
                        if Config.CoreSettings.Sound.UseInteractSound then
                            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ duration = Config.CoreSettings.Timers.CookFood, label = 'Preparing ingredient...', position = 'bottom', useWhileDead = false, canCancel = true, disable = { car = true, }, anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },}) then
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('lusty94_diner:server:CreateEggsBacon')
                            SendNotify("Meal cooked!", 'success', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        else 
                            busy = false
                            LockInventory(false)
                            ClearPedTasks(PlayerPedId())
                            SendNotify('Action cancelled.', 'error', 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                    else
                        SendNotify("Action failed.", 'error', 2000)
                    end
                end
            else
                SendNotify("You are missing items!", 'error', 2500)
            end
        end)
    else 
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


--------------------< CUPS >--------------

--Slushie Cup
RegisterNetEvent('lusty94_diner:client:GiveSlushieCup', function(data)
    local input = lib.inputDialog('Diner', {
        {type = 'number', label = 'Slushie Cups', description = 'How many do you need?', icon = 'arrow-right'},
      })
    if input then
        TriggerServerEvent('lusty94_diner:server:GiveSlushieCup', tonumber(input[1]))
    end
end)

--Mug
RegisterNetEvent('lusty94_diner:client:GiveMug', function(data)
    local input = lib.inputDialog('Diner', {
        {type = 'number', label = 'Mugs', description = 'How many do you need?', icon = 'arrow-right'},
      })
    if input then
        TriggerServerEvent('lusty94_diner:server:GiveMug', tonumber(input[1]))
    end
end)

--Soft Drinks Cup
RegisterNetEvent('lusty94_diner:client:GiveSoftDrinksCup', function(data)
    local input = lib.inputDialog('Diner', {
        {type = 'number', label = 'Soft Drinks Cups', description = 'How many do you need?', icon = 'arrow-right'},
      })
    if input then
        TriggerServerEvent('lusty94_diner:server:GiveSoftDrinksCup', tonumber(input[1]))
    end
end)


--------------< PROPS >-----------------

--props
CreateThread(function()
    for k,v in pairs(Config.InteractionLocations.Props) do
        RequestModel(v.Model)
        while not HasModelLoaded(v.Model) do 
            Wait(1000)
        end
        dinerProps = CreateObject(v.Model, v.Coords, true, false, false)
        spawnedDinerProps[#spawnedDinerProps+1] = dinerProps
        SetEntityHeading(dinerProps, v.Heading)
        FreezeEntityPosition(dinerProps, true)
        if TargetType == 'qb' then
            exports['qb-target']:AddTargetEntity(dinerProps, { options = { { type = "client", event = v.Event, icon = v.Icon, label = v.Label, job = v.Job, }, }, distance = v.Distance })
        elseif TargetType == 'ox' then
            exports.ox_target:addLocalEntity(dinerProps, { { name = 'dinerProps', icon = v.Icon, label = v.Label, event = v.Event, groups = v.Job, distance = v.Distance} })
        end
    end
end)


----------------------< SHOPS AND STASHES >------------------

--Ingredients Fridge
RegisterNetEvent("lusty94_diner:client:IngredientsFridge", function()
    if onDuty then
        local dinerIngredients = { -- ONLY RELEVANT TO QB-INVENTORY FOR OX_INVENTORY CHANGE THE NAMES / PRICES IN SERVER FILE
            label = "Ingredients Fridge", 
            slots = 21,
            items = {
                [1] = {name = "butter",                 price = 0, amount = 100000, info = {}, type = "item", slot = 1,},
                [2] = {name = "crushedice",             price = 0, amount = 100000, info = {}, type = "item", slot = 2,},
                [3] = {name = "balsamicglaze",          price = 0, amount = 100000, info = {}, type = "item", slot = 3,},
                [4] = {name = "cranberrysauce",         price = 0, amount = 100000, info = {}, type = "item", slot = 4,},
                [5] = {name = "mozzarellacheese",       price = 0, amount = 100000, info = {}, type = "item", slot = 5,},
                [6] = {name = "cheeseslice",            price = 0, amount = 100000, info = {}, type = "item", slot = 6,},
                [7] = {name = "bread",                  price = 0, amount = 100000, info = {}, type = "item", slot = 7,},
                [8] = {name = "eggs",                   price = 0, amount = 100000, info = {}, type = "item", slot = 8,},
                [9] = {name = "chickenbreast",          price = 0, amount = 100000, info = {}, type = "item", slot = 9,},
                [10] = {name = "turkey",                price = 0, amount = 100000, info = {}, type = "item", slot = 10,},
                [11] = {name = "bacon",                 price = 0, amount = 100000, info = {}, type = "item", slot = 11,},
                [12] = {name = "tuna",                  price = 0, amount = 100000, info = {}, type = "item", slot = 12,},
                [13] = {name = "avocado",               price = 0, amount = 100000, info = {}, type = "item", slot = 13,},
                [14] = {name = "sweetcorn",             price = 0, amount = 100000, info = {}, type = "item", slot = 14,},
                [15] = {name = "blueraspberrysyrup",    price = 0, amount = 100000, info = {}, type = "item", slot = 15,},
                [16] = {name = "tropicalsyrup",         price = 0, amount = 100000, info = {}, type = "item", slot = 16,},
                [17] = {name = "strawberrysyrup",       price = 0, amount = 100000, info = {}, type = "item", slot = 17,},
                [18] = {name = "lemonlimesyrup",        price = 0, amount = 100000, info = {}, type = "item", slot = 18,},
                [19] = {name = "orangesyrup",           price = 0, amount = 100000, info = {}, type = "item", slot = 19,},
                [20] = {name = "grapesyrup",            price = 0, amount = 100000, info = {}, type = "item", slot = 20,},
                [21] = {name = "cherrysyrup",           price = 0, amount = 100000, info = {}, type = "item", slot = 21,},
            },
        }
        if ShopType == 'qb' then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "Ingredients", dinerIngredients)
        elseif ShopType == 'jim' then
            TriggerServerEvent("jim-shops:ShopOpen", "shop", "Ingredients", dinerIngredients)
        elseif ShopType == 'ox' then
            exports.ox_inventory:openInventory('shop', { type = 'dinerIngredients' })
        end
    else
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


AddEventHandler("lusty94_diner:client:SnackShelf", function()
    local dinerSnacks = { -- ONLY RELEVANT TO QB-INVENTORY FOR OX_INVENTORY CHANGE THE NAMES / PRICES IN SERVER FILE
        label = "Pops Diner Snacks", 
        slots = 7,
        items = {
            [1] = {name = "vanillacupcake",     price = 10, amount = 100000, info = {}, type = "item", slot = 1,},
            [2] = {name = "chocolatecupcake",   price = 10, amount = 100000, info = {}, type = "item", slot = 2,},
            [3] = {name = "chocolatebar",       price = 10, amount = 100000, info = {}, type = "item", slot = 3,},
            [4] = {name = "jamdoughnut",        price = 10, amount = 100000, info = {}, type = "item", slot = 4,},
            [5] = {name = "sugardoughnut",      price = 10, amount = 100000, info = {}, type = "item", slot = 5,},
            [6] = {name = "custarddoughnut",    price = 10, amount = 100000, info = {}, type = "item", slot = 6,},
            [7] = {name = "chocolatedoughnut",  price = 10, amount = 100000, info = {}, type = "item", slot = 7,},
        },
    }
    if ShopType == 'qb' then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "SnackShelf", dinerSnacks)
    elseif ShopType == 'jim' then
        TriggerServerEvent("jim-shops:ShopOpen", "shop", "SnackShelf", dinerSnacks)
    elseif ShopType == 'ox' then
        exports.ox_inventory:openInventory('shop', { type = 'dinerSnacks' })
    end
end)



--Storage Fridge
RegisterNetEvent("lusty94_diner:client:StorageFridge", function()
    if onDuty then
        if InvType == 'qb' then
            local stashInfo = { maxweight = 1000000, slots = 64 }
            TriggerEvent("inventory:client:SetCurrentStash", "dinerstoragefridge")
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "dinerstoragefridge", {
                maxweight = stashInfo.maxweight,
                slots = stashInfo.slots,
            })
        elseif InvType == 'ox' then
            exports.ox_inventory:openInventory('stash', 'dinerstoragefridge')
        end
    else
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)


RegisterNetEvent("lusty94_diner:client:OpenCollectionTray", function()
    if InvType == 'qb' then
        local stashInfo = { maxweight = 100000, slots = 6 }
        TriggerEvent("inventory:client:SetCurrentStash", "dinercollectiontray")
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "dinercollectiontray", {
            maxweight = stashInfo.maxweight,
            slots = stashInfo.slots,
        })
    elseif InvType == 'ox' then
        exports.ox_inventory:openInventory('stash', 'dinercollectiontray')
    end
end)


----------------------< BILLING >------------------

RegisterNetEvent("lusty94_diner:client:bill")
AddEventHandler("lusty94_diner:bill", function()
        if onDuty then
            local bill = exports['qb-input']:ShowInput({
                header = "Create Invoice",
                submitText = "Send Invoice",
                inputs = {
                    {
                        text = "Server ID(#)",
                        name = "citizenid", -- name of the input should be unique otherwise it might override
                        type = "text", -- type of the input
                        isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                    },
                    {
                        text = "Total Bill Price:", -- text you want to be displayed as a place holder
                        name = "billprice", -- name of the input should be unique otherwise it might override
                        type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                        isRequired = true -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                    }
                    
                }
            })
            if bill ~= nil then
                if bill.citizenid == nil or bill.billprice == nil then 
                    return 
                end
                TriggerServerEvent("lusty94_diner:server:bill:player", bill.citizenid, bill.billprice)
            end
        else
            SendNotify("You must be on duty to proceed!", 'error', 2500)
        end
end)


----------------------< WORK VEHICLE >------------------

RegisterNetEvent('lusty94_diner:client:RentVehicle', function()
    if onDuty then
        local vehName = Config.CoreSettings.Vehicle.Name
        local vehCoords = Config.CoreSettings.Vehicle.SpawnCoords
        QBCore.Functions.SpawnVehicle(vehName, function(veh)
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleNumberPlateText(veh, 'diner')
            SetVehicleFuelLevel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent(KeysEvent, QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, vehCoords, true)
    else
        SendNotify("You must be on duty to proceed!", 'error', 2500)
    end
end)

RegisterNetEvent('lusty94_diner:client:ReturnVehicle', function()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsUsing(ped)
        if veh ~= 0 then
            SetEntityAsMissionEntity(veh, true, true)
            DeleteVehicle(veh)
        else
            local pcoords = GetEntityCoords(ped)
            local vehicles = GetGamePool('CVehicle')
            for _, v in pairs(vehicles) do
                if #(pcoords - GetEntityCoords(v)) <= 5.0 then
                    SetEntityAsMissionEntity(v, true, true)
                    DeleteVehicle(v)
                end
            end
        end
end)





-- function to lock inventory to prevent exploits
function LockInventory(toggle) -- big up to jim for how to do this
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true) -- used by qb, ps and ox
        --this is the old method below

        --[[         
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
            TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", true, true)
        end         
        ]]
    else 
        LocalPlayer.state:set("inv_busy", false, true) -- used by qb, ps and ox
        --this is the old method below
        --[[        
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
         TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", false, true)
        end        
        ]]
    end
end

--delete props and targets
local function deleteDinerProps()
    for _, v in pairs(spawnedDinerProps) do SetEntityAsMissionEntity(v, false, true) DeleteObject(v) end print('Diner Props - Objects Deleted')
    for k,v in pairs(Config.InteractionLocations.Props) do
        if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(dinerProps, 'dinerProps') elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(dinerProps, 'dinerProps') end print('Diner Props - Targets Removed')
    end
end


--dont touch
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        deleteDinerProps()
        busy = false
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Diner V2.0.0 Stopped Successfully ^5--<^3!^5>--^7')
    end
end)


