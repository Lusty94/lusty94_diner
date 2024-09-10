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


 
Config.DebugPoly = false
--Debugs polyzones and shows green boxes

Config.DevMode = false
--cancels duty check for events set to false for a live server

Config.UseJimConsumables = false
--Uses jim-consumables for consuming food / drink items -- IF SET TO FALSE MAKE SURE TO ADD THE ITEM NAMES TO YOUR OWN CONSUMABLES SCRIPT


--Blip Settings
Config.Blips = {
    {
        title = 'Pops Diner', 
        colour = 24, 
        id = 267, 
        coords = vector3(1594.82, 6448.11, 25.32), 
        scale = 0.7, 
        useblip = true
    },
}


Config.CoreSettings = {
    Job = {
        Name = 'diner', -- name of job in core/shared/jobs.lua
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
    },
    Inventory = { -- support for qb-inventory and ox_inventory
        Type = 'qb',
        --use 'qb' for qb-inventory
        --use 'ox' for ox_inventory
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
        CookFood = 'cooker', -- sound to be played when cooking food
    },
    Timers = {
        WashHands = 5000, -- time it takes to wash hands [default is 5000ms so 5 seconds]
        SliceIngredients = 5000, -- time it takes to wash hands [default is 5000ms so 5 seconds]
        PourSoftDrinks = 10000, -- time it takes to prepare soft drinks [default is 10000 MS so 10 seconds]
        PourHotDrinks = 10000,  -- time it takes to prepare hot drinks [default is 10000 MS so 10 seconds]
        PourSlushies = 10000,  -- time it takes to prepare slushies [default is 10000 MS so 10 seconds]
        CookFood = 7500,  -- time it takes to cook foods [default is 7500 MS so 7.5 seconds]
    },
    Vehicle = {
        Keys = 'vehiclekeys:client:SetOwner', -- name of keys event
        SpawnCoords = vector4(1577.63, 6450.48, 24.99, 158.88), -- spawn location
        Name = 'asbo', -- spawn name
        Label = 'Asbo', -- label for menus
    },
}

Config.InteractionLocations = {
    JobAreas = {
        { Name = "dinerpayment",            Location = vector3(1589.16, 6458.18, 26.25),    Width = 0.5,    Height = 0.5,       Heading = 335.0,  MinZ = 26.10,    MaxZ = 26.65,     Icon = 'fa-solid fa-cash-register',    Label = 'Charge Customer',          Job = 'diner',      Size = vec3(0.5,0.5,0.4),    Event = 'lusty94_diner:bill',                      Distance = 2.0,},
        { Name = "dinercollectiontray",     Location = vector3(1590.3, 6455.25, 26.19),     Width = 0.5,    Height = 0.8,       Heading = 155.24,  MinZ = 26.10,   MaxZ = 26.65,     Icon = 'fa-solid fa-box-archive',      Label = 'Open Collection Tray',     Job = nil,          Size = vec3(0.5,0.5,0.2),    Event = 'lusty94_diner:client:OpenCollectionTray', Distance = 2.0,},
        { Name = "dinergrill",              Location = vector3(1587.93, 6458.92, 26.25),    Width = 0.5,    Height = 1.5,       Heading = 335.0,  MinZ = 26.10,    MaxZ = 26.65,     Icon = 'fa-solid fa-fire',             Label = 'Cook Food',                Job = 'diner',      Size = vec3(1.5,0.5,0.35),   Event = 'lusty94_diner:client:SandwichesMenu',     Distance = 2.0,},
        { Name = "dinerchoppingboard",      Location = vector3(1586.98, 6459.33, 26.25),    Width = 0.5,    Height = 0.5,       Heading = 335.0,  MinZ = 26.10,    MaxZ = 26.65,     Icon = 'fa-solid fa-hand-point-up',    Label = 'Chop Ingredients',         Job = 'diner',      Size = vec3(0.5,0.5,0.25),   Event = 'lusty94_diner:client:ChoppingBoardMenu',  Distance = 2.0,},
        { Name = "dinerslushies",           Location = vector3(1594.13, 6455.92, 26.40),    Width = 0.5,    Height = 0.6,       Heading = 335.0,  MinZ = 26.10,    MaxZ = 26.95,     Icon = 'fa-solid fa-blender',          Label = 'Pour Slushies',            Job = 'diner',      Size = vec3(0.6,0.5,0.8),    Event = 'lusty94_diner:client:SlushieMenu',        Distance = 2.0,},
        { Name = "dinersoftdrinks",         Location = vector3(1586.08, 6459.68, 26.25),    Width = 0.6,    Height = 1.1,       Heading = 335.0,  MinZ = 26.10,    MaxZ = 27.0,      Icon = 'fa-solid fa-glass-water',      Label = 'Pour Soft Drinks',         Job = 'diner',      Size = vec3(1.1,0.6,1.0),    Event = 'lusty94_diner:client:SoftDrinksMenu',     Distance = 2.0,},
        { Name = "dinerhotdrinks",          Location = vector3(1592.27, 6456.86, 26.25),    Width = 0.4,    Height = 0.8,       Heading = 335.0,  MinZ = 26.10,    MaxZ = 26.70,     Icon = 'fa-solid fa-mug-hot',          Label = 'Pour Hot Drinks',          Job = 'diner',      Size = vec3(0.95,0.4,1.0),   Event = 'lusty94_diner:client:HotDrinksMenu',      Distance = 2.0,},
        { Name = "dineringredientsfridge",  Location = vector3(1594.76, 6455.54, 25.55),    Width = 0.8,    Height = 1.8,       Heading = 335.0,  MinZ = 25.0,     MaxZ = 26.0,      Icon = 'fa-solid fa-box-archive',      Label = 'Open Ingredients Fridge',  Job = 'diner',      Size = vec3(1.7,0.8,1.0),    Event = 'lusty94_diner:client:IngredientsFridge',  Distance = 2.0,},
        { Name = "dinersnacks",             Location = vector3(1588.83, 6456.13, 25.7),     Width = 0.8,    Height = 1.5,       Heading = 335.0,  MinZ = 25.0,     MaxZ = 26.0,      Icon = 'fa-solid fa-cookie-bite',      Label = 'Open Snack Shelf',         Job = nil,          Size = vec3(1.5,0.5,1.0),    Event = 'lusty94_diner:client:SnackShelf',         Distance = 2.0,},
    },
    Props = {
        { Model = 'xm_prop_x17_computer_01',          Coords = vector3(1595.17, 6453.0, 26.15),    Heading = 163.04, Icon = 'fa-solid fa-user',          Label = 'Open Management Menu',     Event = 'qb-bossmenu:client:OpenMenu',             Job = 'diner', Distance = 2.0,},
        { Model = 'bkr_prop_fakeid_clipboard_01a',    Coords = vector3(1592.56, 6454.3, 26.15),    Heading = 160.28, Icon = 'fa-solid fa-user',          Label = 'Toggle Duty',              Event = 'lusty94_diner:client:ToggleDuty',         Job = 'diner', Distance = 2.0,},
        { Model = 'prop_fridge_01',                   Coords = vector3(1596.3, 6454.9, 25.0),      Heading = 336.5,  Icon = 'fa-solid fa-hand-point-up', Label = 'Open Storage Fridge',      Event = 'lusty94_diner:client:StorageFridge',      Job = 'diner', Distance = 2.0,},
        { Model = 'prop_ff_sink_01',                  Coords = vector3(1591.20, 6457.70, 25.93),   Heading = -115.0, Icon = 'fa-solid fa-hand-point-up', Label = 'Wash Hands',               Event = 'lusty94_diner:client:WashHands',          Job = 'diner', Distance = 2.0,},
        { Model = 'prop_parkingpay',                  Coords = vector3(1579.44, 6453.94, 24.2),    Heading = 336.22, Icon = 'fa-solid fa-hand-point-up', Label = 'Get Work Vehicle',         Event = 'lusty94_diner:client:OpenGarageMenu',     Job = 'diner', Distance = 2.0,},
    },
}


Config.Animations = {
    WashingHands = {
        dict = "mp_arresting",
        anim = "a_uncuff",
        flag = 8,
    },
    PourHotDrinks = {
        dict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_a",
        flag = 41,
    },
    PourSoftDrinks = {
        dict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_a",
        flag = 41,
    },
    PourSlushies = {
        dict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_a",
        flag = 41,
    },
    SliceIngredients = {
        dict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_b",
        flag = 41,
        prop = 'v_ind_cfknife',
        bone = 57005,
        pos = vec3(0.2, 0.14, -0.01),
        rot = vec3(1.0, 4.0, 57.0),
    },
    CookFood = {
        dict = "amb@prop_human_bbq@male@idle_a",
        anim = "idle_b",
        flag = 41,
    },
}

Config.Language = {
    ProgressBar = {
        WashHands = 'Washing hands',
        PrepareDrinks = 'Preparing drink',
        PrepareSlushie = 'Preparing slushie',
        PrepareIngredients = 'Preparing ingredients',
        CookFood = 'Cooking food',
    },
    Notifications = {
        Duty = 'You must be clocked on duty to proceed!',
        Busy = 'You are already doing something!',
        Cancelled = 'Action cancelled!',
        Failed = 'Action failed!',
        CantCarry = 'You cant carry anymore!',
        NoItems = 'You are missing items - check the requirements!',
        DrinkPrepared = 'Drink prepared!',
        SlushiePrepared = 'Slushie prepared!',
        IngredientPrepared = 'Ingredient prepared!',
        FoodCooked = 'Meal cooked!',
        VehicleRented = 'You have already rented a vehicle, return it first!',
    },
}