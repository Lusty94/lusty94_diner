Config = {}


--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


--Thank you for downloading this script!

--Below you can change multiple options to suit your server needs.


 
Config.DebugPoly = true
--Debugs polyzones and shows green boxes


Config.UseJimConsumables = true
--Uses jim-consumables for consuming food / drink items -- IF SET TO FALSE MAKE SURE TO ADD THE ITEM NAMES TO YOUR OWN CONSUMABLES SCRIPT


--Blip Settings
Config.Blips = {
    {title = 'Pops Diner', colour = 24, id = 267, coords = vector3(1594.82, 6448.11, 25.32), scale = 0.7, useblip = true},
}


Config.CoreSettings = {
    Job = {
        Name = 'diner', -- name of job in core/shared/jobs.lua
    },
    EventNames = {
        BossMenu = 'qb-bossmenu:client:OpenMenu', -- NAME OF BOSS MENU EVENT TO OPEN MANAGEMENT MENU
        Fuel = 'LegacyFuel', -- NAME OF FUEL SCRIPT
        Keys = 'vehiclekeys:client:SetOwner', -- NAME OF KEYS EVENT TO SET PLAYER AS OWNER WHEN RENTING WORK VEHICLE
    },
    Target = {
        Type = 'qb', -- target script name support for qb-target and ox_target 
        --EDIT TARGETS.LUA TO ADD YOUR OWN CUSTOM TARGET SCRIPT        
        --use 'qb' for qb-target
        --use 'ox' for ox_target
        --use 'custom' for custom target 
    },
    Notify = {
        Type = 'qb', -- notification type, support for qb-core notify, okokNotify, boii_ui notify and ox_lib notify
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for mythic_notify
        --use 'boii' for boii_ui notify
        --use 'ox' for ox_lib notify
        Sound = true, -- use sound for OKOK notifications ONLY
        Length = { Success = 2500, Error = 2500, },
    },    
    Menu = {
        Type = 'qb', -- menu script name, support for qb-menu, jixel-menu, boii_ui menu and ox_lib context menu
        --EDIT MENUS.LUA TO ADD YOUR OWN CUSTOM MENU SCRIPT 
        --use 'qb' for qb-menu
        --use 'jixel' for jixel-menu
        --use 'boii' for boii_ui-menu
        --use 'ox' for ox_lib context menu
        --use 'custom' for your own custom menu
    },
    Sound = {
        UseInteractSound = true, -- set to true to play sound when performing certain actions 
        --[[ REQUIRES INTERACT-SOUND AND MUST BE STARTED BEFORE THIS RESOURCE TO WORK PROPERLY]]
        --[[ MAKE SURE YOU HAVE PUT THE .OGG FILES INSIDE OF [SOUNDS] IN YOUR INTERACT-SOUND/CLIENT/HTML/SOUNDS FOLDER TO WORK PROPERLY ]]

        -- [[  IF YOU CHANGE ANY SOUNDS BELOW THEN MAKE SURE THE .OGG FILE IS LOCATED IN YOUR INTERACT-SOUND/CLIENT/HTML/SOUNDS TO WORK PROPERLY AND NAMED CORRECTLY ]]

        PourSlushies = 'slushiemachine', -- sound to be played when preparing slushies
        PourHotDrinks = 'hotdrinksmachine', -- sound to be played when preparing hot drinks
        PourSoftDrinks = 'fizzydrinksmachine', -- sound to be played when preparing soft drinks
        SliceIngredients = 'sliceingredients', -- sound to be played when cooking food
        CookFoods = 'cooker', -- sound to be played when cooking food
    },
    Shop = {
        Type = 'qb', -- support for qb shops and jim shops
        --use 'qb' for qb-shops 
        --use 'jim' for jim-shops
    },
    ProgressBar = {
        Times = {
            WashHands = 5000, -- time it takes to wash hands [default is 5000ms so 5 seconds]
            SliceIngredients = 5000, -- time it takes to wash hands [default is 5000ms so 5 seconds]
            PourSoftDrinks = 10000, -- time it takes to prepare soft drinks [default is 10000 MS so 10 seconds]
            PrepareHotDrinks = 10000,  -- time it takes to prepare hot drinks [default is 10000 MS so 10 seconds]
            PourSlushies = 10000,  -- time it takes to prepare slushies [default is 10000 MS so 10 seconds]
            CookFoods = 7500,  -- time it takes to cook foods [default is 7500 MS so 7.5 seconds]
        },
    },
}



Config.InteractionLocations = {
    Job = {
        Duty = { Location = vector3(1592.56, 6454.3, 26.15), Height = 0.2, Width = 0.4, Heading = 337.8, MinZ = 26.10, MaxZ = 26.25, Icon = 'fa-solid fa-clipboard-user', Label = "Toggle Duty", Size = vec3(0.2,0.4,0.15), },
        Garage = { Location = vector3(1579.44, 6453.94, 25), Height = 0.8, Width = 0.8, Heading = 337.8, MinZ = 24, MaxZ = 25.5, Icon = 'fa-solid fa-car', Label = "Rent Work Vehicle", Size = vec3(0.8,0.8,1), },
        Vehicle = { Name = 'speedo', Plate = 'DINER', SpawnLocation = vector4(1577.63, 6450.48, 24.99, 158.88),},
        BossMenu = { Location = vector3(1595.17, 6453.0, 26.45), Height = 0.6, Width = 0.3, Heading = 167.4, MinZ = 26.10, MaxZ = 26.65, Icon = 'fa-solid fa-users', Label = "Open Management Menu", Size = vec3(0.6,0.3,0.5), },
                    -- IF MOVING MANAGEMENT MENU DONT FORGET TO MOVE THE COMPUTER PROP LOCATION TOO
    },
    WashHands = {
        Location = vector3(1591.20, 6457.70, 26.05), Height = 0.4, Width = 0.4, Heading = 318.3, MinZ = 26.10, MaxZ = 26.5, CashSymbol = '£', Icon = 'fa-solid fa-hands', Label = "Wash Hands", Size = vec3(0.4,0.4,0.2), 
    },
    Payment = {
        Location = vector3(1589.16, 6458.18, 26.25), Height = 0.5, Width = 0.5, Heading = 335, MinZ = 26.10, MaxZ = 26.5, CashSymbol = '£', Icon = 'fa-solid fa-cash-register', Label = "Charge Customer", Size = vec3(0.5,0.5,0.4), 
    },
    CollectionTray = {
        Location = vector3(1590.3, 6455.25, 26.19), Height = 0.8, Width = 0.5, Heading = 155.24, MinZ = 26.10, MaxZ = 26.25, Icon = 'fa-solid fa-box-archive', Label = "Open Collection Tray",  Size = vec3(0.5,0.5,0.2),
        StashSize = 1000000,  
        StashSlots = 5,       
    },
    Grill = {
        Location = vector3(1587.93, 6458.92, 26.25), Height = 1.5, Width = 0.5, Heading = 335, MinZ = 26.10, MaxZ = 26.35, Icon = 'fa-solid fa-ice-cream', Label = "Cook Food", Size = vec3(1.5,0.5,0.35),
    },
    ChoppingBoard = {
        Location = vector3(1586.98, 6459.33, 26.25), Height = 0.5, Width = 0.5, Heading = 335, MinZ = 26.10, MaxZ = 26.25, Icon = 'fa-solid fa-ice-cream', Label = "Chop Ingredients", Size = vec3(0.5,0.5,0.25),
    },
    SlushieMachine = {
        Location = vector3(1594.13, 6455.92, 26.40), Height = 0.6, Width = 0.5, Heading = 335, MinZ = 26.10, MaxZ = 26.95, Icon = 'fa-solid fa-blender', Label = "Pour Slushies", Size = vec3(0.6,0.5,0.8),
    },
    SoftDrinksMachine = {
        Location = vector3(1586.08, 6459.68, 26.25), Height = 1.1, Width = 0.6, Heading = 335, MinZ = 26.10, MaxZ = 27, Icon = 'fa-solid fa-glass-water', Label = "Pour Soft Drinks", Size = vec3(1.1,0.6,1),
    },
    HotDrinksMachine = {
        Location = vector3(1592.27, 6456.86, 26.25), Height = 0.8, Width = 0.4, Heading = 335, MinZ = 26.10, MaxZ = 26.7, Icon = 'fa-solid fa-mug-hot', Label = "Prepare Hot Drinks", Size = vec3(0.95,0.4,1),
    },
    Fridge = { 
        Location = vector3(1596.07, 6454.55, 26.25), Height = 0.75, Width = 1.0, Heading = 335, MinZ = 25, MaxZ = 27.5, Icon = 'fa-solid fa-box-archive', Label = "Open Storage Fridge", Size = vec3(0.8,1.0,2),
        StashSize = 10000000,
        StashSlots = 64,
    },
    Ingredients = { 
        Location = vector3(1594.76, 6455.54, 25.55), Height = 1.8, Width = 0.8, Heading = 335, MinZ = 25, MaxZ = 26, Icon = 'fa-solid fa-box-archive', Label = "Open Ingredients Cupboard", Size = vec3(1.7,0.8,1),
        -- IF MOVING INGREDIENTS FRIDGE DONT FORGET TO MOVE THE FRIDGE PROP LOCATION TOO
        Items = {
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
        },
    },
    SnackShelf = {
        Location = vector3(1588.83, 6456.13, 25.7), Height = 1.5, Width = 0.8, Heading = 335, MinZ = 25, MaxZ = 26.0, Icon = 'fa-solid fa-cookie-bite', Label = "Open Snack Shelf", Size = vec3(1.5,0.5,1),
        Items = {
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
        },
    },
}

Config.Animations = {
    WashingHands = {
        AnimDict = "mp_arresting",
        Anim = "a_uncuff",
        Flags = 8,
    },
    PourHotDrinks = {
        AnimDict = "amb@prop_human_bbq@male@idle_a",
        Anim = "idle_a",
        Flags = 41,
    },
    PourSoftDrinks = {
        AnimDict = "amb@prop_human_bbq@male@idle_a",
        Anim = "idle_a",
        Flags = 41,
    },
    PourSlushies = {
        AnimDict = "amb@prop_human_bbq@male@idle_a",
        Anim = "idle_a",
        Flags = 41,
    },
    SliceIngredients = {
        AnimDict = "amb@prop_human_parking_meter@female@base",
        Anim = "base_female",
        Flags = 41,
    },
    CookFood = {
        AnimDict = "amb@prop_human_parking_meter@female@base",
        Anim = "base_female",
        Flags = 41,
    },
}


Config.Language = {
    Notifications = {       CancelledLabel = "Action Cancelled!",                       CancelledName = 'Cancelled',    MissingItemsLabel = "Mising Items!", MissingItemsName = "You Are Missing Items, Check The Recipe!", DutyLabel = 'Duty Check!', DutyName = 'You Must Be On Duty To Do This!'},
    WashHands = {           ProgressBarName = "Washing Hands!",                         NotifyLabel = "Hands Clean!",   NotifyName = "You Washed your Hands!", },
    Coffee = {              ProgressBarName = "Preparing Coffee!",                      NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Coffee!", },
    Tea = {                 ProgressBarName = "Preparing Tea!",                         NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Tea!", },
    HotChocolate = {        ProgressBarName = "Preparing Hot Chocolate!",               NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Hot Chocolate!", },
    ECola = {               ProgressBarName = "Preparing E-Cola!",                      NotifyLabel = "Item Prepared!", NotifyName = "You Prepared An E-Cola!", },
    EColaLight = {          ProgressBarName = "Preparing E-Cola Light!",                NotifyLabel = "Item Prepared!", NotifyName = "You Prepared An E-Cola Light!", },
    Sprunk = {              ProgressBarName = "Preparing Sprunk!",                      NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Sprunk!", },
    OrangeSoda = {          ProgressBarName = "Preparing Orange Soda!",                 NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Orange Soda!", },
    SlicedBread = {         ProgressBarName = "Slicing Bread!",                         NotifyLabel = "Item Prepared!", NotifyName = "You Sliced Some Bread!", },
    SlicedBacon = {         ProgressBarName = "Slicing Bacon!",                         NotifyLabel = "Item Prepared!", NotifyName = "You Sliced Some Bacon!", },
    SlicedAvocado = {       ProgressBarName = "Slicing Avocado!",                       NotifyLabel = "Item Prepared!", NotifyName = "You Sliced Some Avocado!", },
    TunaChunks = {          ProgressBarName = "Chunking Tuna!",                         NotifyLabel = "Item Prepared!", NotifyName = "You Chunked Some Tuna!", },
    TurkeySlices = {        ProgressBarName = "Slicing Turkey!",                        NotifyLabel = "Item Prepared!", NotifyName = "You Sliced Some Turkey!", },
    GrilledCheese = {       ProgressBarName = "Cooking Grilled Cheese Sandwich!",       NotifyLabel = "Item Prepared!", NotifyName = "You Cooked A Grilled Cheese Sandwich!", },
    ChickenMozzarella = {   ProgressBarName = "Cooking Chicken & Mozzarella Sandwich!", NotifyLabel = "Item Prepared!", NotifyName = "You Cooked A Chicken & Mozzarella Sandwich!", },
    BaconAvocado = {        ProgressBarName = "Cooking Bacon & Avocado Sandwich!",      NotifyLabel = "Item Prepared!", NotifyName = "You Cooked A Bacon & Avocado Sandwich!", },
    TunaSweetcorn = {       ProgressBarName = "Cooking Tuna & Sweetcorn Sandwich!",     NotifyLabel = "Item Prepared!", NotifyName = "You Cooked A Tuna & Sweetcorn Sandwich!", },
    TurkeyCranberry = {     ProgressBarName = "Cooking Turkey & Cranberry Sandwich!",   NotifyLabel = "Item Prepared!", NotifyName = "You Cooked A Turkey & Cranberry Sandwich!", },
    EggsBacon = {           ProgressBarName = "Cooking Eggs & Bacon Sandwich!",         NotifyLabel = "Item Prepared!", NotifyName = "You Cooked A Eggs & Bacon Sandwich!", },
    BlueRaspberrySlushie = {ProgressBarName = "Preparing Blue Raspberry Slushie!",      NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Blue Raspberry Slushie!", },
    TropicalSlushie = {     ProgressBarName = "Preparing Tropical Slushie!",            NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Tropical Slushie!", },
    StrawberrySlushie = {   ProgressBarName = "Preparing Strawberry Slushie!",          NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Strawberry Slushie!", },
    LemonLimeSlushie = {    ProgressBarName = "Preparing Lemon N Lime Slushie!",        NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Lemon N Lime Slushie!", },
    OrangeSlushie = {       ProgressBarName = "Preparing Orange Slushie!",              NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Orange Slushie!", },
    GrapeSlushie = {        ProgressBarName = "Preparing Grape Slushie!",               NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Grape Slushie!", },
    CherrySlushie = {       ProgressBarName = "Preparing Cherry Slushie!",              NotifyLabel = "Item Prepared!", NotifyName = "You Prepared A Cherry Slushie!", },
    
}