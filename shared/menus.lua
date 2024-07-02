local MenuType = Config.CoreSettings.Menu.Type


-------------------------------------------------------< SMOOTHIE MENU START >---------------------------------------------------
local SlushieMenuDiner = {
    {
        header = "🥤 Prepare Fresh Slushies!",
        isMenuHeader = true,
    },  
    {   
        header = "🫐 Prepare Blue Raspberry Slushie",
        txt = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Blue Raspberry Syrup </br> Slushie Cup",
        params = {
            event = "lusty94_diner:client:PrepareBlueRaspberrySlushie",
        }
    },               
    {   
        header = "🍹 Prepare Tropical Slushie",
        txt = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Tropical Syrup </br> Slushie Cup",
        params = {
            event = "lusty94_diner:client:PrepareTropicalSlushie",
        }
    },               
    {   
        header = "🍓 Prepare Strawberry Slushie",
        txt = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Strawberry Syrup </br> Slushie Cup",
        params = {
            event = "lusty94_diner:client:PrepareStrawberrySlushie",
        }
    },               
    {   
        header = "🍋 Prepare Lemon N Lime Slushie",
        txt = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Lemon N Lime Syrup </br> Slushie Cup",
        params = {
            event = "lusty94_diner:client:PrepareLemonLimeSlushie",
        }
    },               
    {   
        header = "🍇 Prepare Grape Slushie",
        txt = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Grape Syrup </br> Slushie Cup",
        params = {
            event = "lusty94_diner:client:PrepareGrapeSlushie",
        }
    },               
    {   
        header = "🍒 Prepare Cherry Slushie",
        txt = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Cherry Syrup </br> Slushie Cup",
        params = {
            event = "lusty94_diner:client:PrepareCherrySlushie",
        }
    },               
    {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}

lib.registerContext({
    id = 'SlushieMenuDiner',
    title = '🥤 Prepare Fresh Slushies!',
    options = {
      {
        title = '🥤 Get Slushie Cup',
        event = 'lusty94_diner:client:GiveSlushieCup',
        arrow = true,
      },
      {
        title = '🫐 Prepare Blue Raspberry Slushie',
        event = 'lusty94_diner:client:PrepareBlueRaspberrySlushie',
        arrow = true,
        metadata = {
            {label = 'Crushed Ice Required', value = 1},
            {label = 'Blue Raspberry Syrup Required', value = 1},
            {label = 'Slushie Cup Required', value = 1},
          },
      },
      {
        title = '🍹 Prepare Tropical Slushie',
        event = 'lusty94_diner:client:PrepareTropicalSlushie',
        arrow = true,
        metadata = {
            {label = 'Crushed Ice Required', value = 1},
            {label = 'Tropical Syrup Required', value = 1},
            {label = 'Slushie Cup Required', value = 1},
          },
      },
      {
        title = '🍓 Prepare Strawberry Slushie',
        event = 'lusty94_diner:client:PrepareStrawberrySlushie',
        arrow = true,
        metadata = {
            {label = 'Crushed Ice Required', value = 1},
            {label = 'Strawberry Syrup Required', value = 1},
            {label = 'Slushie Cup Required', value = 1},
          },
      },
      {
        title = '🍋 Prepare Lemon N Lime Slushie',
        event = 'lusty94_diner:client:PrepareLemonLimeSlushie',
        arrow = true,
        metadata = {
            {label = 'Crushed Ice Required', value = 1},
            {label = 'Lemon N Lime Syrup Required', value = 1},
            {label = 'Slushie Cup Required', value = 1},
          },
      },
      {
        title = '🍊 Prepare Orange Slushie',
        event = 'lusty94_diner:client:PrepareOrangeSlushie',
        arrow = true,
        metadata = {
            {label = 'Crushed Ice Required', value = 1},
            {label = 'Orange Syrup Required', value = 1},
            {label = 'Slushie Cup Required', value = 1},
          },
      },
      {
        title = '🍇 Prepare Grape Slushie',
        event = 'lusty94_diner:client:PrepareGrapeSlushie',
        arrow = true,
        metadata = {
            {label = 'Crushed Ice Required', value = 1},
            {label = 'Grape Syrup Required', value = 1},
            {label = 'Slushie Cup Required', value = 1},
          },
      },
      {
        title = '🍒 Prepare Cherry Slushie',
        event = 'lusty94_diner:client:PrepareCherrySlushie',
        arrow = true,
        metadata = {
            {label = 'Crushed Ice Required', value = 1},
            {label = 'Cherry Syrup Required', value = 1},
            {label = 'Slushie Cup Required', value = 1},
          },
      },
            
    }
})


RegisterNetEvent('lusty94_diner:client:SlushieMenu', function()
    if MenuType == 'qb' then
        exports['qb-menu']:openMenu(SlushieMenuDiner)
    elseif MenuType == 'jixel' then
        exports['jixel-menu']:openMenu(SlushieMenuDiner)
    elseif MenuType == 'ox' then
        lib.showContext('SlushieMenuDiner')
    elseif MenuType == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< SMOOTHIE MENU END >---------------------------------------------------




-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local HotDrinksMenuDiner = {
    {
        header = "☕ Prepare Fresh Fruit Smoothies!",
        isMenuHeader = true,
    },  
    {   
        header = "☕ Get A Mug",
        params = {
            event = "lusty94_diner:client:GiveMug",
        }
    },          
    {   
        header = "🍵 Prepare Cup of Tea",
        txt = "Mug Required",
        params = {
            event = "lusty94_diner:client:PrepareTea",
        }
    },       
    {   
        header = "☕ Prepare Cup of Coffee",
        txt = "Mug Required",
        params = {
            event = "lusty94_diner:client:PrepareCoffee",
        }
    },       
    {   
        header = "🍫 Prepare Cup of Hot Chocolate",
        txt = "Mug Required",
        params = {
            event = "lusty94_diner:client:PrepareHotChocolate",
        }
    },       
    {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}

lib.registerContext({
    id = 'HotDrinksMenuDiner',
    title = '☕ Prepare Hot Drinks!',
    options = {
      {
        title = '☕ Get A Mug',
        icon = 'mug-saucer',
        event = 'lusty94_diner:client:GiveMug',
        arrow = true,
      },
      {
        title = '🍵 Prepare Cup of Tea', 
        event = 'lusty94_diner:client:PrepareTea',
        description = 'Mug Required',
        arrow = true,
      },
      {
        title = '☕Prepare Cup of Coffee', 
        event = 'lusty94_diner:client:PrepareCoffee',
        description = 'Mug Required',
        arrow = true,
      },
      {
        title = '🍫 Prepare Cup of Hot Chocolate', 
        event = 'lusty94_diner:client:PrepareHotChocolate',
        description = 'Mug Required',
        arrow = true,
      },
    }
})


RegisterNetEvent('lusty94_diner:client:HotDrinksMenu', function()
    if MenuType == 'qb' then
        exports['qb-menu']:openMenu(HotDrinksMenuDiner)
    elseif MenuType == 'jixel' then
        exports['jixel-menu']:openMenu(HotDrinksMenuDiner)
    elseif MenuType == 'ox' then
        lib.showContext('HotDrinksMenuDiner')
    elseif MenuType == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------




-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local SoftDrinksMenuDiner = {
    {
        header = "🥤 Prepare Soft Drinks!",
        isMenuHeader = true,
    },  
    {   
        header = "🥤 Get A Soft Drinks Cup",
        params = {
            event = "lusty94_diner:client:GiveSoftDrinksCup",
        }
    },          
    {   
        header = "🥤 Prepare Cup of E-Cola",
        txt = "Soft Drinks Cup Required",
        params = {
            event = "lusty94_diner:client:PrepareECola",
        }
    },       
    {   
        header = "🥤 Prepare Cup of E-Cola Light",
        txt = "Soft Drinks Cup Required",
        params = {
            event = "lusty94_diner:client:PrepareEColaLight",
        }
    },       
    {   
        header = "🍋 Prepare Cup of Sprunk",
        txt = "Soft Drinks Cup Required",
        params = {
            event = "lusty94_diner:client:PrepareSprunk",
        }
    },       
    {   
        header = "🍊 Prepare Cup of Orange Soda",
        txt = "Soft Drinks Cup Required",
        params = {
            event = "lusty94_diner:client:PrepareOrangeSoda",
        }
    },       
    {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}

lib.registerContext({
    id = 'SoftDrinksMenuDiner',
    title = '🥤 Prepare Soft Drinks!',
    options = {
      {
        title = '🥤 Get A Soft Drinks Cup', 
        event = 'lusty94_diner:client:GiveSoftDrinksCup',
        arrow = true,
      },
      {
        title = '🥤 Prepare Cup of E-Cola', 
        event = 'lusty94_diner:client:PrepareECola',
        description = 'Soft Drinks Cup Required',
        arrow = true,
      },
      {
        title = '🥤 Prepare Cup of E-Cola Light', 
        event = 'lusty94_diner:client:PrepareEColaLight',
        description = 'Soft Drinks Cup Required',
        arrow = true,
      },
      {
        title = '🍋 Prepare Cup of Sprunk', 
        event = 'lusty94_diner:client:PrepareSprunk',
        description = 'Soft Drinks Cup Required',
        arrow = true,
      },
      {
        title = '🍊 Prepare Cup of Orange Soda', 
        event = 'lusty94_diner:client:PrepareOrangeSoda',
        description = 'Soft Drinks Cup Required',
        arrow = true,
      },
    }
})


RegisterNetEvent('lusty94_diner:client:SoftDrinksMenu', function()
    if MenuType == 'qb' then
        exports['qb-menu']:openMenu(SoftDrinksMenuDiner)
    elseif MenuType == 'jixel' then
        exports['jixel-menu']:openMenu(SoftDrinksMenuDiner)
    elseif MenuType == 'ox' then
        lib.showContext('SoftDrinksMenuDiner')
    elseif MenuType == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------



-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local ChoppingBoardMenuDiner = {
    {
        header = "🍴 Prepare Fresh Ingredients!",
        isMenuHeader = true,
    },          
    {   
        header = "🔪 Get Kitchen Knife",
        params = {
            isServer = true,
            event = "lusty94_diner:server:GiveKitchenKnife",
        }
    },          
    {   
        header = "🗡 Get Bread Knife",
        params = {
            isServer = true,
            event = "lusty94_diner:server:GiveBreadKnife",
        }
    },          
    {   
        header = "🍞 Prepare Sliced Bread",
        txt = "<u>Kitchen Knife Required</u> </br> Bread Required: 1",
        params = {
            event = "lusty94_diner:client:PrepareSlicedBread",
        }
    },
    {   
        header = "🥓 Prepare Sliced Bacon",
        txt = "<u>Kitchen Knife Required</u> </br> Bacon Required: 1",
        params = {
            event = "lusty94_diner:client:PrepareSlicedBacon",
        }
    },
    {   
        header = "🐟 Prepare Tuna Chunks",
        txt = "<u>Kitchen Knife Required</u> </br> Tuna Required: 1",
        params = {
            event = "lusty94_diner:client:PrepareTunaChunks",
        }
    },
    {   
        header = "🥑 Prepare Sliced Avocado",
        txt = "<u>Kitchen Knife Required</u> </br> Avocado Required: 1",
        params = {
            event = "lusty94_diner:client:PrepareSlicedAvocado",
        }
    },
    {   
        header = "🦃 Prepare Turkey Slices",
        txt = "<u>Kitchen Knife Required</u> </br> Turkey Required: 1",
        params = {
            event = "lusty94_diner:client:PrepareTurkeySlices",
        }
    },
    {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}

lib.registerContext({
    id = 'ChoppingBoardMenuDiner',
    title = '🍴 Prepare Fresh Ingredients!',
    options = {
       {
            title = '🔪 Get Kitchen Knife',
            onSelect = function()
                TriggerServerEvent('lusty94_diner:server:GiveKitchenKnife')
            end,
            arrow = true,
      },
       {
            title = '🗡 Get Bread Knife',
            onSelect = function()
                TriggerServerEvent('lusty94_diner:server:GiveBreadKnife')
            end,
            arrow = true,
      },
      {
        title = '🍞 Prepare Sliced Bread',
        event = 'lusty94_diner:client:PrepareSlicedBread',
        metadata = {
            {label = 'Bread Knife Required'},
            {label = 'Bread  Required', value = 1},
          },
        arrow = true,
      },          
      {
        title = '🥓 Prepare Sliced Bacon',
        event = 'lusty94_diner:client:PrepareSlicedBacon',
        metadata = {
            {label = 'Kitchen Knife Required'},
            {label = 'Bacon Required', value = 1},
          },
        arrow = true,
      },          
      {
        title = '🐟 Prepare Tuna Chunks',
        event = 'lusty94_diner:client:PrepareTunaChunks',
        metadata = {
            {label = 'Kitchen Knife Required'},
            {label = 'Tuna Required', value = 1},
          },
        arrow = true,
      },          
      {
        title = '🥑 Prepare Sliced Avocado',
        event = 'lusty94_diner:client:PrepareSlicedAvocado',
        metadata = {
            {label = 'Kitchen Knife Required'},
            {label = 'Avocado Required', value = 1},
          },
        arrow = true,
      },          
      {
        title = '🦃 Prepare Turkey Slices',
        event = 'lusty94_diner:client:PrepareTurkeySlices',
        metadata = {
            {label = 'Kitchen Knife Required'},
            {label = 'Turkey Required', value = 1},
          },
        arrow = true,
      },          
    }
})


RegisterNetEvent('lusty94_diner:client:ChoppingBoardMenu', function()
    if MenuType == 'qb' then
        exports['qb-menu']:openMenu(ChoppingBoardMenuDiner)
    elseif MenuType == 'jixel' then
        exports['jixel-menu']:openMenu(ChoppingBoardMenuDiner)
    elseif MenuType == 'ox' then
        lib.showContext('ChoppingBoardMenuDiner')
    elseif MenuType == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------



-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local SandwichesMenuDiner = {
    {
        header = "🥪 Prepare Grilled Sandwiches!",
        isMenuHeader = true,
    },          
    {   
        header = "🧀 Prepare Grilled Cheese",
        txt = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Cheese Slices",
        params = {
            event = "lusty94_diner:client:PrepareGrilledCheese",
        }
    },
    {   
        header = "🐔🧀 Prepare Chicken & Mozzarella",
        txt = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Chicken Breast <p> 2x Mozzarella Cheese <p> 1x Balsamic Glaze",
        params = {
            event = "lusty94_diner:client:PrepareChickenMozzarella",
        }
    },
    {   
        header = "🥓🥑 Prepare Bacon & Avocado",
        txt = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Sliced Bacon <p> 2x Sliced Avocado",
        params = {
            event = "lusty94_diner:client:PrepareBaconAvocado",
        }
    },
    {   
        header = "🐟🌽 Prepare Tuna & Sweetcorn",
        txt = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Tuna Chunks <p> 1x Sweetcorn",
        params = {
            event = "lusty94_diner:client:PrepareTunaSweetcorn",
        }
    },
    {   
        header = "🦃🍒 Prepare Turkey & Cranberry",
        txt = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Turkey Slices <p> 1x Cranberry Sauce",
        params = {
            event = "lusty94_diner:client:PrepareTurkeyCranberry",
        }
    },
    {   
        header = "🥚🥓 Prepare Eggs & Bacon",
        txt = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Egg <p> 2x Sliced Bacon",
        params = {
            event = "lusty94_diner:client:PrepareEggsBacon",
        }
    },
    {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}

lib.registerContext({
    id = 'SandwichesMenuDiner',
    title = '🥪 Prepare Grilled Sandwiches!',
    options = {
      {
        title = '🧀 Prepare Grilled Cheese',
        event = 'lusty94_diner:client:PrepareGrilledCheese',
        metadata = {
            {label = 'Sliced Bread Required', value = 2},
            {label = 'Butter Required', value = 1},
            {label = 'Cheese Slices Required', value = 2},
          },
        arrow = true,
      },          
      {
        title = '🐔🧀 Prepare Chicken & Mozzarella',
        event = 'lusty94_diner:client:PrepareChickenMozzarella',
        metadata = {
            {label = 'Sliced Bread Required', value = 2},
            {label = 'Butter Required', value = 1},
            {label = 'Chicken Breast Required', value = 2},
            {label = 'Mozzarella Cheese Required', value = 2},
            {label = 'Balsamic Glaze Required', value = 1},
          },
        arrow = true,
      },          
      {
        title = '🥓🥑 Prepare Bacon & Avocado',
        event = 'lusty94_diner:client:PrepareBaconAvocado',
        metadata = {
            {label = 'Sliced Bread Required', value = 2},
            {label = 'Butter Required', value = 1},
            {label = 'Sliced Bacon Required', value = 2},
            {label = 'Sliced Avocado Required', value = 2},
          },
        arrow = true,
      },          
      {
        title = '🐟🌽 Prepare Tuna & Sweetcorn',
        event = 'lusty94_diner:client:PrepareTunaSweetcorn',
        metadata = {
            {label = 'Sliced Bread Required', value = 2},
            {label = 'Butter Required', value = 1},
            {label = 'Tuna Chunks Required', value = 2},
            {label = 'Sweetcorn Required', value = 1},
          },
        arrow = true,
      },          
      {
        title = '🦃🍒 Prepare Turkey & Cranberry',
        event = 'lusty94_diner:client:PrepareTurkeyCranberry',
        metadata = {
            {label = 'Sliced Bread Required', value = 2},
            {label = 'Butter Required', value = 1},
            {label = 'Turkey Slices Required', value = 2},
            {label = 'Cranberry Sauce Required', value = 1},
          },
        arrow = true,
      },          
      {
        title = '🥚🥓 Prepare Eggs & Bacon',
        event = 'lusty94_diner:client:PrepareEggsBacon',
        metadata = {
            {label = 'Sliced Bread Required', value = 2},
            {label = 'Butter Required', value = 1},
            {label = 'Eggs Required', value = 2},
            {label = 'Sliced Bacon Required', value = 2},
          },
        arrow = true,
      },          
    }
})


RegisterNetEvent('lusty94_diner:client:SandwichesMenu', function()
    if MenuType == 'qb' then
        exports['qb-menu']:openMenu(SandwichesMenuDiner)
    elseif MenuType == 'jixel' then
        exports['jixel-menu']:openMenu(SandwichesMenuDiner)
    elseif MenuType == 'ox' then
        lib.showContext('SandwichesMenuDiner')
    elseif MenuType == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------




-------------------------------------------------------------< VEHICLE GARAGE START >---------------------------------------------------------------------
local vehicleAvailable = Config.CoreSettings.Vehicle.Label
local GarageMenuDiner = {
    {
        header = "🚗 Rent A Work Vehicle",
        isMenuHeader = true,
    },  
    {   
        header = "🚗 Rent Vehicle",
        txt = "<br> Vehicle Available: "..vehicleAvailable,
        params = {
            event = "lusty94_diner:client:RentVehicle",
        }
    },                  
    {   
        header = "⬅️ Return Vehicle",
        params = {
            event = "lusty94_diner:client:ReturnVehicle",
        }
    },           
    {
        header = "❌ Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}

lib.registerContext({
    id = 'GarageMenuDiner',
    title = '🚗 Rent A Work Vehicle',
    options = {
      {
        title = '🚗 Rent Vehicle',
        description = 'Vehicle Available: '..vehicleAvailable,
        event = 'lusty94_diner:client:RentVehicle',
        arrow = true,
      },
      {
        title = '⬅️ Return Vehicle',
        event = 'lusty94_diner:client:ReturnVehicle',
        arrow = true,
      },
    }
  })

RegisterNetEvent('lusty94_diner:client:OpenGarageMenu', function(data)
    if MenuType == 'qb' then    
        exports['qb-menu']:openMenu(GarageMenuDiner)            
    elseif MenuType == 'jixel' then      
        exports['jixel-menu']:openMenu(GarageMenuDiner)
    elseif MenuType == 'ox'then
        lib.showContext('GarageMenuDiner')
    elseif MenuType == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------------< VEHICLE GARAGE END >---------------------------------------------------------------------
