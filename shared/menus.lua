
-------------------------------------------------------< SMOOTHIE MENU START >---------------------------------------------------
local SlushieMenu = {
    main_header = { -- Main menu header
        text = '🥤 Prepare Fresh Slushies!', -- Header text
    },
    menu_options = {
        {
            header = '🥤 Get Slushie Cup', -- Menu option header if header is being used
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:GiveSlushieCup',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🫐 Prepare Blue Raspberry Slushie', -- Menu option header if header is being used
            message = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Blue Raspberry Syrup </br> Slushie Cup",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareBlueRaspberrySlushie',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍹 Prepare Tropical Slushie', -- Menu option header if header is being used
            message = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Tropical Syrup </br> Slushie Cup",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareTropicalSlushie',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍓 Prepare Strawberry Slushie', -- Menu option header if header is being used
            message = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Strawberry Syrup </br> Slushie Cup",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareStrawberrySlushie',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍋 Prepare Lemon N Lime Slushie', -- Menu option header if header is being used
            message = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Lemon N Lime Syrup </br> Slushie Cup",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareLemonLimeSlushie',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍊 Prepare Orange Slushie', -- Menu option header if header is being used
            message = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Orange Syrup </br> Slushie Cup",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareOrangeSlushie',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍇 Prepare Grape Slushie', -- Menu option header if header is being used
            message = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Grape Syrup </br> Slushie Cup",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareGrapeSlushie',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍒 Prepare Cherry Slushie', -- Menu option header if header is being used
            message = "<u>Ingredients Required:</u> </br> Crushed Ice </br> Cherry Syrup </br> Slushie Cup",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareCherrySlushie',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        
    },
    menu_buttons = { -- Menu buttons mostly pointless since they work the same as any other options mainly just allows for more customisation over menu templates
        close = {
            use = true, -- Toggle the close button
            --action_type = '', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            --action = '', -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
        }
    },
}

lib.registerContext({
    id = 'SlushieMenu',
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
    if Config.CoreSettings.Menu.Type == 'qb' then
        exports['qb-menu']:openMenu({
            {
                header = "🥤 Prepare Fresh Slushies!",
                isMenuHeader = true,
            },  
            {   
                header = "🥤 Get A Slushie Cup",
                params = {
                    event = "lusty94_diner:client:GiveSlushieCup",
                }
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
        })
    elseif Config.CoreSettings.Menu.Type == 'jixel' then
        exports['jixel-menu']:openMenu({
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
                    event = "jixel-menu:closeMenu",
                }
            },
        })
    elseif Config.CoreSettings.Menu.Type == 'boii' then
        exports['boii_ui']:open_menu('default', SlushieMenu)
    elseif Config.CoreSettings.Menu.Type == 'ox' then
        lib.showContext('SlushieMenu')
    elseif Config.CoreSettings.Menu.Type == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< SMOOTHIE MENU END >---------------------------------------------------




-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local HotDrinksMenu = {
    main_header = { -- Main menu header
        text = '☕ Prepare Hot Drinks!', -- Header text
    },
    menu_options = {
        {
            header = '☕ Get A Mug', -- Menu option header if header is being used
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:GiveMug',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍵 Prepare Cup of Tea', -- Menu option header if header is being used
            header_icon = '<i class="fa-solid fa-mug-hot"></i>', -- Menu header icon if using one this can be removed if not
            message = "Mug Required",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareTea',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '☕ Prepare Cup of Coffee', -- Menu option header if header is being used
            header_icon = '<i class="fa-solid fa-mug-hot"></i>', -- Menu header icon if using one this can be removed if not
            message = "Mug Required",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareCoffee',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍫 Prepare Cup of Hot Chocolate', -- Menu option header if header is being used
            header_icon = '<i class="fa-solid fa-mug-hot"></i>', -- Menu header icon if using one this can be removed if not
            message = "Mug Required",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareHotChocolate',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        
        
    },
    menu_buttons = { -- Menu buttons mostly pointless since they work the same as any other options mainly just allows for more customisation over menu templates
        close = {
            use = true, -- Toggle the close button
            --action_type = '', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            --action = '', -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
        }
    },
}

lib.registerContext({
    id = 'HotDrinksMenu',
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
    if Config.CoreSettings.Menu.Type == 'qb' then
        exports['qb-menu']:openMenu({
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
        })
    elseif Config.CoreSettings.Menu.Type == 'jixel' then
        exports['jixel-menu']:openMenu({
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
                    event = "jixel-menu:closeMenu",
                }
            },
        })
    elseif Config.CoreSettings.Menu.Type == 'boii' then
        exports['boii_ui']:open_menu('default', HotDrinksMenu)
    elseif Config.CoreSettings.Menu.Type == 'ox' then
        lib.showContext('HotDrinksMenu')
    elseif Config.CoreSettings.Menu.Type == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------




-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local SoftDrinksMenu = {
    main_header = { -- Main menu header
        text = '🥤 Prepare Soft Drinks!', -- Header text
    },
    menu_options = {
        {
            header = '🥤 Get A Soft Drinks Cup', -- Menu option header if header is being used
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:GiveSoftDrinksCup',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🥤 Prepare Cup of E-Cola', -- Menu option header if header is being used
            message = "Soft Drinks Cup Required",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareECola',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🥤 Prepare Cup of E-Cola Light', -- Menu option header if header is being used
            message = "Soft Drinks Cup Required",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareEColaLight',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍋 Prepare Cup of Sprunk', -- Menu option header if header is being used
            message = "Soft Drinks Cup Required",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareSprunk',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍊 Prepare Cup of Orange Soda', -- Menu option header if header is being used
            message = "Soft Drinks Cup Required",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareOrangeSoda',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },       
    },
    menu_buttons = { -- Menu buttons mostly pointless since they work the same as any other options mainly just allows for more customisation over menu templates
        close = {
            use = true, -- Toggle the close button
            --action_type = '', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            --action = '', -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
        }
    },
}

lib.registerContext({
    id = 'SoftDrinksMenu',
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
    if Config.CoreSettings.Menu.Type == 'qb' then
        exports['qb-menu']:openMenu({
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
        })
    elseif Config.CoreSettings.Menu.Type == 'jixel' then
        exports['jixel-menu']:openMenu({
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
                    event = "jixel-menu:closeMenu",
                }
            },
        })
    elseif Config.CoreSettings.Menu.Type == 'boii' then
        exports['boii_ui']:open_menu('default', SoftDrinksMenu)
    elseif Config.CoreSettings.Menu.Type == 'ox' then
        lib.showContext('SoftDrinksMenu')
    elseif Config.CoreSettings.Menu.Type == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------



-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local ChoppingBoardMenu = {
    main_header = { -- Main menu header
        text = '🍴 Prepare Fresh Ingredients!', -- Header text
    },
    menu_options = {
        {
            header = '🔪 Get Kitchen Knife', -- Menu option header if header is being used
            action_type = 'server_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:server:GiveKitchenKnife',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🗡 Get Bread Knife', -- Menu option header if header is being used
            action_type = 'server_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:server:GiveBreadKnife',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '🍞 Prepare Sliced Bread', -- Menu option header if header is being used
            message = "<u>Bread Knife Required:</u> </br> Bread Required: 1",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareSlicedBread',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },      
        {
            header = '🥓 Prepare Sliced Bacon', -- Menu option header if header is being used
            message = "<u>Kitchen Knife Required:</u> </br> Bacon Required: 1",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareSlicedBacon',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },      
        {
            header = '🐟 Prepare Tuna Chunks', -- Menu option header if header is being used
            message = "<u>Kitchen Knife Required:</u> </br> Tuna Required: 1",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareTunaChunks',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },      
        {
            header = '🥑 Prepare Sliced Avocado', -- Menu option header if header is being used
            message = "<u>Kitchen Knife Required:</u> </br> Avocado Required: 1",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareTunaChunks',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },      
        {
            header = '🦃 Prepare Turkey Slices', -- Menu option header if header is being used
            message = "<u>Kitchen Knife Required:</u> </br> Turkey Required: 1",
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:PrepareTurkeySlices',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },      
    },
    menu_buttons = { -- Menu buttons mostly pointless since they work the same as any other options mainly just allows for more customisation over menu templates
        close = {
            use = true, -- Toggle the close button
            --action_type = '', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            --action = '', -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
        }
    },
}

lib.registerContext({
    id = 'ChoppingBoardMenu',
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
    if Config.CoreSettings.Menu.Type == 'qb' then
        exports['qb-menu']:openMenu({
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
        })
    elseif Config.CoreSettings.Menu.Type == 'jixel' then
        exports['jixel-menu']:openMenu({
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
                txt = "<u>Kitchen Knife Required</u>",
                params = {
                    event = "lusty94_diner:client:PrepareSlicedBread",
                }
            },
            {   
                header = "🥓 Prepare Sliced Bacon",
                txt = "<u>Kitchen Knife Required</u>",
                params = {
                    event = "lusty94_diner:client:PrepareSlicedBacon",
                }
            },
            {   
                header = "🐟 Prepare Tuna Chunks",
                txt = "<u>Kitchen Knife Required</u>",
                params = {
                    event = "lusty94_diner:client:PrepareTunaChunks",
                }
            },
            {   
                header = "🥑 Prepare Sliced Avocado",
                txt = "<u>Kitchen Knife Required</u>",
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
                    event = "jixel-menu:closeMenu",
                }
            }, 
        })
    elseif Config.CoreSettings.Menu.Type == 'boii' then
        exports['boii_ui']:open_menu('default', ChoppingBoardMenu)
    elseif Config.CoreSettings.Menu.Type == 'ox' then
        lib.showContext('ChoppingBoardMenu')
    elseif Config.CoreSettings.Menu.Type == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------



-------------------------------------------------------< HOT DRINKS MENU START >---------------------------------------------------
local SandwichesMenu = {
    main_header = { -- Main menu header
        text = '🥪 Prepare Grilled Sandwiches!',
    },
    menu_options = {
        {
            header = '🧀 Prepare Grilled Cheese',
            message = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Cheese Slices",
            action_type = 'client_event',
            action = 'lusty94_diner:client:PrepareGrilledCheese',
            params = {},
            should_close = true,
            disabled = false
        },      
        {
            header = '🐔🧀 Prepare Chicken & Mozzarella',
            message = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Chicken Breast <p> 2x Mozzarella Cheese <p> 1x Balsamic Glaze",
            action_type = 'client_event',
            action = 'lusty94_diner:client:PrepareChickenMozzarella',
            params = {},
            should_close = true,
            disabled = false
        },      
        {
            header = '🥓🥑 Prepare Bacon & Avocado',
            message = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Sliced Bacon <p> 2x Sliced Avocado",
            action_type = 'client_event',
            action = 'lusty94_diner:client:PrepareBaconAvocado',
            params = {},
            should_close = true,
            disabled = false
        },      
        {
            header = '🐟🌽 Prepare Tuna & Sweetcorn',
            message = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Tuna Chunks <p> 1x Sweetcorn",
            action_type = 'client_event',
            action = 'lusty94_diner:client:PrepareTunaSweetcorn',
            params = {},
            should_close = true,
            disabled = false
        },      
        {
            header = '🦃🍒 Prepare Turkey & Cranberry',
            message = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Turkey Slices <p> 1x Cranberry Sauce",
            action_type = 'client_event',
            action = 'lusty94_diner:client:PrepareTurkeyCranberry',
            params = {},
            should_close = true,
            disabled = false
        },      
        {
            header = '🥚🥓 Prepare Eggs & Bacon',
            message = "<u>Ingredients Required:</u> <br> 2x Sliced Bread <p> Butter <p> 2x Egg <p> 2x Sliced Bacon",
            action_type = 'client_event',
            action = 'lusty94_diner:client:PrepareEggsBacon',
            params = {},
            should_close = true,
            disabled = false
        },      
    },
    menu_buttons = {
        close = {
            use = true,
            params = {}, 
            should_close = true,
        }
    },
}

lib.registerContext({
    id = 'SandwichesMenu',
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
    if Config.CoreSettings.Menu.Type == 'qb' then
        exports['qb-menu']:openMenu({
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
        })
    elseif Config.CoreSettings.Menu.Type == 'jixel' then
        exports['jixel-menu']:openMenu({
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
                    event = "jixel-menu:closeMenu",
                }
            },
        })
    elseif Config.CoreSettings.Menu.Type == 'boii' then
        exports['boii_ui']:open_menu('default', SandwichesMenu)
    elseif Config.CoreSettings.Menu.Type == 'ox' then
        lib.showContext('SandwichesMenu')
    elseif Config.CoreSettings.Menu.Type == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------< HOT DRINKS MENU END >---------------------------------------------------




-------------------------------------------------------------< VEHICLE GARAGE START >---------------------------------------------------------------------

local GarageMenu = {
    main_header = { -- Main menu header
        text = '🚗 Rent A Work Vehicle', -- Header text
    },
    menu_options = {
        {
            header = '🚗 Rent Vehicle', -- Menu option header if header is being used            
            message = 'Vehicles Available To Rent: '..Config.InteractionLocations.Job.Vehicle.Name, -- Menu option text if text is being used
            message_icon = '', -- Menu header icon if using one this can be removed if not
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:RentVehicle',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
        {
            header = '⬅️ Return Vehicle', -- Menu option header if header is being used
            message = 'Return Your Vehicle', -- Menu option text if text is being used
            action_type = 'client_event', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = 'lusty94_diner:client:ReturnVehicle',  -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
            disabled = false -- Disable the onclick function of the option
        },
    },
    menu_buttons = { -- Menu buttons mostly pointless since they work the same as any other options mainly just allows for more customisation over menu templates
        close = {
            use = true, -- Toggle the close button
            action_type = '', -- Type to trigger on click this can be removed. Actions: 'client_event', 'server_event'
            action = '', -- Name of event to trigger
            params = {}, -- Event params
            should_close = true, -- Toggle whether event should close the menu ui
        }
    },
}

lib.registerContext({
    id = 'GarageMenu',
    title = '🚗 Rent A Work Vehicle',
    options = {
      {
        title = '🚗 Rent Vehicle',
        description = 'Vehicle Available: '..Config.InteractionLocations.Job.Vehicle.Name,
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
    if Config.CoreSettings.Menu.Type == 'qb' then    
                exports['qb-menu']:openMenu({
                    {
                        header = "🚗 Rent A Work Vehicle",
                        isMenuHeader = true,
                    },  
                    {   
                        header = "🚗 Rent Vehicle",
                        txt = "<br> Vehicle Available: "..Config.InteractionLocations.Job.Vehicle.Name,
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
                })
            
    elseif Config.CoreSettings.Menu.Type == 'jixel' then      
            exports['jixel-menu']:openMenu({
                {
                    header = "🚗 Rent A Work Vehicle",
                    isMenuHeader = true,
                },  
                {  
                    header = "🚗 Rent Vehicle",
                    txt = "<br> Vehicle Available: "..Config.InteractionLocations.Job.Vehicle.Name,
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
                        event = "",
                    }
                },
            })
        
    elseif Config.CoreSettings.Menu.Type == 'boii'  then
        exports['boii_ui']:open_menu('default', GarageMenu)
    elseif Config.CoreSettings.Menu.Type == 'ox'then
        lib.showContext('GarageMenu')
    elseif Config.CoreSettings.Menu.Type == 'custom' then
        --insert custom menu code here
    end
end)
-------------------------------------------------------------< VEHICLE GARAGE END >---------------------------------------------------------------------
