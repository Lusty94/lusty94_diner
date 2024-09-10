--slushie menu
lib.registerContext({
    id = 'SlushieMenuDiner',
    title = '🥤 Prepare Fresh Slushies!',
    options = {
      {
        title = 'Get Slushie Cup',
        event = 'lusty94_diner:client:GiveSlushieCup',
        arrow = true,
        icon = ItemImage('slushiecup'),
        image = ItemImage('slushiecup'),
      },
      {
        title = 'Prepare Blue Raspberry Slushie',
        event = 'lusty94_diner:client:PrepareBlueRaspberrySlushie',
        arrow = true,
        description = 'Required Ingredients: \n Crushed Ice \n Blue Raspberry Syrup \n Slushie Cup',
        icon = ItemImage('blueraspberryslushie'),
        image = ItemImage('blueraspberryslushie'),
      },
      {
        title = 'Prepare Tropical Slushie',
        event = 'lusty94_diner:client:PrepareTropicalSlushie',
        arrow = true,
        description = 'Required Ingredients: \n Crushed Ice \n Tropical Syrup \n Slushie Cup',
        icon = ItemImage('tropicalslushie'),
        image = ItemImage('tropicalslushie'),
      },
      {
        title = 'Prepare Strawberry Slushie',
        event = 'lusty94_diner:client:PrepareStrawberrySlushie',
        arrow = true,
        description = 'Required Ingredients: \n Crushed Ice \n Strawberry Syrup \n Slushie Cup',
        icon = ItemImage('strawberryslushie'),
        image = ItemImage('strawberryslushie'),
      },
      {
        title = 'Prepare Lemon N Lime Slushie',
        event = 'lusty94_diner:client:PrepareLemonLimeSlushie',
        arrow = true,
        description = 'Required Ingredients: \n Crushed Ice \n Lemon N Lime Syrup \n Slushie Cup',
        icon = ItemImage('lemonlimeslushie'),
        image = ItemImage('lemonlimeslushie'),
      },
      {
        title = 'Prepare Orange Slushie',
        event = 'lusty94_diner:client:PrepareOrangeSlushie',
        arrow = true,
        description = 'Required Ingredients: \n Crushed Ice \n Orange Syrup \n Slushie Cup',
        icon = ItemImage('orangeslushie'),
        image = ItemImage('orangeslushie'),
      },
      {
        title = 'Prepare Grape Slushie',
        event = 'lusty94_diner:client:PrepareGrapeSlushie',
        arrow = true,
        description = 'Required Ingredients: \n Crushed Ice \n Grape Syrup \n Slushie Cup',
        icon = ItemImage('grapeslushie'),
        image = ItemImage('grapeslushie'),
      },
      {
        title = 'Prepare Cherry Slushie',
        event = 'lusty94_diner:client:PrepareCherrySlushie',
        arrow = true,
        description = 'Required Ingredients: \n Crushed Ice \n Cherry Syrup \n Slushie Cup',
        icon = ItemImage('cherryslushie'),
        image = ItemImage('cherryslushie'),
      },
            
    }
})

--hot drinks menu
lib.registerContext({
    id = 'HotDrinksMenuDiner',
    title = '☕ Prepare Hot Drinks!',
    options = {
      {
        title = 'Get A Mug',
        icon = ItemImage('mug'),
        image = ItemImage('mug'),
        event = 'lusty94_diner:client:GiveMug',
        arrow = true,
      },
      {
        title = 'Prepare Cup of Tea', 
        event = 'lusty94_diner:client:PrepareTea',
        icon = ItemImage('tea'),
        image = ItemImage('tea'),
        arrow = true,
      },
      {
        title = 'Prepare Cup of Coffee', 
        event = 'lusty94_diner:client:PrepareCoffee',
        icon = ItemImage('coffee'),
        image = ItemImage('coffee'),
        arrow = true,
      },
      {
        title = 'Prepare Cup of Hot Chocolate', 
        event = 'lusty94_diner:client:PrepareHotChocolate',
        icon = ItemImage('hotchocolate'),
        image = ItemImage('hotchocolate'),
        arrow = true,
      },
    }
})


--soft drinks menu
lib.registerContext({
    id = 'SoftDrinksMenuDiner',
    title = '🥤 Prepare Soft Drinks!',
    options = {
      {
        title = 'Get A Soft Drinks Cup', 
        icon = ItemImage('softdrinkscup'),
        image = ItemImage('softdrinkscup'),
        event = 'lusty94_diner:client:GiveSoftDrinksCup',
        arrow = true,
      },
      {
        title = 'Prepare Cup of E-Cola', 
        event = 'lusty94_diner:client:PrepareECola',
        icon = ItemImage('ecola'),
        image = ItemImage('ecola'),
        arrow = true,
      },
      {
        title = 'Prepare Cup of E-Cola Light', 
        event = 'lusty94_diner:client:PrepareEColaLight',
        icon = ItemImage('ecolalight'),
        image = ItemImage('ecolalight'),
        arrow = true,
      },
      {
        title = 'Prepare Cup of Sprunk', 
        event = 'lusty94_diner:client:PrepareSprunk',
        icon = ItemImage('sprunk'),
        image = ItemImage('sprunk'),
        arrow = true,
      },
      {
        title = 'Prepare Cup of Orange Soda', 
        event = 'lusty94_diner:client:PrepareOrangeSoda',
        icon = ItemImage('orangesoda'),
        image = ItemImage('orangesoda'),
        arrow = true,
      },
    }
})


lib.registerContext({
    id = 'ChoppingBoardMenuDiner',
    title = '🍴 Prepare Fresh Ingredients!',
    options = {
        {
          title = 'Get Kitchen Knife',
          onSelect = function()
              TriggerServerEvent('lusty94_diner:server:GiveKitchenKnife')
          end,
          arrow = true,
          icon = ItemImage('kitchenknife'),
          image = ItemImage('kitchenknife'),
              
        },
       {
          title = 'Get Bread Knife',
          onSelect = function()
              TriggerServerEvent('lusty94_diner:server:GiveBreadKnife')
          end,
          arrow = true,
          icon = ItemImage('breadknife'),
          image = ItemImage('breadknife'),
      },
      {
        title = 'Prepare Sliced Bread',
        event = 'lusty94_diner:client:PrepareSlicedBread',
        description = 'Bread Knife Required',
        icon = ItemImage('slicedbread'),
        image = ItemImage('slicedbread'),
        arrow = true,
      },          
      {
        title = 'Prepare Sliced Bacon',
        event = 'lusty94_diner:client:PrepareSlicedBacon',
        description = 'Kitchen Knife Required',
        icon = ItemImage('slicedbacon'),
        image = ItemImage('slicedbacon'),
        arrow = true,
      },          
      {
        title = 'Prepare Tuna Chunks',
        event = 'lusty94_diner:client:PrepareTunaChunks',
        description = 'Kitchen Knife Required',
        icon = ItemImage('tunachunks'),
        image = ItemImage('tunachunks'),
        arrow = true,
      },          
      {
        title = 'Prepare Sliced Avocado',
        event = 'lusty94_diner:client:PrepareSlicedAvocado',
        description = 'Kitchen Knife Required',
        icon = ItemImage('slicedavocado'),
        image = ItemImage('slicedavocado'),
        arrow = true,
      },          
      {
        title = 'Prepare Turkey Slices',
        event = 'lusty94_diner:client:PrepareTurkeySlices',
        description = 'Kitchen Knife Required',
        icon = ItemImage('turkeyslices'),
        image = ItemImage('turkeyslices'),
        arrow = true,
      },          
    }
})



lib.registerContext({
    id = 'SandwichesMenuDiner',
    title = '🥪 Prepare Grilled Sandwiches!',
    options = {
      {
        title = 'Prepare Grilled Cheese',
        event = 'lusty94_diner:client:PrepareGrilledCheese',
        description = 'Ingredients Required: \n Sliced Bread x2 \n Butter x1 \n Cheese Slices x2',
        icon = ItemImage('grilledcheese'),
        image = ItemImage('grilledcheese'),
        arrow = true,
      },          
      {
        title = 'Prepare Chicken & Mozzarella',
        event = 'lusty94_diner:client:PrepareChickenMozzarella',
        description = 'Ingredients Required: \n Sliced Bread x2 \n Butter x1 \n Chicken Breast x2 \n Mozzarella Cheese x2 \n Balsamic Glaze x1',
        icon = ItemImage('grilledchickenmozzarella'),
        image = ItemImage('grilledchickenmozzarella'),
        arrow = true,
      },          
      {
        title = 'Prepare Bacon & Avocado',
        event = 'lusty94_diner:client:PrepareBaconAvocado',
        description = 'Ingredients Required: \n Sliced Bread x2 \n Butter x1 \n Sliced Bacon x2 \n Sliced Avocado x2',
        icon = ItemImage('grilledbaconavocado'),
        image = ItemImage('grilledbaconavocado'),
        arrow = true,
      },          
      {
        title = 'Prepare Tuna & Sweetcorn',
        event = 'lusty94_diner:client:PrepareTunaSweetcorn',
        description = 'Ingredients Required: \n Sliced Bread x2 \n Butter x1 \n Tuna Chunks x2 \n Sweetcorn x1',
        icon = ItemImage('grilledtunasweetcorn'),
        image = ItemImage('grilledtunasweetcorn'),
        arrow = true,
      },          
      {
        title = 'Prepare Turkey & Cranberry',
        event = 'lusty94_diner:client:PrepareTurkeyCranberry',
        description = 'Ingredients Required: \n Sliced Bread x2 \n Butter x1 \n Turkey Slices x2 \n Cranberry Sauce x1',
        icon = ItemImage('grilledturkeycranberry'),
        image = ItemImage('grilledturkeycranberry'),
        arrow = true,
      },          
      {
        title = 'Prepare Eggs & Bacon',
        event = 'lusty94_diner:client:PrepareEggsBacon',
        description = 'Ingredients Required: \n Sliced Bread x2 \n Butter x1 \n Eggs x2 \n Sliced Bacon x2',
        icon = ItemImage('grilledeggsbacon'),
        image = ItemImage('grilledeggsbacon'),
        arrow = true,
      },          
    }
})



local vehicleAvailable = Config.CoreSettings.Vehicle.Label

lib.registerContext({
    id = 'GarageMenuDiner',
    title = '🚗 Rent A Work Vehicle',
    options = {
        {
            title = 'Rent Vehicle',
            icon = 'car',
            description = 'Vehicle Available: '..vehicleAvailable,
            event = 'lusty94_diner:client:RentVehicle',
            arrow = true,
        },
        {
            title = 'Return Vehicle',
            icon = 'rotate-left',
            event = 'lusty94_diner:client:ReturnVehicle',
            arrow = true,
        },
    }
})




-------------------------------< EVENTS >----------------
RegisterNetEvent('lusty94_diner:client:SlushieMenu', function()
    lib.showContext('SlushieMenuDiner')
end)

RegisterNetEvent('lusty94_diner:client:HotDrinksMenu', function()
    lib.showContext('HotDrinksMenuDiner')
end)

RegisterNetEvent('lusty94_diner:client:SoftDrinksMenu', function()
    lib.showContext('SoftDrinksMenuDiner')
end)

RegisterNetEvent('lusty94_diner:client:ChoppingBoardMenu', function()
    lib.showContext('ChoppingBoardMenuDiner')
end)

RegisterNetEvent('lusty94_diner:client:SandwichesMenu', function()
    lib.showContext('SandwichesMenuDiner')
end)

RegisterNetEvent('lusty94_diner:client:OpenGarageMenu', function(data)
    lib.showContext('GarageMenuDiner')
end)
