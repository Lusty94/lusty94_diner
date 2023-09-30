local QBCore = exports['qb-core']:GetCoreObject()
local onDuty = false
PlayerJob = {}



-------------------------------------------< BLIP SECTION START >--------------------------------
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
-------------------------------------------------< BLIP SECTION END >--------------------------------






-----------------------------------------< JOB & MANAGEMENT SECTION START >-----------------------------------------



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
-------------------------------------< JOB & MANAGEMENT SECTION END >----------------------------------------------




-----------------------------------------< WASHING HANDS START >-------------------------------------

--WASHING HANDS
RegisterNetEvent("lusty94_diner:client:WashHands", function()
    if Config.CoreSettings.Sound.UseInteractSound then
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.WashingHands, 0.5)
    end
    SetEntityHeading(PlayerPedId(), Config.InteractionLocations.WashHands.Heading)
    QBCore.Functions.Progressbar("WashHands", Config.Language.WashHands.ProgressBarName, Config.CoreSettings.ProgressBar.Times.WashHands, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = Config.Animations.WashingHands.AnimDict,
        anim = Config.Animations.WashingHands.Anim,
        flags = Config.Animations.WashingHands.Flags,
    }, {}, {}, function()
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.WashHands.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.WashHands.NotifyLabel, Config.Language.WashHands.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('success', Config.Language.WashHands.NotifyName) 
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.WashHands.NotifyLabel, Config.Language.WashHands.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.WashHands.NotifyLabel, description = Config.Language.WashHands.NotifyName, type = 'success' })
        end
    end, function()
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.CancelledLabel, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledLabel, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledLabel) 
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledLabel, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledLabel, type = 'error' })
        end
    end) 
end)

-----------------------------------------< WASHING HANDS END >-------------------------------------





-------------------------------------------------< MAKE HOT DRINKS START >--------------------------------


--Prepare Tea
RegisterNetEvent("lusty94_diner:client:PrepareTea", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_Tea", Config.Language.Tea.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PrepareSmoothies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourHotDrinks.AnimDict,
                    anim = Config.Animations.PourHotDrinks.Anim,
                    flags = Config.Animations.PourHotDrinks.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateTea')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.Tea.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.Tea.NotifyLabel, Config.Language.Tea.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.Tea.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.Tea.NotifyLabel, Config.Language.Tea.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.Tea.NotifyLabel, description = Config.Language.Tea.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Coffee
RegisterNetEvent("lusty94_diner:client:PrepareCoffee", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_Coffee", Config.Language.Coffee.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PrepareSmoothies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourHotDrinks.AnimDict,
                    anim = Config.Animations.PourHotDrinks.Anim,
                    flags = Config.Animations.PourHotDrinks.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateCoffee')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.Coffee.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.Coffee.NotifyLabel, Config.Language.Coffee.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.Coffee.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.Coffee.NotifyLabel, Config.Language.Coffee.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.Coffee.NotifyLabel, description = Config.Language.Coffee.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare HotChocolate
RegisterNetEvent("lusty94_diner:client:PrepareHotChocolate", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Mug', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourHotDrinks, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_HotChocolate", Config.Language.HotChocolate.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PrepareSmoothies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourHotDrinks.AnimDict,
                    anim = Config.Animations.PourHotDrinks.Anim,
                    flags = Config.Animations.PourHotDrinks.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateHotChocolate')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.HotChocolate.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.HotChocolate.NotifyLabel, Config.Language.HotChocolate.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.HotChocolate.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.HotChocolate.NotifyLabel, Config.Language.HotChocolate.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.HotChocolate.NotifyLabel, description = Config.Language.HotChocolate.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

-------------------------------------------------< MAKE HOT DRINKS END >--------------------------------






-------------------------------------------------< MAKE SOFT DRINKS START >--------------------------------


--Prepare E-Cola
RegisterNetEvent("lusty94_diner:client:PrepareECola", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_ECola", Config.Language.ECola.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSoftDrinks, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSoftDrinks.AnimDict,
                    anim = Config.Animations.PourSoftDrinks.Anim,
                    flags = Config.Animations.PourSoftDrinks.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateECola')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.ECola.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.ECola.NotifyLabel, Config.Language.ECola.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.ECola.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.ECola.NotifyLabel, Config.Language.ECola.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.ECola.NotifyLabel, description = Config.Language.ECola.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare E-Cola Light
RegisterNetEvent("lusty94_diner:client:PrepareEColaLight", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_EColaLight", Config.Language.EColaLight.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSoftDrinks, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSoftDrinks.AnimDict,
                    anim = Config.Animations.PourSoftDrinks.Anim,
                    flags = Config.Animations.PourSoftDrinks.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateEColaLight')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.EColaLight.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.EColaLight.NotifyLabel, Config.Language.EColaLight.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.EColaLight.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.EColaLight.NotifyLabel, Config.Language.EColaLight.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.EColaLight.NotifyLabel, description = Config.Language.EColaLight.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Sprunk
RegisterNetEvent("lusty94_diner:client:PrepareSprunk", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_Sprunk", Config.Language.Sprunk.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSoftdrinks, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSoftDrinks.AnimDict,
                    anim = Config.Animations.PourSoftDrinks.Anim,
                    flags = Config.Animations.PourSoftDrinks.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateSprunk')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.Sprunk.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.Sprunk.NotifyLabel, Config.Language.Sprunk.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.Sprunk.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.Sprunk.NotifyLabel, Config.Language.Sprunk.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.Sprunk.NotifyLabel, description = Config.Language.Sprunk.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Orange Soda
RegisterNetEvent("lusty94_diner:client:PrepareOrangeSoda", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:SoftDrinksCup', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSoftDrinks, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_OrangeSoda", Config.Language.OrangeSoda.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSoftDrinks, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSoftDrinks.AnimDict,
                    anim = Config.Animations.PourSoftDrinks.Anim,
                    flags = Config.Animations.PourSoftDrinks.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateOrangeSoda')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.OrangeSoda.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.OrangeSoda.NotifyLabel, Config.Language.OrangeSoda.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.OrangeSoda.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.OrangeSoda.NotifyLabel, Config.Language.OrangeSoda.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.OrangeSoda.NotifyLabel, description = Config.Language.OrangeSoda.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)



-------------------------------------------------< MAKE SLUSHIES START >--------------------------------

--Prepare BlueRaspberrySlushie
RegisterNetEvent("lusty94_diner:client:PrepareBlueRaspberrySlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:BlueRaspberrySlushie', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_BlueRaspberrySlushie", Config.Language.BlueRaspberrySlushie.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSlushies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSlushies.AnimDict,
                    anim = Config.Animations.PourSlushies.Anim,
                    flags = Config.Animations.PourSlushies.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateBlueRaspberrySlushie')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.BlueRaspberrySlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.BlueRaspberrySlushie.NotifyLabel, Config.Language.BlueRaspberrySlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.BlueRaspberrySlushie.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.BlueRaspberrySlushie.NotifyLabel, Config.Language.BlueRaspberrySlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.BlueRaspberrySlushie.NotifyLabel, description = Config.Language.BlueRaspberrySlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Tropical Slushie
RegisterNetEvent("lusty94_diner:client:PrepareTropicalSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TropicalSlushie', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_TropicalSlushie", Config.Language.TropicalSlushie.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSlushies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSlushies.AnimDict,
                    anim = Config.Animations.PourSlushies.Anim,
                    flags = Config.Animations.PourSlushies.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateTropicalSlushie')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TropicalSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TropicalSlushie.NotifyLabel, Config.Language.TropicalSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TropicalSlushie.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TropicalSlushie.NotifyLabel, Config.Language.TropicalSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.TropicalSlushie.NotifyLabel, description = Config.Language.TropicalSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Strawberry Slushie
RegisterNetEvent("lusty94_diner:client:PrepareStrawberrySlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:StrawberrySlushie', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_StrawberrySlushie", Config.Language.StrawberrySlushie.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSlushies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSlushies.AnimDict,
                    anim = Config.Animations.PourSlushies.Anim,
                    flags = Config.Animations.PourSlushies.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateStrawberrySlushie')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.StrawberrySlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.StrawberrySlushie.NotifyLabel, Config.Language.StrawberrySlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.StrawberrySlushie.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.StrawberrySlushie.NotifyLabel, Config.Language.StrawberrySlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.StrawberrySlushie.NotifyLabel, description = Config.Language.StrawberrySlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare LemonLime Slushie
RegisterNetEvent("lusty94_diner:client:PrepareLemonLimeSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:LemonLimeSlushie', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_LemonLimeSlushie", Config.Language.LemonLimeSlushie.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSlushies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSlushies.AnimDict,
                    anim = Config.Animations.PourSlushies.Anim,
                    flags = Config.Animations.PourSlushies.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateLemonLimeSlushie')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.LemonLimeSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.LemonLimeSlushie.NotifyLabel, Config.Language.LemonLimeSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.LemonLimeSlushie.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.LemonLimeSlushie.NotifyLabel, Config.Language.LemonLimeSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.LemonLimeSlushie.NotifyLabel, description = Config.Language.LemonLimeSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Orange Slushie
RegisterNetEvent("lusty94_diner:client:PrepareOrangeSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:OrangeSlushie', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_OrangeSlushie", Config.Language.OrangeSlushie.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSlushies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSlushies.AnimDict,
                    anim = Config.Animations.PourSlushies.Anim,
                    flags = Config.Animations.PourSlushies.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateOrangeSlushie')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.OrangeSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.OrangeSlushie.NotifyLabel, Config.Language.OrangeSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.OrangeSlushie.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.OrangeSlushie.NotifyLabel, Config.Language.OrangeSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.OrangeSlushie.NotifyLabel, description = Config.Language.OrangeSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Grape Slushie
RegisterNetEvent("lusty94_diner:client:PrepareGrapeSlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:GrapeSlushie', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_GrapeSlushie", Config.Language.GrapeSlushie.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSlushies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSlushies.AnimDict,
                    anim = Config.Animations.PourSlushies.Anim,
                    flags = Config.Animations.PourSlushies.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateGrapeSlushie')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.GrapeSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.GrapeSlushie.NotifyLabel, Config.Language.GrapeSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.GrapeSlushie.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.GrapeSlushie.NotifyLabel, Config.Language.GrapeSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.GrapeSlushie.NotifyLabel, description = Config.Language.GrapeSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Cherry Slushie
RegisterNetEvent("lusty94_diner:client:PrepareCherrySlushie", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:CherrySlushie', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.PourSlushies, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_CherrySlushie", Config.Language.CherrySlushie.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourSlushies, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.PourSlushies.AnimDict,
                    anim = Config.Animations.PourSlushies.Anim,
                    flags = Config.Animations.PourSlushies.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateCherrySlushie')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.CherrySlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.CherrySlushie.NotifyLabel, Config.Language.CherrySlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.CherrySlushie.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.CherrySlushie.NotifyLabel, Config.Language.CherrySlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.CherrySlushie.NotifyLabel, description = Config.Language.CherrySlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)





-------------------------------------------------< MAKE SLUSHIES END >--------------------------------




-------------------------------------------------< SLICED INGREDIENTS START >--------------------------------

--Prepare Sliced Bread
RegisterNetEvent("lusty94_diner:client:PrepareSlicedBread", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Bread', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_slicedbread", Config.Language.SlicedBread.ProgressBarName, Config.CoreSettings.ProgressBar.Times.SliceIngredients, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.SliceIngredients.AnimDict,
                    anim = Config.Animations.SliceIngredients.Anim,
                    flags = Config.Animations.SliceIngredients.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateSlicedBread')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.SlicedBread.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.SlicedBread.NotifyLabel, Config.Language.SlicedBread.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.SlicedBread.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.SlicedBread.NotifyLabel, Config.Language.SlicedBread.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.SlicedBread.NotifyLabel, description = Config.Language.SlicedBread.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)


--Prepare Sliced Bacon
RegisterNetEvent("lusty94_diner:client:PrepareSlicedBacon", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Bacon', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_slicedbacon", Config.Language.SlicedBacon.ProgressBarName, Config.CoreSettings.ProgressBar.Times.SliceIngredients, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.SliceIngredients.AnimDict,
                    anim = Config.Animations.SliceIngredients.Anim,
                    flags = Config.Animations.SliceIngredients.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateSlicedBacon')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.SlicedBacon.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.SlicedBacon.NotifyLabel, Config.Language.SlicedBacon.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.SlicedBacon.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.SlicedBacon.NotifyLabel, Config.Language.SlicedBacon.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.SlicedBacon.NotifyLabel, description = Config.Language.SlicedBacon.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)


--Prepare TunaChunks
RegisterNetEvent("lusty94_diner:client:PrepareTunaChunks", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Tuna', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_tunachunks", Config.Language.TunaChunks.ProgressBarName, Config.CoreSettings.ProgressBar.Times.SliceIngredients, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.SliceIngredients.AnimDict,
                    anim = Config.Animations.SliceIngredients.Anim,
                    flags = Config.Animations.SliceIngredients.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateTunaChunks')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TunaChunks.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TunaChunks.NotifyLabel, Config.Language.TunaChunks.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TunaChunks.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TunaChunks.NotifyLabel, Config.Language.TunaChunks.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.TunaChunks.NotifyLabel, description = Config.Language.TunaChunks.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)


--Prepare Sliced Avocado
RegisterNetEvent("lusty94_diner:client:PrepareSlicedAvocado", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Avocado', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_Avocado", Config.Language.SlicedAvocado.ProgressBarName, Config.CoreSettings.ProgressBar.Times.SliceIngredients, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.SliceIngredients.AnimDict,
                    anim = Config.Animations.SliceIngredients.Anim,
                    flags = Config.Animations.SliceIngredients.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateSlicedAvocado')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.SlicedAvocado.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.SlicedAvocado.NotifyLabel, Config.Language.SlicedAvocado.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.SlicedAvocado.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.SlicedAvocado.NotifyLabel, Config.Language.SlicedAvocado.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.SlicedAvocado.NotifyLabel, description = Config.Language.SlicedAvocado.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Turkey Slices
RegisterNetEvent("lusty94_diner:client:PrepareTurkeySlices", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:Turkey', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.SliceIngredients, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_Avocado", Config.Language.TurkeySlices.ProgressBarName, Config.CoreSettings.ProgressBar.Times.SliceIngredients, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.SliceIngredients.AnimDict,
                    anim = Config.Animations.SliceIngredients.Anim,
                    flags = Config.Animations.SliceIngredients.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateTurkeySlices')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TurkeySlices.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TurkeySlices.NotifyLabel, Config.Language.TurkeySlices.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TurkeySlices.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TurkeySlices.NotifyLabel, Config.Language.TurkeySlices.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.TurkeySlices.NotifyLabel, description = Config.Language.TurkeySlices.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

-------------------------------------------------< SLICED INGREDIENTS END >--------------------------------





-------------------------------------------------< MAKE GRILLED SANDWICHES START >--------------------------------

--Prepare Grilled Cheese
RegisterNetEvent("lusty94_diner:client:PrepareGrilledCheese", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:GrilledCheese', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFoods, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_GrilledCheese", Config.Language.GrilledCheese.ProgressBarName, Config.CoreSettings.ProgressBar.Times.CookFoods, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.CookFood.AnimDict,
                    anim = Config.Animations.CookFood.Anim,
                    flags = Config.Animations.CookFood.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateGrilledCheese')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.GrilledCheese.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.GrilledCheese.NotifyLabel, Config.Language.GrilledCheese.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.GrilledCheese.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.GrilledCheese.NotifyLabel, Config.Language.GrilledCheese.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.GrilledCheese.NotifyLabel, description = Config.Language.GrilledCheese.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)


--Prepare Chicken & Mozzarella
RegisterNetEvent("lusty94_diner:client:PrepareChickenMozzarella", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:ChickenMozzarella', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFoods, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_ChickenMozzarella", Config.Language.ChickenMozzarella.ProgressBarName, Config.CoreSettings.ProgressBar.Times.CookFoods, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.CookFood.AnimDict,
                    anim = Config.Animations.CookFood.Anim,
                    flags = Config.Animations.CookFood.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateChickenMozzarella')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.ChickenMozzarella.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.ChickenMozzarella.NotifyLabel, Config.Language.ChickenMozzarella.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.ChickenMozzarella.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.ChickenMozzarella.NotifyLabel, Config.Language.ChickenMozzarella.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.ChickenMozzarella.NotifyLabel, description = Config.Language.ChickenMozzarella.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)


--Prepare Bacon & Avocado
RegisterNetEvent("lusty94_diner:client:PrepareBaconAvocado", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:BaconAvocado', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFoods, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_BaconAvocado", Config.Language.BaconAvocado.ProgressBarName, Config.CoreSettings.ProgressBar.Times.CookFoods, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.CookFood.AnimDict,
                    anim = Config.Animations.CookFood.Anim,
                    flags = Config.Animations.CookFood.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateBaconAvocado')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.BaconAvocado.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.BaconAvocado.NotifyLabel, Config.Language.BaconAvocado.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.BaconAvocado.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.BaconAvocado.NotifyLabel, Config.Language.BaconAvocado.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.BaconAvocado.NotifyLabel, description = Config.Language.BaconAvocado.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)


--Prepare Tuna & Sweetcorn
RegisterNetEvent("lusty94_diner:client:PrepareTunaSweetcorn", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TunaSweetcorn', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFoods, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_TunaSweetcorn", Config.Language.TunaSweetcorn.ProgressBarName, Config.CoreSettings.ProgressBar.Times.CookFoods, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.CookFood.AnimDict,
                    anim = Config.Animations.CookFood.Anim,
                    flags = Config.Animations.CookFood.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateTunaSweetcorn')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TunaSweetcorn.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TunaSweetcorn.NotifyLabel, Config.Language.TunaSweetcorn.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TunaSweetcorn.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TunaSweetcorn.NotifyLabel, Config.Language.TunaSweetcorn.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.TunaSweetcorn.NotifyLabel, description = Config.Language.TunaSweetcorn.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Prepare Turkey & Cranberry
RegisterNetEvent("lusty94_diner:client:PrepareTurkeyCranberry", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:TurkeyCranberry', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFoods, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_TurkeyCranberry", Config.Language.TurkeyCranberry.ProgressBarName, Config.CoreSettings.ProgressBar.Times.CookFoods, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.CookFood.AnimDict,
                    anim = Config.Animations.CookFood.Anim,
                    flags = Config.Animations.CookFood.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateTurkeyCranberry')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TurkeyCranberry.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TurkeyCranberry.NotifyLabel, Config.Language.TurkeyCranberry.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TurkeyCranberry.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TurkeyCranberry.NotifyLabel, Config.Language.TurkeyCranberry.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.TurkeyCranberry.NotifyLabel, description = Config.Language.TurkeyCranberry.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)


--Prepare Eggs & Bacon
RegisterNetEvent("lusty94_diner:client:PrepareEggsBacon", function()
    if onDuty then
        QBCore.Functions.TriggerCallback('lusty94_diner:get:EggsBacon', function(HasItems)  
            if HasItems then
                if Config.CoreSettings.Sound.UseInteractSound then
                    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, Config.CoreSettings.Sound.CookFoods, 0.5)
                end
                QBCore.Functions.Progressbar("prepare_EggsBacon", Config.Language.EggsBacon.ProgressBarName, Config.CoreSettings.ProgressBar.Times.CookFoods, false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = Config.Animations.CookFood.AnimDict,
                    anim = Config.Animations.CookFood.Anim,
                    flags = Config.Animations.CookFood.Flags,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('lusty94_diner:server:CreateEggsBacon')
                        if Config.CoreSettings.Notify.Type == 'qb' then
                            QBCore.Functions.Notify(Config.Language.EggsBacon.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.EggsBacon.NotifyLabel, Config.Language.EggsBacon.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif Config.CoreSettings.Notify.Type == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.EggsBacon.NotifyName)
                        elseif Config.CoreSettings.Notify.Type == 'boii' then
                            exports['boii_ui']:notify(Config.Language.EggsBacon.NotifyLabel, Config.Language.EggsBacon.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif Config.CoreSettings.Notify.Type == 'ox' then
                            lib.notify({ title = Config.Language.EggsBacon.NotifyLabel, description = Config.Language.EggsBacon.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if Config.CoreSettings.Notify.Type == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif Config.CoreSettings.Notify.Type == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif Config.CoreSettings.Notify.Type == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif Config.CoreSettings.Notify.Type == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if Config.CoreSettings.Notify.Type == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif Config.CoreSettings.Notify.Type == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif Config.CoreSettings.Notify.Type == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif Config.CoreSettings.Notify.Type == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

-------------------------------------------------< MAKE GRILLED SANDWICHES END >--------------------------------

