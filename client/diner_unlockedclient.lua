local QBCore = exports['qb-core']:GetCoreObject()
local onDuty = false
PlayerJob = {}
local FuelScript = Config.CoreSettings.EventNames.Fuel
local KeysEvent = Config.CoreSettings.EventNames.Keys

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
        if Config.CoreSettings.Shop.Type == 'qb' then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "Ingredients", Config.InteractionLocations.Ingredients.Items)
        elseif Config.CoreSettings.Shop.Type == 'jim' then
            TriggerServerEvent("jim-shops:ShopOpen", "shop", "Ingredients", Config.InteractionLocations.Ingredients.Items)
        end
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

--Storage Fridge
RegisterNetEvent("lusty94_diner:client:StorageFridge", function()
    if onDuty then
        TriggerEvent("inventory:client:SetCurrentStash", "PopsDiner_StorageFridge")
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "PopsDiner_StorageFridge", {
            maxweight = Config.InteractionLocations.Fridge.StashSize,
            slots = Config.InteractionLocations.Fridge.StashSlots,
        })
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
---------------------------------------------------< FRIDGES SECTION END >----------------------------------------






---------------------------------------------------< SNACK SHELF SECTION START >----------------------------------------

AddEventHandler("lusty94_diner:client:SnackShelf", function()
    if Config.CoreSettings.Shop.Type == 'qb' then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "SnackShelf", Config.InteractionLocations.SnackShelf.Items)
    elseif Config.CoreSettings.Shop.Type == 'jim' then
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
    if Config.CoreSettings.Target.Type == 'qb' then
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
    elseif Config.CoreSettings.Target.Type == 'ox' then
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



RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)




