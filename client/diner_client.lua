local QBCore = exports['qb-core']:GetCoreObject()
local KeysEvent = Config.CoreSettings.Vehicle.Keys
local NotifyType = Config.CoreSettings.Notify.Type
local InvType = Config.CoreSettings.Inventory.Type
local TargetType = Config.CoreSettings.Target.Type
local UseSound = Config.CoreSettings.Sound.UseInteractSound
local onDuty, busy, vehicleRented = false, false, false
local spawnedDinerProps = {}
PlayerJob = {}

if Config.DevMode then
    onDuty = true
end



--notification function
local function SendNotify(msg,type,time,title)
    if NotifyType == nil then print('Lusty94_Diner: NotifyType Not Set in Config.CoreSettings.Notify.Type!') return end
    if not title then title = 'Diner' end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print('Notification Sent With No Message.') return end
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
            v.blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
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






------------------< EVENTS >--------------

--WASHING HANDS
RegisterNetEvent('lusty94_diner:client:WashHands', function()
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
    else
        busy = true
        LockInventory(true)
        if UseSound then
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.WashingHands, 0.5)
        end
        if lib.progressCircle({ 
            duration = Config.CoreSettings.Timers.WashHands, 
            label = Config.Language.ProgressBar.WashHands, 
            position = 'bottom', 
            useWhileDead = false, 
            canCancel = true, 
            disable = { car = true, move = true, }, 
            anim = { dict = Config.Animations.WashingHands.dict, clip = Config.Animations.WashingHands.anim, flag = Config.Animations.WashingHands.flag, },
        }) then
            busy = false
            LockInventory(false)
        else 
            busy = false
            LockInventory(false)
            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
        end
    end
end)


--Prepare Tea
RegisterNetEvent('lusty94_diner:client:PrepareTea', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourHotDrinks, 
                            label = Config.Language.ProgressBar.PrepareDrinks, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourHotDrinks.dict, clip = Config.Animations.PourHotDrinks.anim, flag = Config.Animations.PourHotDrinks.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateTea')
                            SendNotify(Config.Language.Notifications.DrinkPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Coffee
RegisterNetEvent('lusty94_diner:client:PrepareCoffee', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourHotDrinks, 
                            label = Config.Language.ProgressBar.PrepareDrinks, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourHotDrinks.dict, clip = Config.Animations.PourHotDrinks.anim, flag = Config.Animations.PourHotDrinks.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateCoffee')
                            SendNotify(Config.Language.Notifications.DrinkPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare HotChocolate
RegisterNetEvent('lusty94_diner:client:PrepareHotChocolate', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourHotDrinks, 
                            label = Config.Language.ProgressBar.PrepareDrinks, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourHotDrinks.dict, clip = Config.Animations.PourHotDrinks.anim, flag = Config.Animations.PourHotDrinks.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateHotChocolate')
                            SendNotify(Config.Language.Notifications.DrinkPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare E-Cola
RegisterNetEvent('lusty94_diner:client:PrepareECola', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSoftDrinks, 
                            label = Config.Language.ProgressBar.PrepareDrinks, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateECola')
                            SendNotify(Config.Language.Notifications.DrinkPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare E-Cola Light
RegisterNetEvent('lusty94_diner:client:PrepareEColaLight', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSoftDrinks, 
                            label = Config.Language.ProgressBar.PrepareDrinks, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateEColaLight')
                            SendNotify(Config.Language.Notifications.DrinkPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Sprunk
RegisterNetEvent('lusty94_diner:client:PrepareSprunk', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSoftDrinks, 
                            label = Config.Language.ProgressBar.PrepareDrinks, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateSprunk')
                            SendNotify(Config.Language.Notifications.DrinkPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Orange Soda
RegisterNetEvent('lusty94_diner:client:PrepareOrangeSoda', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSoftDrinks, 
                            label = Config.Language.ProgressBar.PrepareDrinks, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourSoftDrinks.dict, clip = Config.Animations.PourSoftDrinks.anim, flag = Config.Animations.PourSoftDrinks.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateOrangeSoda')
                            SendNotify(Config.Language.Notifications.DrinkPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--------------------------< SLUSHIES >-------------------------

--Prepare BlueRaspberrySlushie
RegisterNetEvent('lusty94_diner:client:PrepareBlueRaspberrySlushie', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:BlueRaspberrySlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSlushies, 
                            label = Config.Language.ProgressBar.PrepareSlushie, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, },
                            anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateBlueRaspberrySlushie')
                            SendNotify(Config.Language.Notifications.SlushiePrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Tropical Slushie
RegisterNetEvent('lusty94_diner:client:PrepareTropicalSlushie', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TropicalSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSlushies, 
                            label = Config.Language.ProgressBar.PrepareSlushie, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, },
                            anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateBlueRaspberrySlushie')
                            SendNotify(Config.Language.Notifications.SlushiePrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Strawberry Slushie
RegisterNetEvent('lusty94_diner:client:PrepareStrawberrySlushie', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:StrawberrySlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSlushies, 
                            label = Config.Language.ProgressBar.PrepareSlushie, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, },
                            anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateStrawberrySlushie')
                            SendNotify(Config.Language.Notifications.SlushiePrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare LemonLime Slushie
RegisterNetEvent('lusty94_diner:client:PrepareLemonLimeSlushie', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:LemonLimeSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSlushies, 
                            label = Config.Language.ProgressBar.PrepareSlushie, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, },
                            anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateLemonLimeSlushie')
                            SendNotify(Config.Language.Notifications.SlushiePrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Orange Slushie
RegisterNetEvent('lusty94_diner:client:PrepareOrangeSlushie', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:OrangeSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSlushies, 
                            label = Config.Language.ProgressBar.PrepareSlushie, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, },
                            anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateOrangeSlushie')
                            SendNotify(Config.Language.Notifications.SlushiePrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Grape Slushie
RegisterNetEvent('lusty94_diner:client:PrepareGrapeSlushie', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:GrapeSlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSlushies, 
                            label = Config.Language.ProgressBar.PrepareSlushie, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateGrapeSlushie')
                            SendNotify(Config.Language.Notifications.SlushiePrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Cherry Slushie
RegisterNetEvent('lusty94_diner:client:PrepareCherrySlushie', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:CherrySlushie', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.PourSlushies, 
                            label = Config.Language.ProgressBar.PrepareSlushie, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, },
                            anim = { dict = Config.Animations.PourSlushies.dict, clip = Config.Animations.PourSlushies.anim, flag = Config.Animations.PourSlushies.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateCherrySlushie')
                            SendNotify(Config.Language.Notifications.SlushiePrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--------------------< INGREDIENTS >------------------

--Prepare Sliced Bread
RegisterNetEvent('lusty94_diner:client:PrepareSlicedBread', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Bread', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.SliceIngredients, 
                            label = Config.Language.ProgressBar.PrepareIngredients, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true,}, 
                            anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, 
                            prop = { model = Config.Animations.SliceIngredients.prop, bone = Config.Animations.SliceIngredients.bone, pos = Config.Animations.SliceIngredients.pos, rot = Config.Animations.SliceIngredients.rot,},
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateSlicedBread')
                            SendNotify(Config.Language.Notifications.IngredientPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare Sliced Bacon
RegisterNetEvent('lusty94_diner:client:PrepareSlicedBacon', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Bacon', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.SliceIngredients, 
                            label = Config.Language.ProgressBar.PrepareIngredients, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true,}, 
                            anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, 
                            prop = { model = Config.Animations.SliceIngredients.prop, bone = Config.Animations.SliceIngredients.bone, pos = Config.Animations.SliceIngredients.pos, rot = Config.Animations.SliceIngredients.rot,},
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateSlicedBacon')
                            SendNotify(Config.Language.Notifications.IngredientPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare TunaChunks
RegisterNetEvent('lusty94_diner:client:PrepareTunaChunks', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Tuna', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.SliceIngredients, 
                            label = Config.Language.ProgressBar.PrepareIngredients, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, 
                            prop = { model = Config.Animations.SliceIngredients.prop, bone = Config.Animations.SliceIngredients.bone, pos = Config.Animations.SliceIngredients.pos, rot = Config.Animations.SliceIngredients.rot,},
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateTunaChunks')
                            SendNotify(Config.Language.Notifications.IngredientPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare Sliced Avocado
RegisterNetEvent('lusty94_diner:client:PrepareSlicedAvocado', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Avocado', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.SliceIngredients, 
                            label = Config.Language.ProgressBar.PrepareIngredients, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, 
                            prop = { model = Config.Animations.SliceIngredients.prop, bone = Config.Animations.SliceIngredients.bone, pos = Config.Animations.SliceIngredients.pos, rot = Config.Animations.SliceIngredients.rot,},
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateSlicedAvocado')
                            SendNotify(Config.Language.Notifications.IngredientPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Turkey Slices
RegisterNetEvent('lusty94_diner:client:PrepareTurkeySlices', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Turkey', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.SliceIngredients, 
                            label = Config.Language.ProgressBar.PrepareIngredients, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.SliceIngredients.dict, clip = Config.Animations.SliceIngredients.anim, flag = Config.Animations.SliceIngredients.flag, }, 
                            prop = { model = Config.Animations.SliceIngredients.prop, bone = Config.Animations.SliceIngredients.bone, pos = Config.Animations.SliceIngredients.pos, rot = Config.Animations.SliceIngredients.rot,},
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateTurkeySlices')
                            SendNotify(Config.Language.Notifications.IngredientPrepared, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)



------------------------------< COOK FOODS >----------------------


--Prepare Grilled Cheese
RegisterNetEvent('lusty94_diner:client:PrepareGrilledCheese', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:GrilledCheese', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.CookFood, 
                            label = Config.Language.ProgressBar.CookFood, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateGrilledCheese')
                            SendNotify(Config.Language.Notifications.FoodCooked, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare Chicken & Mozzarella
RegisterNetEvent('lusty94_diner:client:PrepareChickenMozzarella', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:ChickenMozzarella', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.CookFood, 
                            label = Config.Language.ProgressBar.CookFood, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateChickenMozzarella')
                            SendNotify(Config.Language.Notifications.FoodCooked, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare Bacon & Avocado
RegisterNetEvent('lusty94_diner:client:PrepareBaconAvocado', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:BaconAvocado', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.CookFood, 
                            label = Config.Language.ProgressBar.CookFood, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateBaconAvocado')
                            SendNotify(Config.Language.Notifications.FoodCooked, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare Tuna & Sweetcorn
RegisterNetEvent('lusty94_diner:client:PrepareTunaSweetcorn', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TunaSweetcorn', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.CookFood, 
                            label = Config.Language.ProgressBar.CookFood, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateTunaSweetcorn')
                            SendNotify(Config.Language.Notifications.FoodCooked, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--Prepare Turkey & Cranberry
RegisterNetEvent('lusty94_diner:client:PrepareTurkeyCranberry', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TurkeyCranberry', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.CookFood, 
                            label = Config.Language.ProgressBar.CookFood, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateTurkeyCranberry')
                            SendNotify(Config.Language.Notifications.FoodCooked, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)


--Prepare Eggs & Bacon
RegisterNetEvent('lusty94_diner:client:PrepareEggsBacon', function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:EggsBacon', function(HasItems)  
            if HasItems then
                if busy then
                    SendNotify(Config.Language.Notifications.Busy, 'error', 2500)
                else
                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'}, {'e'})
                    if success then
                        busy = true
                        LockInventory(true)
                        if UseSound then
                            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10, Config.CoreSettings.Sound.CookFood, 0.5)
                        end
                        if lib.progressCircle({ 
                            duration = Config.CoreSettings.Timers.CookFood, 
                            label = Config.Language.ProgressBar.CookFood, 
                            position = 'bottom', 
                            useWhileDead = false, 
                            canCancel = true, 
                            disable = { car = true, move = true, }, 
                            anim = { dict = Config.Animations.CookFood.dict, clip = Config.Animations.CookFood.anim, flag = Config.Animations.CookFood.flag, },
                        }) then
                            TriggerServerEvent('lusty94_diner:server:CreateEggsBacon')
                            SendNotify(Config.Language.Notifications.FoodCooked, 'success', 2000)
                            busy = false
                            LockInventory(false)
                        else 
                            busy = false
                            LockInventory(false)
                            SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                        end
                    else
                        SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                    end
                end
            else
                SendNotify(Config.Language.Notifications.NoItems, 'error', 2500)
            end
        end)
    else 
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
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
        lib.requestModel(v.Model, 5000)
        dinerProps = CreateObject(v.Model, v.Coords, true, false, false)
        spawnedDinerProps[#spawnedDinerProps+1] = dinerProps
        SetEntityHeading(dinerProps, v.Heading)
        FreezeEntityPosition(dinerProps, true)
        if TargetType == 'qb' then
            exports['qb-target']:AddTargetEntity(dinerProps, { options = { { type = 'client', event = v.Event, icon = v.Icon, label = v.Label, job = v.Job, }, }, distance = v.Distance })
        elseif TargetType == 'ox' then
            exports.ox_target:addLocalEntity(dinerProps, { { name = 'dinerProps', icon = v.Icon, label = v.Label, event = v.Event, groups = v.Job, distance = v.Distance} })
        end
    end
end)


----------------------< SHOPS AND STASHES >------------------

--Ingredients Fridge
RegisterNetEvent('lusty94_diner:client:IngredientsFridge', function()
    if onDuty then
        if InvType == 'qb' then
            TriggerServerEvent('lusty94_diner:server:IngredientsShop')
        elseif InvType == 'ox' then
            exports.ox_inventory:openInventory('shop', { type = 'dinerIngredients' })
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--snack shop
RegisterNetEvent('lusty94_diner:client:SnackShelf', function()
    if onDuty then
        if InvType == 'qb' then
            TriggerServerEvent('lusty94_diner:server:SnackShop')
        elseif InvType == 'ox' then
            exports.ox_inventory:openInventory('shop', { type = 'dinerSnacks' })
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)



--storage fridge
RegisterNetEvent('lusty94_diner:client:StorageFridge', function()
    if onDuty then
        if InvType == 'qb' then
            TriggerServerEvent('lusty94_diner:server:StorageFridge')
        elseif InvType == 'ox' then
            exports.ox_inventory:openInventory('stash', 'dinerstoragefridge')
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
    end
end)

--colection tray
RegisterNetEvent('lusty94_diner:client:OpenCollectionTray', function()
    if InvType == 'qb' then
        TriggerServerEvent('lusty94_diner:server:CollectionTray')
    elseif InvType == 'ox' then
        exports.ox_inventory:openInventory('stash', 'dinercollectiontray')
    end
end)


----------------------< BILLING >------------------

RegisterNetEvent('lusty94_diner:client:bill')
AddEventHandler('lusty94_diner:bill', function()
    if onDuty then
        local bill = lib.inputDialog('Register', {
            {type = 'input',    label = 'Citizen ID', description = 'Players Citizen ID',       icon = 'hashtag'},
            {type = 'number',   label = 'Bill Price', description = 'The Bills Total Price',    icon = 'dollar-sign'}
        })
        if bill ~= nil then
            if bill[1] == nil or bill[2] == nil then
                return
            end
            TriggerServerEvent('lusty94_diner:server:bill:player', bill[1], bill[2])
        end
    else
        SendNotify(Config.Language.Notifications.Duty, 'error', 2000)
    end
end)


----------------------< WORK VEHICLE >------------------

RegisterNetEvent('lusty94_diner:client:RentVehicle', function()
    if vehicleRented then
        SendNotify(Config.Language.Notifications.VehicleRented, 'error', 2500)
    else
        if onDuty then
            local playerPed = PlayerPedId()
            local vehName = Config.CoreSettings.Vehicle.Name
            local vehCoords = Config.CoreSettings.Vehicle.SpawnCoords
            QBCore.Functions.SpawnVehicle(vehName, function(veh)
                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleNumberPlateText(veh, 'diner')
                SetVehicleFuelLevel(veh, 100.0)
                TaskWarpPedIntoVehicle(playerPed, veh, -1)
                TriggerEvent(KeysEvent, QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehCoords, true)
        else
            SendNotify(Config.Language.Notifications.Duty, 'error', 2500)
        end
    end
end)

RegisterNetEvent('lusty94_diner:client:ReturnVehicle', function()
    local playerPed = PlayerPedId()
    local veh = GetVehiclePedIsUsing(playerPed)
    vehicleRented = false
    if veh ~= 0 then
        SetEntityAsMissionEntity(veh, true, true)
        DeleteVehicle(veh)
    else
        local pcoords = GetEntityCoords(playerPed)
        local vehicles = GetGamePool('CVehicle')
        for _, v in pairs(vehicles) do
            if #(pcoords - GetEntityCoords(v)) <= 5.0 then
                SetEntityAsMissionEntity(v, true, true)
                DeleteVehicle(v)
            end
        end
    end
end)


-------------< JOB STUFF >---------------------

RegisterNetEvent('lusty94_diner:client:ToggleDuty', function()
    TriggerServerEvent('QBCore:ToggleDuty')
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerJob.type == Config.CoreSettings.Job.Name then
                TriggerServerEvent('QBCore:ToggleDuty')
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


--------------------< DONT TOUCH >---------------------

-- function to lock inventory to prevent exploits
function LockInventory(toggle) -- big up to jim for how to do this
	if toggle then
        LocalPlayer.state:set('inv_busy', true, true) -- used by qb, ps and ox
        --this is the old method below
        --[[         
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
            TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        elseif InvType == 'ox' then
            LocalPlayer.state:set('inv_busy', true, true)
        end         
        ]]
    else 
        LocalPlayer.state:set('inv_busy', false, true) -- used by qb, ps and ox
        --this is the old method below
        --[[        
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
         TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        elseif InvType == 'ox' then
            LocalPlayer.state:set('inv_busy', false, true)
        end        
        ]]
    end
end

--function to display item images
function ItemImage(img)
	if InvType == 'ox' then
		return 'nui://ox_inventory/web/images/'.. img.. '.png'
	elseif InvType == 'qb' then
		return 'nui://qb-inventory/html/images/'.. QBCore.Shared.Items[img].image
	end
end


--dont touch
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        busy = false
        vehicleRented = false
        LockInventory(false)
        for _, v in pairs(spawnedDinerProps) do SetEntityAsMissionEntity(v, false, true) DeleteObject(v) end
        for k,v in pairs(Config.InteractionLocations.Props) do if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(dinerProps, 'dinerProps') elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(dinerProps, 'dinerProps') end end
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Diner V2.0.1 Stopped Successfully ^5--<^3!^5>--^7')
    end
end)