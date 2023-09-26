if Config.CoreSettings.Target.Type == 'qb' then
    exports['qb-target']:AddBoxZone("Duty", Config.InteractionLocations.Job.Duty.Location, Config.InteractionLocations.Job.Duty.Width, Config.InteractionLocations.Job.Duty.Height, {
        name = "Duty",
        heading = Config.InteractionLocations.Job.Duty.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Job.Duty.MinZ,
        maxZ = Config.InteractionLocations.Job.Duty.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:ToggleDuty",
            icon = Config.InteractionLocations.Job.Duty.Icon,
            label = Config.InteractionLocations.Job.Duty.Label,
            job = Config.CoreSettings.Job.Name,
        }
        },
        distance = 5.0,
    })
    exports['qb-target']:AddBoxZone("BossMenu", Config.InteractionLocations.Job.BossMenu.Location, Config.InteractionLocations.Job.BossMenu.Width, Config.InteractionLocations.Job.BossMenu.Height, {
        name = "BossMenu",
        heading = Config.InteractionLocations.Job.BossMenu.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Job.BossMenu.MinZ,
        maxZ = Config.InteractionLocations.Job.BossMenu.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = Config.CoreSettings.EventNames.BossMenu,
            icon = Config.InteractionLocations.Job.BossMenu.Icon,
            label = Config.InteractionLocations.Job.BossMenu.Label,
            job = Config.CoreSettings.Job.Name,
           
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("WashHands", Config.InteractionLocations.WashHands.Location, Config.InteractionLocations.WashHands.Width, Config.InteractionLocations.WashHands.Height, {
        name = "WashHands",
        heading = Config.InteractionLocations.WashHands.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.WashHands.MinZ,
        maxZ = Config.InteractionLocations.WashHands.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = 'lusty94_diner:client:WashHands',
            icon = Config.InteractionLocations.WashHands.Icon,
            label = Config.InteractionLocations.WashHands.Label,
            job = Config.CoreSettings.Name,
           
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("Payment", Config.InteractionLocations.Payment.Location, Config.InteractionLocations.Payment.Width, Config.InteractionLocations.Payment.Height, {
        name = "Payment",
        heading = Config.InteractionLocations.Payment.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Payment.MinZ,
        maxZ = Config.InteractionLocations.Payment.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:bill",
            icon = Config.InteractionLocations.Payment.Icon,
            label = Config.InteractionLocations.Payment.Label,
            job = Config.CoreSettings.Job.Name,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("CollectionTray", Config.InteractionLocations.CollectionTray.Location, Config.InteractionLocations.CollectionTray.Width, Config.InteractionLocations.CollectionTray.Height, {
        name = "CollectionTray",
        heading = Config.InteractionLocations.CollectionTray.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.CollectionTray.MinZ,
        maxZ = Config.InteractionLocations.CollectionTray.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:OpenCollectionTray",
            icon = Config.InteractionLocations.CollectionTray.Icon,
            label = Config.InteractionLocations.CollectionTray.Label,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("Grill", Config.InteractionLocations.Grill.Location, Config.InteractionLocations.Grill.Width, Config.InteractionLocations.Grill.Height, {
        name = "Grill",
        heading = Config.InteractionLocations.Grill.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Grill.MinZ,
        maxZ = Config.InteractionLocations.Grill.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:SandwichesMenu",
            icon = Config.InteractionLocations.Grill.Icon,
            label = Config.InteractionLocations.Grill.Label,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("ChoppingBoard", Config.InteractionLocations.ChoppingBoard.Location, Config.InteractionLocations.ChoppingBoard.Width, Config.InteractionLocations.ChoppingBoard.Height, {
        name = "ChoppingBoard",
        heading = Config.InteractionLocations.ChoppingBoard.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.ChoppingBoard.MinZ,
        maxZ = Config.InteractionLocations.ChoppingBoard.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:ChoppingBoardMenu",
            icon = Config.InteractionLocations.ChoppingBoard.Icon,
            label = Config.InteractionLocations.ChoppingBoard.Label,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("SlushieMachine", Config.InteractionLocations.SlushieMachine.Location, Config.InteractionLocations.SlushieMachine.Width, Config.InteractionLocations.SlushieMachine.Height, {
        name = "SlushieMachine",
        heading = Config.InteractionLocations.SlushieMachine.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.SlushieMachine.MinZ,
        maxZ = Config.InteractionLocations.SlushieMachine.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:SlushieMenu",
            icon = Config.InteractionLocations.SlushieMachine.Icon,
            label = Config.InteractionLocations.SlushieMachine.Label,
            job = Config.CoreSettings.Job.Name,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("SoftDrinks", Config.InteractionLocations.SoftDrinksMachine.Location, Config.InteractionLocations.SoftDrinksMachine.Width, Config.InteractionLocations.SoftDrinksMachine.Height, {
        name = "SoftDrinks",
        heading = Config.InteractionLocations.SoftDrinksMachine.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.SoftDrinksMachine.MinZ,
        maxZ = Config.InteractionLocations.SoftDrinksMachine.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:SoftDrinksMenu",
            icon = Config.InteractionLocations.SoftDrinksMachine.Icon,
            label = Config.InteractionLocations.SoftDrinksMachine.Label,
            job = Config.CoreSettings.Job.Name,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("HotDrinks", Config.InteractionLocations.HotDrinksMachine.Location, Config.InteractionLocations.HotDrinksMachine.Width, Config.InteractionLocations.HotDrinksMachine.Height, {
        name = "HotDrinks",
        heading = Config.InteractionLocations.HotDrinksMachine.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.HotDrinksMachine.MinZ,
        maxZ = Config.InteractionLocations.HotDrinksMachine.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:HotDrinksMenu",
            icon = Config.InteractionLocations.HotDrinksMachine.Icon,
            label = Config.InteractionLocations.HotDrinksMachine.Label,
            job = Config.CoreSettings.Job.Name,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("Fridge", Config.InteractionLocations.Fridge.Location, Config.InteractionLocations.Fridge.Width, Config.InteractionLocations.Fridge.Height, {
        name = "Fridge",
        heading = Config.InteractionLocations.Fridge.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Fridge.MinZ,
        maxZ = Config.InteractionLocations.Fridge.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:StorageFridge",
            icon = Config.InteractionLocations.Fridge.Icon,
            label = Config.InteractionLocations.Fridge.Label,
            job = Config.CoreSettings.Job.Name,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("Ingredients", Config.InteractionLocations.Ingredients.Location, Config.InteractionLocations.Ingredients.Width, Config.InteractionLocations.Ingredients.Height, {
        name = "Ingredients",
        heading = Config.InteractionLocations.Ingredients.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Ingredients.MinZ,
        maxZ = Config.InteractionLocations.Ingredients.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:IngredientsFridge",
            icon = Config.InteractionLocations.Ingredients.Icon,
            label = Config.InteractionLocations.Ingredients.Label,
            job = Config.CoreSettings.Job.Name,
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("Snacks", Config.InteractionLocations.SnackShelf.Location, Config.InteractionLocations.SnackShelf.Width, Config.InteractionLocations.SnackShelf.Height, {
        name = "Snacks",
        heading = Config.InteractionLocations.SnackShelf.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.SnackShelf.MinZ,
        maxZ = Config.InteractionLocations.SnackShelf.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:SnackShelf",
            icon = Config.InteractionLocations.SnackShelf.Icon,
            label = Config.InteractionLocations.SnackShelf.Label,
            
        }
        },
        distance = 2.0,
    })
    exports['qb-target']:AddBoxZone("Garage", Config.InteractionLocations.Job.Garage.Location, Config.InteractionLocations.Job.Garage.Width, Config.InteractionLocations.Job.Garage.Height, {
        name = "Garage",
        heading = Config.InteractionLocations.Job.Garage.Heading,
        debugPoly = Config.DebugPoly,
        minZ = Config.InteractionLocations.Job.Garage.MinZ,
        maxZ = Config.InteractionLocations.Job.Garage.MaxZ,
    }, {
        options = {
        {
            type = "client",
            event = "lusty94_diner:client:OpenGarageMenu",
            icon = Config.InteractionLocations.Job.Garage.Icon,
            label = Config.InteractionLocations.Job.Garage.Label,
            
        }
        },
        distance = 6.0,
    })
elseif Config.CoreSettings.Target.Type == 'ox' then
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.Job.Duty.Location,
        size = Config.InteractionLocations.Job.Duty.Size,
        rotation = Config.InteractionLocations.Job.Duty.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 1,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:ToggleDuty',
                label = Config.InteractionLocations.Job.Duty.Label,
                icon = Config.InteractionLocations.Job.Duty.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.Job.BossMenu.Location,
        size = Config.InteractionLocations.Job.BossMenu.Size,
        rotation = Config.InteractionLocations.Job.BossMenu.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 2,
                groups = Config.CoreSettings.Job.Name,
                event = Config.CoreSettings.EventNames.BossMenu,
                label = Config.InteractionLocations.Job.BossMenu.Label,
                icon = Config.InteractionLocations.Job.BossMenu.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.WashHands.Location,
        size = Config.InteractionLocations.WashHands.Size,
        rotation = Config.InteractionLocations.WashHands.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 3,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:WashHands',
                label = Config.InteractionLocations.WashHands.Label,
                icon = Config.InteractionLocations.WashHands.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.Payment.Location,
        size = Config.InteractionLocations.Payment.Size,
        rotation = Config.InteractionLocations.Payment.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 4,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:bill',
                label = Config.InteractionLocations.Payment.Label,
                icon = Config.InteractionLocations.Payment.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.CollectionTray.Location,
        size = Config.InteractionLocations.CollectionTray.Size,
        rotation = Config.InteractionLocations.CollectionTray.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 5,
                event = 'lusty94_diner:client:OpenCollectionTray',
                label = Config.InteractionLocations.CollectionTray.Label,
                icon = Config.InteractionLocations.CollectionTray.Icon,
            }
        }
    }) 
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.Grill.Location,
        size = Config.InteractionLocations.Grill.Size,
        rotation = Config.InteractionLocations.Grill.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 6,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:SandwichesMenu',
                label = Config.InteractionLocations.Grill.Label,
                icon = Config.InteractionLocations.Grill.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.ChoppingBoard.Location,
        size = Config.InteractionLocations.ChoppingBoard.Size,
        rotation = Config.InteractionLocations.ChoppingBoard.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 7,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:ChoppingBoardMenu',
                label = Config.InteractionLocations.ChoppingBoard.Label,
                icon = Config.InteractionLocations.ChoppingBoard.Icon,
            }
        }
    })
      
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.SlushieMachine.Location,
        size = Config.InteractionLocations.SlushieMachine.Size,
        rotation = Config.InteractionLocations.SlushieMachine.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 8,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:SlushieMenu',
                label = Config.InteractionLocations.SlushieMachine.Label,
                icon = Config.InteractionLocations.SlushieMachine.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.SoftDrinksMachine.Location,
        size = Config.InteractionLocations.SoftDrinksMachine.Size,
        rotation = Config.InteractionLocations.SoftDrinksMachine.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 9,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:SoftDrinksMenu',
                label = Config.InteractionLocations.SoftDrinksMachine.Label,
                icon = Config.InteractionLocations.SoftDrinksMachine.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.HotDrinksMachine.Location,
        size = Config.InteractionLocations.HotDrinksMachine.Size,
        rotation = Config.InteractionLocations.HotDrinksMachine.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 10,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:HotDrinksMenu',
                label = Config.InteractionLocations.HotDrinksMachine.Label,
                icon = Config.InteractionLocations.HotDrinksMachine.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.Fridge.Location,
        size = Config.InteractionLocations.Fridge.Size,
        rotation = Config.InteractionLocations.Fridge.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 11,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:OpenStorageFridge',
                label = Config.InteractionLocations.Fridge.Label,
                icon = Config.InteractionLocations.Fridge.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.Ingredients.Location,
        size = Config.InteractionLocations.Ingredients.Size,
        rotation = Config.InteractionLocations.Ingredients.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 12,
                groups = Config.CoreSettings.Job.Name,
                event = 'lusty94_diner:client:IngredientsFridge',
                label = Config.InteractionLocations.Ingredients.Label,
                icon = Config.InteractionLocations.Ingredients.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.SnackShelf.Location,
        size = Config.InteractionLocations.SnackShelf.Size,
        rotation = Config.InteractionLocations.SnackShelf.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 13,
                event = 'lusty94_diner:client:SnackShelf',
                label = Config.InteractionLocations.SnackShelf.Label,
                icon = Config.InteractionLocations.SnackShelf.Icon,
            }
        }
    })
    exports.ox_target:addBoxZone({
        coords = Config.InteractionLocations.Job.Garage.Location,
        size = Config.InteractionLocations.Job.Garage.Size,
        rotation = Config.InteractionLocations.Job.Garage.Heading,
        debug = Config.DebugPoly,
        options = {
            {
                id = 14,
                event = 'lusty94_diner:client:OpenGarageMenu',
                label = Config.InteractionLocations.Job.Garage.Label,
                icon = Config.InteractionLocations.Job.Garage.Icon,
            }
        }
    })
elseif Config.CoreSettings.Target.Type == 'custom' then
-- inset custom target code here
end