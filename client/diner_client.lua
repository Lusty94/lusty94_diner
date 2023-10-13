local QBCore = exports['qb-core']:GetCoreObject()
local onDuty = false
PlayerJob = {}
local FuelScript = Config.CoreSettings.EventNames.Fuel
local KeysEvent = Config.CoreSettings.EventNames.Keys
local NotifyType = Config.CoreSettings.Notify.Type
local ShopType = Config.CoreSettings.Shop.Type


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
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.WashHands.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.WashHands.NotifyLabel, Config.Language.WashHands.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('success', Config.Language.WashHands.NotifyName) 
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.WashHands.NotifyLabel, Config.Language.WashHands.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.WashHands.NotifyLabel, description = Config.Language.WashHands.NotifyName, type = 'success' })
        end
    end, function()
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.CancelledLabel, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledLabel, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledLabel) 
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledLabel, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                QBCore.Functions.Progressbar("prepare_Tea", Config.Language.Tea.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourHotDrinks, false, false, {
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.Tea.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.Tea.NotifyLabel, Config.Language.Tea.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.Tea.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.Tea.NotifyLabel, Config.Language.Tea.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.Tea.NotifyLabel, description = Config.Language.Tea.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                QBCore.Functions.Progressbar("prepare_Coffee", Config.Language.Coffee.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourHotDrinks, false, false, {
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.Coffee.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.Coffee.NotifyLabel, Config.Language.Coffee.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.Coffee.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.Coffee.NotifyLabel, Config.Language.Coffee.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.Coffee.NotifyLabel, description = Config.Language.Coffee.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                QBCore.Functions.Progressbar("prepare_HotChocolate", Config.Language.HotChocolate.ProgressBarName, Config.CoreSettings.ProgressBar.Times.PourHotDrinks, false, false, {
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.HotChocolate.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.HotChocolate.NotifyLabel, Config.Language.HotChocolate.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.HotChocolate.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.HotChocolate.NotifyLabel, Config.Language.HotChocolate.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.HotChocolate.NotifyLabel, description = Config.Language.HotChocolate.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.ECola.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.ECola.NotifyLabel, Config.Language.ECola.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.ECola.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.ECola.NotifyLabel, Config.Language.ECola.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.ECola.NotifyLabel, description = Config.Language.ECola.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.EColaLight.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.EColaLight.NotifyLabel, Config.Language.EColaLight.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.EColaLight.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.EColaLight.NotifyLabel, Config.Language.EColaLight.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.EColaLight.NotifyLabel, description = Config.Language.EColaLight.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.Sprunk.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.Sprunk.NotifyLabel, Config.Language.Sprunk.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.Sprunk.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.Sprunk.NotifyLabel, Config.Language.Sprunk.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.Sprunk.NotifyLabel, description = Config.Language.Sprunk.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.OrangeSoda.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.OrangeSoda.NotifyLabel, Config.Language.OrangeSoda.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.OrangeSoda.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.OrangeSoda.NotifyLabel, Config.Language.OrangeSoda.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.OrangeSoda.NotifyLabel, description = Config.Language.OrangeSoda.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.BlueRaspberrySlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.BlueRaspberrySlushie.NotifyLabel, Config.Language.BlueRaspberrySlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.BlueRaspberrySlushie.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.BlueRaspberrySlushie.NotifyLabel, Config.Language.BlueRaspberrySlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.BlueRaspberrySlushie.NotifyLabel, description = Config.Language.BlueRaspberrySlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TropicalSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TropicalSlushie.NotifyLabel, Config.Language.TropicalSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TropicalSlushie.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TropicalSlushie.NotifyLabel, Config.Language.TropicalSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.TropicalSlushie.NotifyLabel, description = Config.Language.TropicalSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.StrawberrySlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.StrawberrySlushie.NotifyLabel, Config.Language.StrawberrySlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.StrawberrySlushie.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.StrawberrySlushie.NotifyLabel, Config.Language.StrawberrySlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.StrawberrySlushie.NotifyLabel, description = Config.Language.StrawberrySlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.LemonLimeSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.LemonLimeSlushie.NotifyLabel, Config.Language.LemonLimeSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.LemonLimeSlushie.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.LemonLimeSlushie.NotifyLabel, Config.Language.LemonLimeSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.LemonLimeSlushie.NotifyLabel, description = Config.Language.LemonLimeSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.OrangeSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.OrangeSlushie.NotifyLabel, Config.Language.OrangeSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.OrangeSlushie.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.OrangeSlushie.NotifyLabel, Config.Language.OrangeSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.OrangeSlushie.NotifyLabel, description = Config.Language.OrangeSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.GrapeSlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.GrapeSlushie.NotifyLabel, Config.Language.GrapeSlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.GrapeSlushie.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.GrapeSlushie.NotifyLabel, Config.Language.GrapeSlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.GrapeSlushie.NotifyLabel, description = Config.Language.GrapeSlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.CherrySlushie.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.CherrySlushie.NotifyLabel, Config.Language.CherrySlushie.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.CherrySlushie.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.CherrySlushie.NotifyLabel, Config.Language.CherrySlushie.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.CherrySlushie.NotifyLabel, description = Config.Language.CherrySlushie.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.SlicedBread.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.SlicedBread.NotifyLabel, Config.Language.SlicedBread.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.SlicedBread.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.SlicedBread.NotifyLabel, Config.Language.SlicedBread.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.SlicedBread.NotifyLabel, description = Config.Language.SlicedBread.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.SlicedBacon.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.SlicedBacon.NotifyLabel, Config.Language.SlicedBacon.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.SlicedBacon.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.SlicedBacon.NotifyLabel, Config.Language.SlicedBacon.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.SlicedBacon.NotifyLabel, description = Config.Language.SlicedBacon.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TunaChunks.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TunaChunks.NotifyLabel, Config.Language.TunaChunks.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TunaChunks.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TunaChunks.NotifyLabel, Config.Language.TunaChunks.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.TunaChunks.NotifyLabel, description = Config.Language.TunaChunks.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.SlicedAvocado.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.SlicedAvocado.NotifyLabel, Config.Language.SlicedAvocado.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.SlicedAvocado.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.SlicedAvocado.NotifyLabel, Config.Language.SlicedAvocado.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.SlicedAvocado.NotifyLabel, description = Config.Language.SlicedAvocado.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TurkeySlices.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TurkeySlices.NotifyLabel, Config.Language.TurkeySlices.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TurkeySlices.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TurkeySlices.NotifyLabel, Config.Language.TurkeySlices.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.TurkeySlices.NotifyLabel, description = Config.Language.TurkeySlices.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.GrilledCheese.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.GrilledCheese.NotifyLabel, Config.Language.GrilledCheese.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.GrilledCheese.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.GrilledCheese.NotifyLabel, Config.Language.GrilledCheese.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.GrilledCheese.NotifyLabel, description = Config.Language.GrilledCheese.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.ChickenMozzarella.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.ChickenMozzarella.NotifyLabel, Config.Language.ChickenMozzarella.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.ChickenMozzarella.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.ChickenMozzarella.NotifyLabel, Config.Language.ChickenMozzarella.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.ChickenMozzarella.NotifyLabel, description = Config.Language.ChickenMozzarella.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.BaconAvocado.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.BaconAvocado.NotifyLabel, Config.Language.BaconAvocado.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.BaconAvocado.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.BaconAvocado.NotifyLabel, Config.Language.BaconAvocado.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.BaconAvocado.NotifyLabel, description = Config.Language.BaconAvocado.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TunaSweetcorn.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TunaSweetcorn.NotifyLabel, Config.Language.TunaSweetcorn.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TunaSweetcorn.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TunaSweetcorn.NotifyLabel, Config.Language.TunaSweetcorn.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.TunaSweetcorn.NotifyLabel, description = Config.Language.TunaSweetcorn.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.TurkeyCranberry.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.TurkeyCranberry.NotifyLabel, Config.Language.TurkeyCranberry.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.TurkeyCranberry.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.TurkeyCranberry.NotifyLabel, Config.Language.TurkeyCranberry.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.TurkeyCranberry.NotifyLabel, description = Config.Language.TurkeyCranberry.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
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
                        if NotifyType == 'qb' then
                            QBCore.Functions.Notify(Config.Language.EggsBacon.NotifyName, "success", Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'okok' then
                            exports['okokNotify']:Alert(Config.Language.EggsBacon.NotifyLabel, Config.Language.EggsBacon.NotifyName, Config.CoreSettings.Notify.Length.Success, 'success', Config.CoreSettings.Notify.Sound)
                        elseif NotifyType == 'mythic' then
                            exports['mythic_notify']:DoHudText('success', Config.Language.EggsBacon.NotifyName)
                        elseif NotifyType == 'boii' then
                            exports['boii_ui']:notify(Config.Language.EggsBacon.NotifyLabel, Config.Language.EggsBacon.NotifyName, 'success', Config.CoreSettings.Notify.Length.Success)
                        elseif NotifyType == 'ox' then
                            lib.notify({ title = Config.Language.EggsBacon.NotifyLabel, description = Config.Language.EggsBacon.NotifyName, type = 'success', duration = Config.CoreSettings.Notify.Length.Success})
                        end
                end, function()
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.CancelledName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.CancelledLabel,Config.Language.Notifications.CancelledName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound)
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.CancelledName) 
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.CancelledLabel, Config.Language.Notifications.CancelledName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.CancelledLabel, description = Config.Language.Notifications.CancelledName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end)
                else
                    ClearPedTasks(PlayerPedId())
                    if NotifyType == 'qb' then
                        QBCore.Functions.Notify(Config.Language.Notifications.MissingItemsName, "error", Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'okok' then
                        exports['okokNotify']:Alert(Config.Language.Notifications.MissingItemsLabel,Config.Language.Notifications.MissingItemsName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
                    elseif NotifyType == 'mythic' then
                        exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.MissingItemsName)
                    elseif NotifyType == 'boii' then
                        exports['boii_ui']:notify(Config.Language.Notifications.MissingItemsLabel, Config.Language.Notifications.MissingItemsName, 'error', Config.CoreSettings.Notify.Length.Error)
                    elseif NotifyType == 'ox' then
                        lib.notify({ title = Config.Language.Notifications.MissingItemsLabel, description = Config.Language.Notifications.MissingItemsName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
                    end
                end
            end)
    else 
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

-------------------------------------------------< MAKE GRILLED SANDWICHES END >--------------------------------



---------------------------------------------------< INPUT AMOUNTS FOR CUPS/MUGS START >-------------------------------------- 


--Slushie Cup
RegisterNetEvent('lusty94_diner:client:GiveSlushieCup', function(data)
    if onDuty then 
        local dialog = exports['qb-input']:ShowInput({
            header = "How Many Do You Want?",
            submitText = "Confirm",
            inputs = {
                {
                    text = "Amount", -- text you want to be displayed as a place holder
                    name = "amount", -- name of the input should be unique otherwise it might override
                    type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                    isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                }
            },
        })
        if dialog then
            TriggerServerEvent('lusty94_diner:server:GiveSlushieCup', tonumber(dialog["amount"]))
        end
    else
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end, false)

--Mug
RegisterNetEvent('lusty94_diner:client:GiveMug', function(data)
    if onDuty then 
        local dialog = exports['qb-input']:ShowInput({
            header = "How Many Do You Want?",
            submitText = "Confirm",
            inputs = {
                {
                    text = "Amount", -- text you want to be displayed as a place holder
                    name = "amount", -- name of the input should be unique otherwise it might override
                    type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                    isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                }
            },
        })
        if dialog then
            TriggerServerEvent('lusty94_diner:server:GiveMug', tonumber(dialog["amount"]))
        end
    else
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end, false)

--Soft Drinks Cup
RegisterNetEvent('lusty94_diner:client:GiveSoftDrinksCup', function(data)
    if onDuty then 
        local dialog = exports['qb-input']:ShowInput({
            header = "How Many Do You Want?",
            submitText = "Confirm",
            inputs = {
                {
                    text = "Amount", -- text you want to be displayed as a place holder
                    name = "amount", -- name of the input should be unique otherwise it might override
                    type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                    isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                }
            },
        })
        if dialog then
            TriggerServerEvent('lusty94_diner:server:GiveSoftDrinksCup', tonumber(dialog["amount"]))
        end
    else
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end, false)


---------------------------------------------------< INPUT AMOUNTS FOR CUPS/MUGS END >-------------------------------------- 





-------------------------------------------------< CREATE PROPS START >--------------------------------

CreateThread(function()
    RequestModel(`xm_prop_x17_computer_01`)
    while not HasModelLoaded(`xm_prop_x17_computer_01`) do 
        Wait(1)
    end
    RequestModel(`bkr_prop_fakeid_clipboard_01a`)
    while not HasModelLoaded(`bkr_prop_fakeid_clipboard_01a`) do 
        Wait(1)
    end
    RequestModel(`prop_fridge_01`)
    while not HasModelLoaded(`prop_fridge_01`) do 
        Wait(1)
    end
    RequestModel(`prop_ff_sink_01`)
    while not HasModelLoaded(`prop_ff_sink_01`) do 
        Wait(1)
    end
    RequestModel(`prop_parkingpay`)
    while not HasModelLoaded(`prop_parkingpay`) do 
        Wait(1)
    end
    Computer = CreateObject(`xm_prop_x17_computer_01`, 1595.17, 6453.0, 26.15, false, false, false)
    Clipboard = CreateObject(`bkr_prop_fakeid_clipboard_01a`, 1592.56, 6454.3, 26.15, false, false, false)
    Fridge = CreateObject(`prop_fridge_01`, 1596.3, 6454.9, 25.0, false, false, false)
    Sink = CreateObject(`prop_ff_sink_01`, 1591.20, 6457.70, 25.93, false, false, false)
    Garage = CreateObject(`prop_parkingpay`, 1579.44, 6453.94, 24.2, false, false, false)
    SetEntityHeading(Computer,163.04)
    SetEntityHeading(Clipboard,160.28)
    SetEntityHeading(Fridge,336.5)
    SetEntityHeading(Sink, -115.0)
    SetEntityHeading(Garage, 336.22)
    FreezeEntityPosition(Computer, true)
    FreezeEntityPosition(Clipboard, true)
    FreezeEntityPosition(Fridge, true)
    FreezeEntityPosition(Sink, true)
    FreezeEntityPosition(Garage, true)
end)

-------------------------------------------------< CREATE PROPS END >--------------------------------






---------------------------------------------------< FRIDGES SECTION START >----------------------------------------

--Ingredients Fridge
RegisterNetEvent("lusty94_diner:client:IngredientsFridge", function()
    if onDuty then
        if ShopType == 'qb' then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "Ingredients", Config.InteractionLocations.Ingredients.Items)
        elseif ShopType == 'jim' then
            TriggerServerEvent("jim-shops:ShopOpen", "shop", "Ingredients", Config.InteractionLocations.Ingredients.Items)
        end
    else
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)

--Storage Fridge
RegisterNetEvent("lusty94_diner:client:StorageFridge", function()
    if onDuty then
        TriggerEvent("inventory:client:SetCurrentStash", "PopsDiner_StorageFridge")
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "PopsDiner_StorageFridge", {
            maxweight = Config.InteractionLocations.Fridge.StashSize,
            slots = Config.InteractionLocations.Fridge.StashSlots,
        })
    else
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
    end
end)
---------------------------------------------------< FRIDGES SECTION END >----------------------------------------






---------------------------------------------------< SNACK SHELF SECTION START >----------------------------------------

AddEventHandler("lusty94_diner:client:SnackShelf", function()
    if ShopType == 'qb' then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "SnackShelf", Config.InteractionLocations.SnackShelf.Items)
    elseif ShopType == 'jim' then
        TriggerServerEvent("jim-shops:ShopOpen", "shop", "SnackShelf", Config.InteractionLocations.SnackShelf.Items)
    end
end)


---------------------------------------------------< SNACK SHELF SECTION END >----------------------------------------






---------------------------------------------------< COLLECTION TRAY SECTION START >----------------------------------------

RegisterNetEvent("lusty94_diner:client:OpenCollectionTray", function()
    TriggerEvent("inventory:client:SetCurrentStash", "collectiontray_popsdiner")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "collectiontray_popsdiner", {
        maxweight = Config.InteractionLocations.CollectionTray.StashSize,
        slots = Config.InteractionLocations.CollectionTray.StashSlots,
    })
end)

---------------------------------------------------< COLLECTION TRAY SECTION END >----------------------------------------








-----------------------------------------------------< BILLING SECTION START >---------------------------------------------------
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
                        text = "Total Bill Price: "..Config.InteractionLocations.Payment.CashSymbol, -- text you want to be displayed as a place holder
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
            if NotifyType == 'qb' then
                QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
            elseif NotifyType == 'okok' then
                exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
            elseif NotifyType == 'mythic' then
                exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
            elseif NotifyType == 'boii' then
                exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
            elseif NotifyType == 'ox' then
                lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
            end
        end
end)
-----------------------------------------------------< BILLING SECTION END >---------------------------------------------------




----------------------------------------------------< GARAGE SECTION START >-----------------------------------------------
RegisterNetEvent('lusty94_diner:client:RentVehicle', function()
    if onDuty then
        QBCore.Functions.SpawnVehicle(Config.InteractionLocations.Job.Vehicle.Name, function(veh)
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleNumberPlateText(veh, Config.InteractionLocations.Job.Vehicle.Plate)
            exports[FuelScript]:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent(KeysEvent, QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, Config.InteractionLocations.Job.Vehicle.SpawnLocation, true)
    else
        if NotifyType == 'qb' then
            QBCore.Functions.Notify(Config.Language.Notifications.DutyName, "error", Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'okok' then
            exports['okokNotify']:Alert(Config.Language.Notifications.DutyLabel,Config.Language.Notifications.DutyName, Config.CoreSettings.Notify.Length.Error, 'error', Config.CoreSettings.Notify.Sound) 
        elseif NotifyType == 'mythic' then
            exports['mythic_notify']:DoHudText('error', Config.Language.Notifications.DutyName)
        elseif NotifyType == 'boii' then
            exports['boii_ui']:notify(Config.Language.Notifications.DutyLabel, Config.Language.Notifications.DutyName, 'error', Config.CoreSettings.Notify.Length.Error)
        elseif NotifyType == 'ox' then
            lib.notify({ title = Config.Language.Notifications.DutyLabel, description = Config.Language.Notifications.DutyName, type = 'error', duration = Config.CoreSettings.Notify.Length.Error})
        end
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
----------------------------------------------------< GARAGE SECTION END >--------------------------------------------------










--[[ IGNORE THIS SECTION UNLESS YOU ARE ADDING OR REMOVING TARGET LOCATIONS OR CHANGING ZONE NAMES / IDS ]]


AddEventHandler('onResourceStop', function(resourceName) if resourceName ~= GetCurrentResourceName() then return end
if (GetCurrentResourceName() ~= resourceName) then
end
    print('^5--<^3!^5>-- ^7Lusty94 ^5| ^5--<^3!^5>-- ^7Diner V1.0.0 Stopped Successfully ^5--<^3!^5>--^7')
    SetModelAsNoLongerNeeded(Computer)
    SetModelAsNoLongerNeeded(Clipboard)
    SetModelAsNoLongerNeeded(Fridge)
    SetModelAsNoLongerNeeded(Sink)
    SetModelAsNoLongerNeeded(Garage)
    DeleteObject(Computer)
    DeleteObject(Clipboard)
    DeleteObject(Fridge)
    DeleteObject(Sink)
    DeleteObject(Garage)
    if TargetType == 'qb' then
        exports['qb-target']:RemoveZone("Duty")
        exports['qb-target']:RemoveZone("BossMenu")
        exports['qb-target']:RemoveZone("WashHands")
        exports['qb-target']:RemoveZone("Payment")
        exports['qb-target']:RemoveZone("CollectionTray")
        exports['qb-target']:RemoveZone("Grill")
        exports['qb-target']:RemoveZone("ChoppingBoard")
        exports['qb-target']:RemoveZone("SlushieMachine")
        exports['qb-target']:RemoveZone("SoftDrinks")
        exports['qb-target']:RemoveZone("HotDrinks")
        exports['qb-target']:RemoveZone("Fridge")
        exports['qb-target']:RemoveZone("Ingredients")
        exports['qb-target']:RemoveZone("Snacks")
        exports['qb-target']:RemoveZone("Garage")
    elseif TargetType == 'ox' then
        exports.ox_target:removeZone(1)
        exports.ox_target:removeZone(2)
        exports.ox_target:removeZone(3)
        exports.ox_target:removeZone(4)
        exports.ox_target:removeZone(5)
        exports.ox_target:removeZone(6)
        exports.ox_target:removeZone(7)
        exports.ox_target:removeZone(8)
        exports.ox_target:removeZone(9)
        exports.ox_target:removeZone(10)
        exports.ox_target:removeZone(11)
        exports.ox_target:removeZone(12)
        exports.ox_target:removeZone(13)
        exports.ox_target:removeZone(14)
    end    
end)


