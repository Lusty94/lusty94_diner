## Lusty94_Diner


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

PLEASE MAKE SURE TO READ THIS ENTIRE FILE AS IT COVERS SOME IMPORTANT INFORMATION

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




## Features

- Create 6 grilled sandwiches
- Create 7 iced slushies
- Create 4 soft drinks
- Create 3 hot drinks
- Slice ingredients in preparation for grilled sandwiches
- Snack bar for customers to buy sweet treats
- Sink to wash your hands before working
- Vehicle rental system to deliver food to customers

- Custom spawned props inside the MLO to interact with for certain events [management menu, ingredients fridge and sink]
- Management menu system to hire / fire employees & much more
- Payment till charge customers for orders
- Custom sounds when performing certain actions such as making slushies and making grilled sandwiches [REQUIRES_INTERACT_SOUND]

- Multiple types of notification support [qb-notify, okokNotify, mythic_notify, boii_ui notify, ox_lib notify]
- Multiple types of menu support [qb-menu, jixel-menu, boii_ui menu, ox_lib menu]
- Support for qb-inventory shops, jim-shops & ox_inventory shops
- Support for qb-target & ox_target
- Support for qb-inventory and ox_inventory
- Support for jim-consumables with different props for each food/drink item
- Employee stash system [Storage Fridge] and customer collection tray


- Extensive config file
- Change core settings to suit your server such as progressbar timers, notify lengths, event names and much more
- Support for [ANY] MLO or building - moveable target locations via config file
- Language settings for custom translations



## INSTALLATION

- Add the ##ITEMS snippet below into your core/shared/items.lua file
- Add the ##JOB snippet below to your core/shared/jobs.lua
- Add all .png images inside [images] folder into your inventory/html/images folder
- Add all .ogg files inside [interact-sounds] folder into your interact-sound/client/sounds folder



## OX INVENTORY USERS - STORAGE FRIDGE, INGREDIENTS FRIDGE, SNACK SHELF & COLLECTION TRAY INFORMATION

- If you are using ox_inventory you must add this snippet below to ox_inventory/data/shops & stashes.lua for the ingredients and snack shelf stores to work correctly. 

``

--SHOPS.LUA--

    PopsDinerIngredients = {
		name = 'Pops Diner Ingredients',
		groups = {
			['diner'] = 0
		},
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
		locations = {
			vec3(1594.76, 6455.54, 25.0)
		}, 
		targets = {
			{ loc = vec3(1594.76, 6455.54, 25.0), length = 1.8, width = 0.8, heading = 335, minZ = 24.0, maxZ = 26.0, distance = 2 }
		}
	},

	PopsDinerSnacks = {
		name = 'Pops Diner Snack Shelf',
		inventory = {
			{ name = 'vanillacupcake', price = 10 },
			{ name = 'chocolatecupcake', price = 10 },
			{ name = 'chocolatebar', price = 10 },
			{ name = 'jamdoughnut', price = 10 },
			{ name = 'sugardoughnut', price = 10 },
			{ name = 'custarddoughnut', price = 10 },
			{ name = 'chocolatedoughnut', price = 10 },
		},
		locations = {
			vec3(1588.83, 6456.13, 25.7)
		}, 
		targets = {
			{ loc = vec3(1588.83, 6456.13, 25.7), length = 1.5, width = 0.8, heading = 335, minZ = 25.0, maxZ = 26.00, distance = 2 }
		}
	},



--STASHES.LUA--

    { -- pops diner collection tray
		coords = vec3(1590.3, 6455.25, 26.19),
		target = {
			loc = vec3(1590.3, 6455.25, 26.19),
			length = 0.8,
			width = 0.5,
			heading = 155.24,
			minZ = 26.10,
			maxZ = 26.25,
			label = 'Open Pops Diner Collection Tray'
		},
		name = 'popsdinercollectiontray2',
		label = 'Pops Diner Collection Tray',
		owner = false,
		slots = 10,
		weight = 100000000,
	},

	{ -- pops diner storage fridge
		coords = vec3(1596.07, 6454.55, 25.25),
		target = {
			loc = vec3(1596.07, 6454.55, 25.25),
			length = 0.75,
			width = 1.0,
			heading = 335,
			minZ = 25.0,
			maxZ = 27.25,
			label = 'Open Pops Diner Storage Fridge'
		},
		name = 'popsdinerstoragefridge',
		label = 'Pops Diner Storage Fridge',
		owner = true,
		slots = 64,
		weight = 10000000000000,
		groups = {['diner'] = 0}
	},

``




## DEPENDENCIES

- Pops Diner MLO - Gabz - https://www.gabzv.com/ [CAN BE MOVED TO ANOTHER MLO BY MOVING TARGET LOCATIONS IN CONFIG]

- QB-CORE - https://github.com/qbcore-framework/qb-core
- QB-TARGET - https://github.com/qbcore-framework/qb-target
- QB-MENU - https://github.com/qbcore-framework/qb-menu
- QB-INPUT - https://github.com/qbcore-framework/qb-input
- QB-INVENTORY - https://github.com/qbcore-framework/qb-inventory
- PROGRESSBAR - https://github.com/qbcore-framework/progressbar
- Legacy Fuel - https://github.com/InZidiuZ/LegacyFuel

- OX_LIB - https://github.com/overextended/ox_lib/releases/tag/v3.10.0

- JIM-CONSUMABLES - https://github.com/jimathy/jim-consumables [ONLY REQUIRED IF CONFIG.USEJIMCONSUMABLES IS SET TO TRUE]


## INTERACT SOUND

- If set to true in the config then this script uses custom sounds that need to be placed inside of interact-sound resource

- Place ALL .ogg files inside [sounds] folder into your interact-sound/client/html/sounds folder

- Interact sound must be started BEFORE this resource in order to work correctly

## CONSUMABLES

- Set Config.UseJimConsumables to true to enable jim-consumables to handle the useable food and drink items

- ENSURE JIM-CONSUMABLES STARTS BEFORE THIS SCRIPT TO FUNCTION CORRECTLY


## JOB

```

    ['diner'] = {
		label = 'Pops Diner',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Kitchen Porter', payment = 25 },
            ['1'] = { name = 'Team Member', payment = 50 },
            ['2'] = { name = 'Sales Manager', payment = 75 },
            ['3'] = { name = 'Shop Manager', isboss= true, payment = 100 },
        },
	},

```



## ITEMS

```

    --REQUIRED ITEMS
    ['slushiecup'] 			                        = {['name'] = 'slushiecup', 			 	  	  	    ['label'] = 'Slushie Cup', 		                ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'slushiecup.png', 				            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'A Cup Used For Making Slushies!'},
    ['softdrinkscup'] 			                    = {['name'] = 'softdrinkscup', 			 	  	  	    ['label'] = 'Soft Drinks Cup', 		            ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'softdrinkscup.png', 				        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Soft Drinks Cup'},
    ['mug'] 			                            = {['name'] = 'mug', 			 	  	  	            ['label'] = 'Mug', 		                        ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'mug.png', 				                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Mug'},
    ['breadknife'] 			                        = {['name'] = 'breadknife', 			 	  	  	    ['label'] = 'Bread Knife', 		                ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'breadknife.png', 				            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'A Sharp Bread Knife'},
	['kitchenknife'] 		                        = {['name'] = 'kitchenknife', 			 	  	  	    ['label'] = 'Kitchen Knife', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'kitchenknife.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'A Sharp Kitchen Knife'},
	
   
    --DRINKS
    ['tea'] 			                            = {['name'] = 'tea', 			 	  	  	            ['label'] = 'Tea', 		                        ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'tea.png', 				                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Hot Tea'},
    ['coffee'] 			                            = {['name'] = 'coffee', 			 	  	  	        ['label'] = 'Coffee', 		                    ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'coffee.png', 				                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Hot Coffee'},
    ['hotchocolate'] 			                    = {['name'] = 'hotchocolate', 			 	  	  	    ['label'] = 'Hot Chocolate', 		            ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'hotchocolate.png', 				        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Hot Chocolate'},
    ['ecola'] 			                            = {['name'] = 'ecola', 			 	  	  	            ['label'] = 'E-Cola', 		                    ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'ecola.png', 				                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'E-Cola'},
    ['ecolalight'] 			                        = {['name'] = 'ecolalight', 			 	  	  	    ['label'] = 'E-Cola Light', 		            ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'ecolalight.png', 				            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'E-Cola Light'},
    ['sprunk'] 			                            = {['name'] = 'sprunk', 			 	  	  	        ['label'] = 'Sprunk', 		                    ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'sprunk.png', 				                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Sprunk'},
    ['orangesoda'] 			                        = {['name'] = 'orangesoda', 			 	  	  	    ['label'] = 'Orange Soda', 		                ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'orangesoda.png', 				            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Orange Soda'},
    
    --INGREDIENTS
    ['butter'] 		                                = {['name'] = 'butter', 			 	  	  	        ['label'] = 'Butter', 	                        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'butter.png', 			                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Butter Used For Grilled Sandwiches'},
    ['crushedice'] 		                            = {['name'] = 'crushedice', 			 	  	  	    ['label'] = 'Crushed Ice', 	                    ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'crushedice.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Crushed Ice For Making Slushies'},
    ['balsamicglaze'] 		                        = {['name'] = 'balsamicglaze', 			 	  	  	    ['label'] = 'Balsamic Glaze', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'balsamicglaze.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Balsamic Glaze'},
	['cranberrysauce'] 		                        = {['name'] = 'cranberrysauce', 			 	  	  	['label'] = 'Cranberry Sauce', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'cranberrysauce.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Cranberry Sauce'},
    ['mozzarellacheese'] 		                    = {['name'] = 'mozzarellacheese', 			 	  	  	['label'] = 'Mozzarella Cheese', 	            ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'mozzarellacheese.png', 			        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Mozzarella Cheese'},
	['cheeseslice'] 		                        = {['name'] = 'cheeseslice', 			 	  	  	    ['label'] = 'Cheese Slice', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'cheeseslice.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Cheese Slice'},
    ['bread'] 		                                = {['name'] = 'bread', 			 	  	  	            ['label'] = 'Bread', 	                        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'bread.png', 			                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Fresh Bread'},
    ['slicedbread'] 		                        = {['name'] = 'slicedbread', 			 	  	  	    ['label'] = 'Sliced Bread', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'slicedbread.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Fresh Sliced Bread'},
	['eggs'] 		                                = {['name'] = 'eggs', 			 	  	  	            ['label'] = 'Eggs', 	                        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'eggs.png', 			                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Eggs'},
    
    --INGREDIENTS
	['chickenbreast'] 						 	    = {['name'] = 'chickenbreast', 			 	  	  		['label'] = 'Chicken Breast', 				    ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'chickenbreast.png', 					    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Chicken Breast'},
    ['bacon'] 		                                = {['name'] = 'bacon', 			 	  	  	            ['label'] = 'Bacon', 	                        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'bacon.png', 			                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Bacon'},
    ['slicedbacon'] 		                        = {['name'] = 'slicedbacon', 			 	  	  	    ['label'] = 'Sliced Bacon', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'slicedbacon.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Sliced Bacon'},
    ['tuna'] 		                                = {['name'] = 'tuna', 			 	  	  	            ['label'] = 'Tuna', 	                        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'tuna.png', 			                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Tuna'},
    ['tunachunks'] 		                            = {['name'] = 'tunachunks', 			 	  	  	    ['label'] = 'Tuna Chunks', 	                    ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'tunachunks.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Tuna Chunks'},
    ['turkey'] 		                                = {['name'] = 'turkey', 			 	  	  	        ['label'] = 'Turkey', 	                        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'turkey.png', 			                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Turkey'},
    ['turkeyslices'] 		                        = {['name'] = 'turkeyslices', 			 	  	  	    ['label'] = 'Turkey Slices', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'turkeyslices.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Turkey Slices'},
    ['avocado'] 		                            = {['name'] = 'avocado', 			 	  	  	        ['label'] = 'Avocado', 	                        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'avocado.png', 			                    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Avocado'},
    ['slicedavocado'] 		                        = {['name'] = 'slicedavocado', 			 	  	  	    ['label'] = 'Sliced Avocado', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'slicedavocado.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Sliced Avocado'},
    ['sweetcorn'] 		                            = {['name'] = 'sweetcorn', 			 	  	  	        ['label'] = 'Sweetcorn', 	                    ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'sweetcorn.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Sweetcorn'},
    
    --SYRUPS
    ['blueraspberrysyrup'] 		                    = {['name'] = 'blueraspberrysyrup', 			 	  	['label'] = 'Blue Raspberry Syrup', 	        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'blueraspberrysyrup.png', 			        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Blue Raspberry Syrup For Making Slushies'},
    ['tropicalsyrup'] 		                        = {['name'] = 'tropicalsyrup', 			 	  	        ['label'] = 'Tropical Syrup', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'tropicalsyrup.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Tropical Syrup For Making Slushies'},
    ['strawberrysyrup'] 		                    = {['name'] = 'strawberrysyrup', 			 	  	    ['label'] = 'Strawberry Syrup', 	            ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'strawberrysyrup.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Strawberry Syrup For Making Slushies'},
    ['lemonlimesyrup'] 		                        = {['name'] = 'lemonlimesyrup', 			 	  	    ['label'] = 'Lemon N Lime Syrup', 	            ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'lemonlimesyrup.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Lemon N Lime Syrup For Making Slushies'},
    ['orangesyrup'] 		                        = {['name'] = 'orangesyrup', 			 	  	        ['label'] = 'Orange Syrup', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'orangesyrup.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Orange Syrup For Making Slushies'},
    ['grapesyrup'] 		                            = {['name'] = 'grapesyrup', 			 	  	        ['label'] = 'Grape Syrup', 	                    ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grapesyrup.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grape Syrup For Making Slushies'},
    ['cherrysyrup'] 		                        = {['name'] = 'cherrysyrup', 			 	  	        ['label'] = 'Cherry Syrup', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'cherrysyrup.png', 			                ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Cherry Syrup For Making Slushies'},
   
    --SNACKS
    ['vanillacupcake'] 			                    = {['name'] = 'vanillacupcake', 			 	  	  	['label'] = 'Vanilla Cupcake', 		            ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'vanillacupcake.png', 				        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Vanilla Cupcake'},
    ['chocolatecupcake'] 			                = {['name'] = 'chocolatecupcake', 			 	  	  	['label'] = 'Chocolate Cupcake', 		        ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'chocolatecupcake.png', 				    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Chocolate Cupcake'},
    ['chocolatebar'] 			                    = {['name'] = 'chocolatebar', 			 	  	  	    ['label'] = 'Chocolate Bar', 		            ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'chocolatebar.png', 				        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Chocolate Bar'},
    ['chocolatedoughnut'] 			                = {['name'] = 'chocolatedoughnut', 			 	  	  	['label'] = 'Chocolate Doughnut', 		        ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'chocolatedoughnut.png', 				    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Chocolate Doughnut'},
    ['jamdoughnut'] 			                    = {['name'] = 'jamdoughnut', 			 	  	  	    ['label'] = 'Jam Doughnut', 		            ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'jamdoughnut.png', 				            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Jam Doughnut'},
    ['sugardoughnut'] 			                    = {['name'] = 'sugardoughnut', 			 	  	  	    ['label'] = 'Sugar Doughnut', 		            ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'sugardoughnut.png', 				        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Sugar Doughnut'},
    ['custarddoughnut'] 			                = {['name'] = 'custarddoughnut', 			 	  	  	['label'] = 'Custard Doughnut', 		        ['weight'] = 200, 		['type'] = 'item', 					['image'] = 'custarddoughnut.png', 				        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Custard Doughnut'},
    
    --SLUSHIES
    ['blueraspberryslushie'] 		                = {['name'] = 'blueraspberryslushie', 			 	  	['label'] = 'Blue Raspberry Slushie', 	        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'blueraspberryslushie.png', 			    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Blue Raspberry Slushie'},
    ['tropicalslushie'] 		                    = {['name'] = 'tropicalslushie', 			 	  	    ['label'] = 'Tropical Slushie', 	            ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'tropicalslushie.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Tropical Slushie'},
    ['strawberryslushie'] 		                    = {['name'] = 'strawberryslushie', 			 	  	    ['label'] = 'Strawberry Slushie', 	            ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'strawberryslushie.png', 			        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Strawberry Slushie'},
    ['lemonlimeslushie'] 		                    = {['name'] = 'lemonlimeslushie', 			 	  	    ['label'] = 'Lemon N Lime Slushie', 	        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'lemonlimeslushie.png', 			        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Lemon N Lime Slushie'},
    ['orangeslushie'] 		                        = {['name'] = 'orangeslushie', 			 	  	        ['label'] = 'Orange Slushie', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'orangeslushie.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Orange Slushie'},
    ['grapeslushie'] 		                        = {['name'] = 'grapeslushie', 			 	  	        ['label'] = 'Grape Slushie', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grapeslushie.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grape Slushie'},
    ['cherryslushie'] 		                        = {['name'] = 'cherryslushie', 			 	  	        ['label'] = 'Cherry Slushie', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'cherryslushie.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Cherry Slushie'},
    
    --GRILLED SANDWICHES
    ['grilledcheese'] 		                        = {['name'] = 'grilledcheese', 			 	  	  	    ['label'] = 'Grilled Cheese', 	                ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grilledcheese.png', 			            ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grilled Cheese Sandwich'},
    ['grilledchickenmozzarella'] 		            = {['name'] = 'grilledchickenmozzarella', 			 	['label'] = 'Grilled Chicken & Mozzarella', 	['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grilledchickenmozzarella.png', 			['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grilled Chicken & Mozzarella Sandwich'},
    ['grilledbaconavocado'] 		                = {['name'] = 'grilledbaconavocado', 			 	    ['label'] = 'Grilled Bacon & Avocado', 	        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grilledbaconavocado.png', 			        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grilled Bacon & Avocado Sandwich'},
    ['grilledtunasweetcorn'] 		                = {['name'] = 'grilledtunasweetcorn', 			 	    ['label'] = 'Grilled Tuna & Sweetcorn', 	    ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grilledtunasweetcorn.png', 			    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grilled Tuna & Sweetcorn Sandwich'},
    ['grilledturkeycranberry'] 		                = {['name'] = 'grilledturkeycranberry', 			 	['label'] = 'Grilled Turkey & Cranberry', 	    ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grilledturkeycranberry.png', 			    ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grilled Turkey & Cranberry Sandwich'},
    ['grilledeggsbacon'] 		                    = {['name'] = 'grilledeggsbacon', 			 	        ['label'] = 'Grilled Eggs & Bacon', 	        ['weight'] = 200, 		['type'] = 'item', 				    ['image'] = 'grilledeggsbacon.png', 			        ['unique'] = false, 	    ['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Grilled Eggs & Bacon Sandwich'},



```







