local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local NotifyType = Config.CoreSettings.Notify.Type


--notification function
local function SendNotify(src, msg, type, time, title)
    if NotifyType == nil then print("Lusty94_Diner: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Diner" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message") return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'boii'  then
        TriggerClientEvent('boii_ui:notify', src, title, msg, type, time)
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    end
end


--Give Slushie Cup
RegisterNetEvent('lusty94_diner:server:GiveSlushieCup', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then        
        Player.Functions.AddItem("slushiecup", amount)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "add", amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "slushiecup", amount) then
            exports.ox_inventory:AddItem(src,"slushiecup", amount)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Give Mug
RegisterNetEvent('lusty94_diner:server:GiveMug', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then        
        Player.Functions.AddItem("mug", amount)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["mug"], "add", amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "mug", amount) then
            exports.ox_inventory:AddItem(src,"mug", amount)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Give Soft Drinks Cup
RegisterNetEvent('lusty94_diner:server:GiveSoftDrinksCup', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    if not Player then return end 
    if InvType == 'qb' then      
        Player.Functions.AddItem("softdrinkscup", amount)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["softdrinkscup"], "add", amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "softdrinkscup", amount) then
            exports.ox_inventory:AddItem(src,"softdrinkscup", amount)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Give Kitchen Knife
RegisterNetEvent('lusty94_diner:server:GiveKitchenKnife', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end   
    if InvType == 'qb' then     
        Player.Functions.AddItem("kitchenknife", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["kitchenknife"], "add", amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "kitchenknife", 1) then
            exports.ox_inventory:AddItem(src,"kitchenknife", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Give Bread Knife
RegisterNetEvent('lusty94_diner:server:GiveBreadKnife', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    if not Player then return end
    if InvType == 'qb' then       
        Player.Functions.AddItem("breadknife", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["breadknife"], "add", amount)
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "breadknife", 1) then
            exports.ox_inventory:AddItem(src,"breadknife", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)






-------------------------------------------------< MAKE HOT DRINKS START >--------------------------------


--Mug For Hot Drinks Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:Mug', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local mug = Player.Functions.GetItemByName("mug")
    if mug then
        cb(true)
    else
        cb(false)
    end
end)


--Create Tea
RegisterNetEvent('lusty94_diner:server:CreateTea', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("mug", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["mug"], "remove")            
        Player.Functions.AddItem("tea", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tea"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "tea", 1) then
            exports.ox_inventory:RemoveItem(src,"mug", 1)
            exports.ox_inventory:AddItem(src,"tea", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Create Coffee
RegisterNetEvent('lusty94_diner:server:CreateCoffee', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("mug", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["mug"], "remove")            
        Player.Functions.AddItem("coffee", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["coffee"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "coffee", 1) then
            exports.ox_inventory:RemoveItem(src,"mug", 1)
            exports.ox_inventory:AddItem(src,"coffee", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Create Hot Chocolate
RegisterNetEvent('lusty94_diner:server:CreateHotChocolate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("mug", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["mug"], "remove")            
        Player.Functions.AddItem("hotchocolate", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["hotchocolate"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "hotchocolate", 1) then
            exports.ox_inventory:RemoveItem(src,"mug", 1)
            exports.ox_inventory:AddItem(src,"hotchocolate", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


-------------------------------------------------< MAKE HOT DRINKS END >--------------------------------







-------------------------------------------------< MAKE SOFT DRINKS START >--------------------------------


--Soft Drinks Cup Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:SoftDrinksCup', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("softdrinkscup")
    if cup then
        cb(true)
    else
        cb(false)
    end
end)


--Create ECola
RegisterNetEvent('lusty94_diner:server:CreateECola', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("softdrinkscup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["softdrinkscup"], "remove")            
        Player.Functions.AddItem("ecola", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["ecola"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "ecola", 1) then
            exports.ox_inventory:RemoveItem(src,"softdrinkscup", 1)
            exports.ox_inventory:AddItem(src,"ecola", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Create ECola Light
RegisterNetEvent('lusty94_diner:server:CreateEColaLight', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("softdrinkscup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["softdrinkscup"], "remove")            
        Player.Functions.AddItem("ecolalight", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["ecolalight"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "ecolalight", 1) then
            exports.ox_inventory:RemoveItem(src,"softdrinkscup", 1)
            exports.ox_inventory:AddItem(src,"ecolalight", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Create Sprunk
RegisterNetEvent('lusty94_diner:server:CreateSprunk', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("softdrinkscup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["softdrinkscup"], "remove")            
        Player.Functions.AddItem("sprunk", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["sprunk"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "sprunk", 1) then
            exports.ox_inventory:RemoveItem(src,"softdrinkscup", 1)
            exports.ox_inventory:AddItem(src,"sprunk", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Create Orange Soda
RegisterNetEvent('lusty94_diner:server:CreateOrangeSoda', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("softdrinkscup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["softdrinkscup"], "remove")            
        Player.Functions.AddItem("orangesoda", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["orangesoda"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "orangesoda", 1) then
            exports.ox_inventory:RemoveItem(src,"softdrinkscup", 1)
            exports.ox_inventory:AddItem(src,"orangesoda", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


-------------------------------------------------< MAKE SOFT DRINKS END >--------------------------------







-------------------------------------------------< MAKE SLUSHIES START >--------------------------------


--Blue Raspberry Slushie Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:BlueRaspberrySlushie', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("slushiecup")
    local ingredient = Player.Functions.GetItemByName("blueraspberrysyrup")
    local ice = Player.Functions.GetItemByName("crushedice")
    if cup and ingredient and ice then
        cb(true)
    else
        cb(false)
    end
end)


--Create Blue Raspberry Slushie
RegisterNetEvent('lusty94_diner:server:CreateBlueRaspberrySlushie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slushiecup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "remove")
        Player.Functions.RemoveItem("blueraspberrysyrup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["blueraspberrysyrup"], "remove")
        Player.Functions.RemoveItem("crushedice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["crushedice"], "remove")            
        Player.Functions.AddItem("blueraspberryslushie", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["blueraspberryslushie"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "blueraspberryslushie", 1) then
            exports.ox_inventory:RemoveItem(src,"slushiecup", 1)
            exports.ox_inventory:RemoveItem(src,"blueraspberrysyrup", 1)
            exports.ox_inventory:RemoveItem(src,"crushedice", 1)
            exports.ox_inventory:AddItem(src,"blueraspberryslushie", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Tropical Slushie Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:TropicalSlushie', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("slushiecup")
    local ingredient = Player.Functions.GetItemByName("tropicalsyrup")
    local ice = Player.Functions.GetItemByName("crushedice")
    if cup and ingredient and ice then
        cb(true)
    else
        cb(false)
    end
end)


--Create Tropical Slushie
RegisterNetEvent('lusty94_diner:server:CreateTropicalSlushie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slushiecup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "remove")
        Player.Functions.RemoveItem("tropicalsyrup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tropicalsyrup"], "remove")
        Player.Functions.RemoveItem("crushedice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["crushedice"], "remove")            
        Player.Functions.AddItem("tropicalslushie", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tropicalslushie"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "tropicalslushie", 1) then
            exports.ox_inventory:RemoveItem(src,"slushiecup", 1)
            exports.ox_inventory:RemoveItem(src,"tropicalsyrup", 1)
            exports.ox_inventory:RemoveItem(src,"crushedice", 1)
            exports.ox_inventory:AddItem(src,"tropicalslushie", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Strawberry Slushie Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:StrawberrySlushie', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("slushiecup")
    local ingredient = Player.Functions.GetItemByName("strawberrysyrup")
    local ice = Player.Functions.GetItemByName("crushedice")
    if cup and ingredient and ice then
        cb(true)
    else
        cb(false)
    end
end)


--Create Strawberry Slushie
RegisterNetEvent('lusty94_diner:server:CreateStrawberrySlushie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slushiecup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "remove")
        Player.Functions.RemoveItem("strawberrysyrup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["strawberrysyrup"], "remove")
        Player.Functions.RemoveItem("crushedice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["crushedice"], "remove")            
        Player.Functions.AddItem("strawberryslushie", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["strawberryslushie"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "strawberryslushie", 1) then
            exports.ox_inventory:RemoveItem(src,"slushiecup", 1)
            exports.ox_inventory:RemoveItem(src,"strawberrysyrup", 1)
            exports.ox_inventory:RemoveItem(src,"crushedice", 1)
            exports.ox_inventory:AddItem(src,"strawberryslushie", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--LemonLime Slushie Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:LemonLimeSlushie', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("slushiecup")
    local ingredient = Player.Functions.GetItemByName("lemonlimesyrup")
    local ice = Player.Functions.GetItemByName("crushedice")
    if cup and ingredient and ice then
        cb(true)
    else
        cb(false)
    end
end)


--Create LemonLime Slushie
RegisterNetEvent('lusty94_diner:server:CreateLemonLimeSlushie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slushiecup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "remove")
        Player.Functions.RemoveItem("lemonlimesyrup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["lemonlimesyrup"], "remove")
        Player.Functions.RemoveItem("crushedice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["crushedice"], "remove")            
        Player.Functions.AddItem("lemonlimeslushie", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["lemonlimeslushie"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "lemonlimeslushie", 1) then
            exports.ox_inventory:RemoveItem(src,"slushiecup", 1)
            exports.ox_inventory:RemoveItem(src,"lemonlimesyrup", 1)
            exports.ox_inventory:RemoveItem(src,"crushedice", 1)
            exports.ox_inventory:AddItem(src,"lemonlimeslushie", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Orange Slushie Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:OrangeSlushie', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("slushiecup")
    local ingredient = Player.Functions.GetItemByName("orangesyrup")
    local ice = Player.Functions.GetItemByName("crushedice")
    if cup and ingredient and ice then
        cb(true)
    else
        cb(false)
    end
end)


--Create Orange Slushie
RegisterNetEvent('lusty94_diner:server:CreateOrangeSlushie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slushiecup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "remove")
        Player.Functions.RemoveItem("orangesyrup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["orangesyrup"], "remove")
        Player.Functions.RemoveItem("crushedice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["crushedice"], "remove")            
        Player.Functions.AddItem("orangeslushie", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["orangeslushie"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "orangeslushie", 1) then
            exports.ox_inventory:RemoveItem(src,"slushiecup", 1)
            exports.ox_inventory:RemoveItem(src,"orangesyrup", 1)
            exports.ox_inventory:RemoveItem(src,"crushedice", 1)
            exports.ox_inventory:AddItem(src,"orangeslushie", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Grape Slushie Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:GrapeSlushie', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("slushiecup")
    local ingredient = Player.Functions.GetItemByName("grapesyrup")
    local ice = Player.Functions.GetItemByName("crushedice")
    if cup and ingredient and ice then
        cb(true)
    else
        cb(false)
    end
end)


--Create Grape Slushie
RegisterNetEvent('lusty94_diner:server:CreateGrapeSlushie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slushiecup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "remove")
        Player.Functions.RemoveItem("grapesyrup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grapesyrup"], "remove")
        Player.Functions.RemoveItem("crushedice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["crushedice"], "remove")            
        Player.Functions.AddItem("grapeslushie", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grapeslushie"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "grapeslushie", 1) then
            exports.ox_inventory:RemoveItem(src,"slushiecup", 1)
            exports.ox_inventory:RemoveItem(src,"grapesyrup", 1)
            exports.ox_inventory:RemoveItem(src,"crushedice", 1)
            exports.ox_inventory:AddItem(src,"grapeslushie", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Cherry Slushie Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:CherrySlushie', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cup = Player.Functions.GetItemByName("slushiecup")
    local ingredient = Player.Functions.GetItemByName("cherrysyrup")
    local ice = Player.Functions.GetItemByName("crushedice")
    if cup and ingredient and ice then
        cb(true)
    else
        cb(false)
    end
end)


--Create Cherry Slushie
RegisterNetEvent('lusty94_diner:server:CreateCherrySlushie', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slushiecup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slushiecup"], "remove")
        Player.Functions.RemoveItem("cherrysyrup", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cherrysyrup"], "remove")
        Player.Functions.RemoveItem("crushedice", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["crushedice"], "remove")            
        Player.Functions.AddItem("cherryslushie", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cherryslushie"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "cherryslushie", 1) then
            exports.ox_inventory:RemoveItem(src,"slushiecup", 1)
            exports.ox_inventory:RemoveItem(src,"cherrysyrup", 1)
            exports.ox_inventory:RemoveItem(src,"crushedice", 1)
            exports.ox_inventory:AddItem(src,"cherryslushie", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)




-------------------------------------------------< MAKE SLUSHIES END >--------------------------------















-------------------------------------------------< MAKE SLICED INGREDIENTS START >--------------------------------


--Bread Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:Bread', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local knife = Player.Functions.GetItemByName("breadknife")
    local bread = Player.Functions.GetItemByName("bread")
    if knife and bread then
        cb(true)
    else
        cb(false)
    end
end)


--Create Sliced Bread
RegisterNetEvent('lusty94_diner:server:CreateSlicedBread', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("bread", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["bread"], "remove")            
        Player.Functions.AddItem("slicedbread", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbread"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "slicedbread", 1) then
            exports.ox_inventory:RemoveItem(src,"bread", 1)
            exports.ox_inventory:AddItem(src,"slicedbread", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Bacon Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:Bacon', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local knife = Player.Functions.GetItemByName("kitchenknife")
    local bacon = Player.Functions.GetItemByName("bacon")
    if knife and bacon then
        cb(true)
    else
        cb(false)
    end
end)


--Create Sliced Bacon
RegisterNetEvent('lusty94_diner:server:CreateSlicedBacon', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("bacon", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["bacon"], "remove")            
        Player.Functions.AddItem("slicedbacon", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbacon"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "slicedbacon", 1) then
            exports.ox_inventory:RemoveItem(src,"bacon", 1)
            exports.ox_inventory:AddItem(src,"slicedbacon", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Tuna Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:Tuna', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local knife = Player.Functions.GetItemByName("kitchenknife")
    local tuna = Player.Functions.GetItemByName("tuna")
    if knife and tuna then
        cb(true)
    else
        cb(false)
    end
end)

--Create Tuna Chunks
RegisterNetEvent('lusty94_diner:server:CreateTunaChunks', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("tuna", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tuna"], "remove")            
        Player.Functions.AddItem("tunachunks", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tunachunks"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "tunechunks", 1) then
            exports.ox_inventory:RemoveItem(src,"tuna", 1)
            exports.ox_inventory:AddItem(src,"tunachunks", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Avocado Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:Avocado', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local knife = Player.Functions.GetItemByName("kitchenknife")
    local avocado = Player.Functions.GetItemByName("avocado")
    if knife and avocado then
        cb(true)
    else
        cb(false)
    end
end)

--Create Sliced Avocado
RegisterNetEvent('lusty94_diner:server:CreateSlicedAvocado', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("avocado", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["avocado"], "remove")            
        Player.Functions.AddItem("slicedavocado", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedavocado"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "slicedavocado", 1) then
            exports.ox_inventory:RemoveItem(src,"avocado", 1)
            exports.ox_inventory:AddItem(src,"slicedavocado", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)

--Turkey Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:Turkey', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local knife = Player.Functions.GetItemByName("kitchenknife")
    local turkey = Player.Functions.GetItemByName("turkey")
    if knife and turkey then
        cb(true)
    else
        cb(false)
    end
end)

--Create Turkey Slices
RegisterNetEvent('lusty94_diner:server:CreateTurkeySlices', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("turkey", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["turkey"], "remove")            
        Player.Functions.AddItem("turkeyslices", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["turkeyslices"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "turkeyslices", 1) then
            exports.ox_inventory:RemoveItem(src,"turkey", 1)
            exports.ox_inventory:AddItem(src,"turkeyslices", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


 

-------------------------------------------------< MAKE SLICED INGREDIENTS END >--------------------------------




-------------------------------------------------< MAKE GRILLED SANDWICHES START >--------------------------------



--Grilled Cheese Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:GrilledCheese', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bread = Player.Functions.GetItemByName("slicedbread")
    local butter = Player.Functions.GetItemByName("butter")
    local ingredient = Player.Functions.GetItemByName("cheeseslice")
    if bread and butter and ingredient then
        cb(true)
    else
        cb(false)
    end
end)


--Create Grilled Cheese
RegisterNetEvent('lusty94_diner:server:CreateGrilledCheese', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slicedbread", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbread"], "remove")
        Player.Functions.RemoveItem("butter", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["butter"], "remove")
        Player.Functions.RemoveItem("cheeseslice", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cheeseslice"], "remove")            
        Player.Functions.AddItem("grilledcheese", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grilledcheese"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "grilledcheese", 1) then
            exports.ox_inventory:RemoveItem(src,"slicedbread", 2)
            exports.ox_inventory:RemoveItem(src,"butter", 1)
            exports.ox_inventory:RemoveItem(src,"cheeseslice", 2)
            exports.ox_inventory:AddItem(src,"grilledcheese", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Chicken & Mozzarella Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:ChickenMozzarella', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bread = Player.Functions.GetItemByName("slicedbread")
    local butter = Player.Functions.GetItemByName("butter")
    local ingredient = Player.Functions.GetItemByName("chickenbreast")
    local cheese = Player.Functions.GetItemByName("mozzarellacheese")
    local sauce = Player.Functions.GetItemByName("balsamicglaze")
    if bread and butter and ingredient and cheese and sauce then
        cb(true)
    else
        cb(false)
    end
end)


--Create Chicken & Mozzarella
RegisterNetEvent('lusty94_diner:server:CreateChickenMozzarella', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slicedbread", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbread"], "remove")
        Player.Functions.RemoveItem("butter", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["butter"], "remove")
        Player.Functions.RemoveItem("chickenbreast", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["chickenbreast"], "remove")
        Player.Functions.RemoveItem("mozzarellacheese", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["mozzarellacheese"], "remove")
        Player.Functions.RemoveItem("balsamicglaze", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["balsamicglaze"], "remove")            
        Player.Functions.AddItem("grilledchickenmozzarella", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grilledchickenmozzarella"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "grilledchickenmozzarella", 1) then
            exports.ox_inventory:RemoveItem(src,"slicedbread", 2)
            exports.ox_inventory:RemoveItem(src,"butter", 1)
            exports.ox_inventory:RemoveItem(src,"chickenbreast", 2)
            exports.ox_inventory:RemoveItem(src,"mozzarellacheese", 2)
            exports.ox_inventory:RemoveItem(src,"balsamicglaze", 2)
            exports.ox_inventory:AddItem(src,"grilledchickenmozzarella", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Bacon & Avocado Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:BaconAvocado', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bread = Player.Functions.GetItemByName("slicedbread")
    local butter = Player.Functions.GetItemByName("butter")
    local ingredient = Player.Functions.GetItemByName("slicedbacon")
    local ingredient2 = Player.Functions.GetItemByName("slicedavocado")
    if bread and butter and ingredient and ingredient2 then
        cb(true)
    else
        cb(false)
    end
end)


--Create Bacon & Avocado
RegisterNetEvent('lusty94_diner:server:CreateBaconAvocado', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slicedbread", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbread"], "remove")
        Player.Functions.RemoveItem("butter", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["butter"], "remove")
        Player.Functions.RemoveItem("slicedbacon", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbacon"], "remove")
        Player.Functions.RemoveItem("slicedavocado", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedavocado"], "remove")            
        Player.Functions.AddItem("grilledbaconavocado", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grilledbaconavocado"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "grilledbaconavocado", 1) then
            exports.ox_inventory:RemoveItem(src,"slicedbread", 2)
            exports.ox_inventory:RemoveItem(src,"butter", 1)
            exports.ox_inventory:RemoveItem(src,"slicedbacon", 2)
            exports.ox_inventory:RemoveItem(src,"slicedavocado", 2)
            exports.ox_inventory:AddItem(src,"grilledbaconavocado", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Tuna & Sweetcorn Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:TunaSweetcorn', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bread = Player.Functions.GetItemByName("slicedbread")
    local butter = Player.Functions.GetItemByName("butter")
    local ingredient = Player.Functions.GetItemByName("tunachunks")
    local ingredient2 = Player.Functions.GetItemByName("sweetcorn")
    if bread and butter and ingredient and ingredient2 then
        cb(true)
    else
        cb(false)
    end
end)


--Create Tuna & Sweetcorn
RegisterNetEvent('lusty94_diner:server:CreateTunaSweetcorn', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slicedbread", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbread"], "remove")
        Player.Functions.RemoveItem("butter", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["butter"], "remove")
        Player.Functions.RemoveItem("tunachunks", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tunachunks"], "remove")
        Player.Functions.RemoveItem("sweetcorn", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["sweetcorn"], "remove")            
        Player.Functions.AddItem("grilledtunasweetcorn", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grilledtunasweetcorn"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "grilledtunasweetcorn", 1) then
            exports.ox_inventory:RemoveItem(src,"slicedbread", 2)
            exports.ox_inventory:RemoveItem(src,"butter", 1)
            exports.ox_inventory:RemoveItem(src,"tunachunks", 2)
            exports.ox_inventory:RemoveItem(src,"sweetcorn", 1)
            exports.ox_inventory:AddItem(src,"grilledtunasweetcorn", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Turkey & Cranberry Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:TurkeyCranberry', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bread = Player.Functions.GetItemByName("slicedbread")
    local butter = Player.Functions.GetItemByName("butter")
    local ingredient = Player.Functions.GetItemByName("turkeyslices")
    local ingredient2 = Player.Functions.GetItemByName("cranberrysauce")
    if bread and butter and ingredient and ingredient2 then
        cb(true)
    else
        cb(false)
    end
end)


--Create Turkey & Cranberry
RegisterNetEvent('lusty94_diner:server:CreateTurkeyCranberry', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slicedbread", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbread"], "remove")
        Player.Functions.RemoveItem("butter", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["butter"], "remove")
        Player.Functions.RemoveItem("turkeyslices", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["turkeyslices"], "remove")
        Player.Functions.RemoveItem("cranberrysauce", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cranberrysauce"], "remove")            
        Player.Functions.AddItem("grilledturkeycranberry", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grilledturkeycranberry"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "grilledturkeycranberry", 1) then
            exports.ox_inventory:RemoveItem(src,"slicedbread", 2)
            exports.ox_inventory:RemoveItem(src,"butter", 1)
            exports.ox_inventory:RemoveItem(src,"turkeyslices", 2)
            exports.ox_inventory:RemoveItem(src,"cranberrysauce", 1)
            exports.ox_inventory:AddItem(src,"grilledturkeycranberry", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)


--Eggs & Bacon Callback
QBCore.Functions.CreateCallback('lusty94_diner:get:EggsBacon', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local bread = Player.Functions.GetItemByName("slicedbread")
    local butter = Player.Functions.GetItemByName("butter")
    local ingredient = Player.Functions.GetItemByName("eggs")
    local ingredient2 = Player.Functions.GetItemByName("slicedbacon")
    if bread and butter and ingredient and ingredient2 then
        cb(true)
    else
        cb(false)
    end
end)


--Create Eggs & Bacon
RegisterNetEvent('lusty94_diner:server:CreateEggsBacon', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        Player.Functions.RemoveItem("slicedbread", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbread"], "remove")
        Player.Functions.RemoveItem("butter", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["butter"], "remove")
        Player.Functions.RemoveItem("eggs", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["eggs"], "remove")
        Player.Functions.RemoveItem("slicedbacon", 2)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["slicedbacon"], "remove")            
        Player.Functions.AddItem("grilledeggsbacon", 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["grilledeggsbacon"], "add")
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, "grilledeggsbacon", 1) then
            exports.ox_inventory:RemoveItem(src,"slicedbread", 2)
            exports.ox_inventory:RemoveItem(src,"butter", 1)
            exports.ox_inventory:RemoveItem(src,"eggs", 2)
            exports.ox_inventory:RemoveItem(src,"slicedbacon", 2)
            exports.ox_inventory:AddItem(src,"grilledeggsbacon", 1)
        else
            SendNotify(src,"You Can\'t Carry Anymore of This Item!", 'error', 2000)
        end
    end
end)





--ingredients shop
function dinerIngredients()
    exports.ox_inventory:RegisterShop('dinerIngredients', {
        name = 'Diner Ingredients',
        inventory = {
            { name = 'butter', price = 0 },
            { name = 'crushedice', price = 0 },
            { name = 'balsamicglaze', price = 0 },
            { name = 'cranberrysauce', price = 0 },
            { name = 'mozzarellacheese', price = 0 },
            { name = 'cheeseslice', price = 0 },
            { name = 'bread', price = 0 },
            { name = 'eggs', price = 0 },
            { name = 'chickenbreast', price = 0 },
            { name = 'turkey', price = 0 },
            { name = 'bacon', price = 0 },
            { name = 'tuna', price = 0 },
            { name = 'avocado', price = 0 },
            { name = 'sweetcorn', price = 0 },
            { name = 'blueraspberrysyrup', price = 0 },
            { name = 'tropicalsyrup', price = 0 },
            { name = 'strawberrysyrup', price = 0 },
            { name = 'lemonlimesyrup', price = 0 },
            { name = 'orangesyrup', price = 0 },
            { name = 'grapesyrup', price = 0 },
            { name = 'cherrysyrup', price = 0 },
        },
        groups = {
            diner = 0
        },
    })    
end

--snacks shop
function dinerSnacks()
    exports.ox_inventory:RegisterShop('dinerSnacks', {
        name = 'Diner Snack Shelf',
        inventory = {
            { name = 'vanillacupcake', price = 0 },
            { name = 'chocolatecupcake', price = 0 },
            { name = 'chocolatebar', price = 0 },
            { name = 'jamdoughnut', price = 0 },
            { name = 'sugardoughnut', price = 0 },
            { name = 'custarddoughnut', price = 0 },
            { name = 'chocolatedoughnut', price = 0 },
        },
        groups = {
            diner = 0
        },
    })
end

--collection tray
function dinercollectiontray()
    local collectionTray = {
        id = 'dinercollectiontray',
        label = 'Diner Collection Tray',
        slots = 6,
        weight = 10000000,
        owner = false,
    }
    exports.ox_inventory:RegisterStash(collectionTray.id, collectionTray.label, collectionTray.slots, collectionTray.weight, collectionTray.owner, collectionTray.jobs)
end
--weapon storage
function dinerstoragefridge()
    local storage = {
        id = 'dinerstoragefridge',
        label = 'Diner Storage Fridge',
        slots = 64,
        weight = 10000000,
        owner = true,
        jobs = {["diner"] = 0},
    }
    exports.ox_inventory:RegisterStash(storage.id, storage.label, storage.slots, storage.weight, storage.owner, storage.jobs)
end


-- dont touch this is for ox stashes and shops
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        if InvType == 'ox' then
            print('^5--<^3!^5>-- ^7| Lusty94_Diner |^5 ^5--<^3!^5>--^7')
            print('^5--<^3!^5>-- ^7| Inventory Type is set to ox |^5 ^5--<^3!^5>--^7')
            print('^5--<^3!^5>-- ^7| Registering shops and stashes automatically |^5 ^5--<^3!^5>--^7')
            dinerIngredients()
            dinerSnacks()
            dinercollectiontray()
            dinerstoragefridge()
            print('^5--<^3!^5>-- ^7| Shops and stashes registered successfully |^5 ^5--<^3!^5>--^7')
        end
    end
end)


if Config.UseJimConsumables then

        local foodTable = {
            ["blueraspberryslushie"]        = { emote = "slushie1", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["tropicalslushie"]             = { emote = "slushie2", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["strawberryslushie"]           = { emote = "slushie3", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["lemonlimeslushie"]            = { emote = "slushie4", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["orangeslushie"]               = { emote = "slushie5", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["grapeslushie"]                = { emote = "slushie6", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["cherryslushie"]               = { emote = "slushie7", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            
            ["grilledcheese"]               = { emote = "sandwich1", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["grilledchickenmozzarella"]    = { emote = "sandwich2", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["grilledbaconavocado"]         = { emote = "sandwich3", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["grilledtunasweetcorn"]        = { emote = "sandwich4", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["grilledturkeycranberry"]      = { emote = "sandwich5", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["grilledeggsbacon"]            = { emote = "sandwich6", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            
            ["vanillacupcake"]              = { emote = "cupcake1", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["chocolatecupcake"]            = { emote = "cupcake2", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["chocolatebar"]                = { emote = "chocbar",  canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["jamdoughnut"]                 = { emote = "doughnut1", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["sugardoughnut"]               = { emote = "doughnut2", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["custarddoughnut"]             = { emote = "doughnut3", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            ["chocolatedoughnut"]           = { emote = "doughnut4", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(30,50), }},
            
            ["tea"]                         = { emote = "drink1", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["cofee"]                       = { emote = "drink2", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["hotchocolate"]                = { emote = "drink3", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["ecola"]                       = { emote = "drink4", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["ecolalight"]                  = { emote = "drink5", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["sprunk"]                      = { emote = "drink6", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
            ["orangesoda"]                  = { emote = "drink7", canRun = true, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(30,50), }},
        }

        local emoteTable = {
            ["slushie1"] = {"mp_player_intdrink",                          "loop_bottle",                  "Blue Raspberry Slushie",        AnimationOptions = { Prop = "beanmachine_cup3",                 PropBone = 18905, PropPlacement = {0.0, -0.11, 0.07, -118.0, -121.0, 37.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["slushie2"] = {"mp_player_intdrink",                          "loop_bottle",                  "Tropcial slushie",              AnimationOptions = { Prop = "beanmachine_cup3",                 PropBone = 18905, PropPlacement = {0.0, -0.11, 0.07, -118.0, -121.0, 37.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["slushie3"] = {"mp_player_intdrink",                          "loop_bottle",                  "Strawberry Slushie",            AnimationOptions = { Prop = "beanmachine_cup3",                 PropBone = 18905, PropPlacement = {0.0, -0.11, 0.07, -118.0, -121.0, 37.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["slushie4"] = {"mp_player_intdrink",                          "loop_bottle",                  "Lemon N Lime Slushie",          AnimationOptions = { Prop = "beanmachine_cup3",                 PropBone = 18905, PropPlacement = {0.0, -0.11, 0.07, -118.0, -121.0, 37.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["slushie5"] = {"mp_player_intdrink",                          "loop_bottle",                  "Orange Slushie",                AnimationOptions = { Prop = "beanmachine_cup3",                 PropBone = 18905, PropPlacement = {0.0, -0.11, 0.07, -118.0, -121.0, 37.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["slushie6"] = {"mp_player_intdrink",                          "loop_bottle",                  "Grape Slushie",                 AnimationOptions = { Prop = "beanmachine_cup3",                 PropBone = 18905, PropPlacement = {0.0, -0.11, 0.07, -118.0, -121.0, 37.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["slushie7"] = {"mp_player_intdrink",                          "loop_bottle",                  "Cherry Slushie",                AnimationOptions = { Prop = "beanmachine_cup3",                 PropBone = 18905, PropPlacement = {0.0, -0.11, 0.07, -118.0, -121.0, 37.0}, EmoteMoving = true, EmoteLoop = true, }},
            
            ["sandwich1"] = {"mp_player_inteat@burger",                    "mp_player_int_eat_burger",     "Grilled Cheese Sandwich",       AnimationOptions = { Prop = "prop_sandwich_01",                 PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["sandwich2"] = {"mp_player_inteat@burger",                    "mp_player_int_eat_burger",     "Chicken & Mozzarella Sandwich", AnimationOptions = { Prop = "prop_sandwich_01",                 PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["sandwich3"] = {"mp_player_inteat@burger",                    "mp_player_int_eat_burger",     "Bacon & Avocado Sandwich",      AnimationOptions = { Prop = "prop_sandwich_01",                 PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["sandwich4"] = {"mp_player_inteat@burger",                    "mp_player_int_eat_burger",     "Tuna & Sweetcorn Sandwich",     AnimationOptions = { Prop = "prop_sandwich_01",                 PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["sandwich5"] = {"mp_player_inteat@burger",                    "mp_player_int_eat_burger",     "Turkey & Cranberry Sandwich",   AnimationOptions = { Prop = "prop_sandwich_01",                 PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["sandwich6"] = {"mp_player_inteat@burger",                    "mp_player_int_eat_burger",     "Eggs & Bacon Sandwich",         AnimationOptions = { Prop = "prop_sandwich_01",                 PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            
            ["cupcake1"] = {"mp_player_inteat@burger",                      "mp_player_int_eat_burger",     "Vanilla Cupcake",              AnimationOptions = { Prop = "pata_christmasfood6",              PropBone = 60309, PropPlacement = {0.0100, 0.0200, -0.0100, -170.1788, 87.6716, 30.0540}, EmoteMoving = true, EmoteLoop = true, }},
            ["cupcake2"] = {"mp_player_inteat@burger",                      "mp_player_int_eat_burger",     "Chocolate Cupcake",            AnimationOptions = { Prop = "pata_christmasfood6",              PropBone = 60309, PropPlacement = {0.0100, 0.0200, -0.0100, -170.1788, 87.6716, 30.0540}, EmoteMoving = true, EmoteLoop = true, }},
            ["chocbar"] = {"mp_player_inteat@burger",                       "mp_player_int_eat_burger",     "Chocolate Bar",                AnimationOptions = { Prop = "prop_choc_ego",                    PropBone = 60309, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["doughnut1"] = {"mp_player_inteat@burger",                     "mp_player_int_eat_burger",     "Jam Dougnut",                  AnimationOptions = { Prop = "prop_amb_donut",                   PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["doughnut2"] = {"mp_player_inteat@burger",                     "mp_player_int_eat_burger",     "Sugar Dougnut",                AnimationOptions = { Prop = "prop_amb_donut",                   PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["doughnut3"] = {"mp_player_inteat@burger",                     "mp_player_int_eat_burger",     "Custard Dougnut",              AnimationOptions = { Prop = "prop_amb_donut",                   PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["doughnut4"] = {"mp_player_inteat@burger",                     "mp_player_int_eat_burger",     "Chocolate Dougnut",            AnimationOptions = { Prop = "bzzz_foodpack_donut002",           PropBone = 60309, PropPlacement = {0.0000, -0.0300, -0.0100, 10.0000, 0.0000, -1.0000}, EmoteMoving = true, EmoteLoop = true, }},
            
            ["drink1"] = {"amb@world_human_drinking@coffee@male@idle_a",    "idle_c",                       "Tea",                          AnimationOptions = { Prop = "p_amb_coffeecup_01",               PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["drink2"] = {"amb@world_human_drinking@coffee@male@idle_a",    "idle_c",                       "Coffee",                       AnimationOptions = { Prop = "p_amb_coffeecup_01",               PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["drink3"] = {"amb@world_human_drinking@coffee@male@idle_a",    "idle_c",                       "Hot Chocolate",                AnimationOptions = { Prop = "p_amb_coffeecup_01",               PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, EmoteMoving = true, EmoteLoop = true, }},
            ["drink4"] = {"smo@milkshake_idle",                             "milkshake_idle_clip",          "E-Cola",                       AnimationOptions = { Prop = "prop_rpemotes_soda03",             PropBone = 28422, PropPlacement = {0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898}, EmoteMoving = true, EmoteLoop = true, }},
            ["drink5"] = {"smo@milkshake_idle",                             "milkshake_idle_clip",          "E-Cola Light",                 AnimationOptions = { Prop = "prop_rpemotes_soda04",             PropBone = 28422, PropPlacement = {0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898}, EmoteMoving = true, EmoteLoop = true, }},
            ["drink6"] = {"smo@milkshake_idle",                             "milkshake_idle_clip",          "Sprunk",                       AnimationOptions = { Prop = "prop_rpemotes_soda01",             PropBone = 28422, PropPlacement = {0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898}, EmoteMoving = true, EmoteLoop = true, }},
            ["drink7"] = {"smo@milkshake_idle",                             "milkshake_idle_clip",          "Orange Soda",                  AnimationOptions = { Prop = "prop_rpemotes_soda02",             PropBone = 28422, PropPlacement = {0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898}, EmoteMoving = true, EmoteLoop = true, }},
        }

        for k, v in pairs(foodTable) do TriggerEvent("jim-consumables:server:syncAddItem", k, v) end
        for k, v in pairs(emoteTable) do TriggerEvent("jim-consumables:server:syncAddEmote", k, v) end

else
    print("lusty94_diner - Config.UseJimConsumables is set to FALSE - Make sure you add them to your own consumables script.")
end




local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Diner/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^5Current^7: "..currentVersion.." ^5Latest^7: "..newestVersion.." "..advice) end
	end)
end
CheckVersion()