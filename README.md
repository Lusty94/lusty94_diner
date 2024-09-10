## Lusty94_Diner


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

PLEASE MAKE SURE TO READ THIS ENTIRE FILE AS IT COVERS SOME IMPORTANT INFORMATION

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


======================================
SCRIPT SUPPORT VIA DISCORD: https://discord.gg/BJGFrThmA8
======================================



## Features

- Create grilled sandwiches
- Create iced slushies
- Create soft drinks
- Create hot drinks
- Snack bar for customers to buy sweet treats [ inventory shops]
- Sink to wash your hands before working
- Vehicle rental system to deliver food to customers
- Management menu system to hire / fire employees & much more
- Payment till charge customers for orders
- Custom sounds when performing certain actions such as making slushies and making grilled sandwiches [REQUIRES_INTERACT_SOUND]
- Extensive config file
- Support for [ANY] MLO or building - moveable target locations via config file
- Language settings for custom translations



## INSTALLATION


- Add the ##ITEMS snippet below into your core/shared/items.lua file - ox_inventory users add the items to inventory/data/items.lua
- Add all .png images inside [images] folder into your inventory/html/images folder - ox_inventory users place images inside inventory/web/images
- Add the ##JOB snippet below to your core/shared/jobs.lua
- Add all .ogg files inside [interact-sounds] folder into your interact-sound/client/sounds folder



## OX INVENTORY USERS
- items list is at the bottom of this file under ##OX_INVENTORY ITEMS
- this resource creates shops and stashes automatically, to change item names or prices / stash weight or slots edit the respective function in diner_server.lua



## DEPENDENCIES

- [Diner MLO](https://gabzv.com)
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [ox_lib](https://github.com/overextended/ox_lib/releases/)


## INTERACT SOUND

- If set to true in the config then this script uses custom sounds that need to be placed inside of interact-sound resource
- Place ALL .ogg files inside [sounds] folder into your interact-sound/client/html/sounds folder
- Interact sound must be started BEFORE this resource in order to work correctly


## CONSUMABLES

- Set Config.UseJimConsumables to true to enable jim-consumables to handle the useable food and drink items - if getting any issues perhaps set to false and add item names to jim-consuambles itself - if missing any props this is likely due to missing files in your emotes folder

- Make sure jim-consumables starts before this resource as per any dependency


## JOB

```

    diner = {
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



## QB-CORE ITEMS

```


    --DINER
    --REQUIRED ITEMS
    slushiecup 			                        = {name = 'slushiecup', 			 	  	  	    label = 'Slushie Cup', 		                weight = 200, 		type = 'item', 					image = 'slushiecup.png', 				            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'A Cup Used For Making Slushies!'},
    softdrinkscup 			                    = {name = 'softdrinkscup', 			 	  	  	    label = 'Soft Drinks Cup', 		            weight = 200, 		type = 'item', 					image = 'softdrinkscup.png', 				        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Soft Drinks Cup'},
    mug 			                            = {name = 'mug', 			 	  	  	            label = 'Mug', 		                        weight = 200, 		type = 'item', 					image = 'mug.png', 				                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Mug'},
    breadknife 			                        = {name = 'breadknife', 			 	  	  	    label = 'Bread Knife', 		                weight = 200, 		type = 'item', 					image = 'breadknife.png', 				            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'A Sharp Bread Knife'},
	kitchenknife 		                        = {name = 'kitchenknife', 			 	  	  	    label = 'Kitchen Knife', 	                weight = 200, 		type = 'item', 				    image = 'kitchenknife.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'A Sharp Kitchen Knife'},
	
   
    --DRINKS
    tea 			                            = {name = 'tea', 			 	  	  	            label = 'Tea', 		                        weight = 200, 		type = 'item', 					image = 'tea.png', 				                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Hot Tea'},
    coffee 			                            = {name = 'coffee', 			 	  	  	        label = 'Coffee', 		                    weight = 200, 		type = 'item', 					image = 'coffee.png', 				                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Hot Coffee'},
    hotchocolate 			                    = {name = 'hotchocolate', 			 	  	  	    label = 'Hot Chocolate', 		            weight = 200, 		type = 'item', 					image = 'hotchocolate.png', 				        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Hot Chocolate'},
    ecola 			                            = {name = 'ecola', 			 	  	  	            label = 'E-Cola', 		                    weight = 200, 		type = 'item', 					image = 'ecola.png', 				                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'E-Cola'},
    ecolalight 			                        = {name = 'ecolalight', 			 	  	  	    label = 'E-Cola Light', 		            weight = 200, 		type = 'item', 					image = 'ecolalight.png', 				            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'E-Cola Light'},
    sprunk 			                            = {name = 'sprunk', 			 	  	  	        label = 'Sprunk', 		                    weight = 200, 		type = 'item', 					image = 'sprunk.png', 				                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Sprunk'},
    orangesoda 			                        = {name = 'orangesoda', 			 	  	  	    label = 'Orange Soda', 		                weight = 200, 		type = 'item', 					image = 'orangesoda.png', 				            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Orange Soda'},
    
    --INGREDIENTS
    butter 		                                = {name = 'butter', 			 	  	  	        label = 'Butter', 	                        weight = 200, 		type = 'item', 				    image = 'butter.png', 			                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Butter Used For Grilled Sandwiches'},
    crushedice 		                            = {name = 'crushedice', 			 	  	  	    label = 'Crushed Ice', 	                    weight = 200, 		type = 'item', 				    image = 'crushedice.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Crushed Ice For Making Slushies'},
    balsamicglaze 		                        = {name = 'balsamicglaze', 			 	  	  	    label = 'Balsamic Glaze', 	                weight = 200, 		type = 'item', 				    image = 'balsamicglaze.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Balsamic Glaze'},
	cranberrysauce 		                        = {name = 'cranberrysauce', 			 	  	  	label = 'Cranberry Sauce', 	                weight = 200, 		type = 'item', 				    image = 'cranberrysauce.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Cranberry Sauce'},
    mozzarellacheese 		                    = {name = 'mozzarellacheese', 			 	  	  	label = 'Mozzarella Cheese', 	            weight = 200, 		type = 'item', 				    image = 'mozzarellacheese.png', 			        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Mozzarella Cheese'},
	cheeseslice 		                        = {name = 'cheeseslice', 			 	  	  	    label = 'Cheese Slice', 	                weight = 200, 		type = 'item', 				    image = 'cheeseslice.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Cheese Slice'},
    bread 		                                = {name = 'bread', 			 	  	  	            label = 'Bread', 	                        weight = 200, 		type = 'item', 				    image = 'bread.png', 			                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Fresh Bread'},
    slicedbread 		                        = {name = 'slicedbread', 			 	  	  	    label = 'Sliced Bread', 	                weight = 200, 		type = 'item', 				    image = 'slicedbread.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Fresh Sliced Bread'},
	eggs 		                                = {name = 'eggs', 			 	  	  	            label = 'Eggs', 	                        weight = 200, 		type = 'item', 				    image = 'eggs.png', 			                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Eggs'},
    
    --INGREDIENTS
	chickenbreast 						 	    = {name = 'chickenbreast', 			 	  	  		label = 'Chicken Breast', 				    weight = 200, 		type = 'item', 					image = 'chickenbreast.png', 					    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Chicken Breast'},
    bacon 		                                = {name = 'bacon', 			 	  	  	            label = 'Bacon', 	                        weight = 200, 		type = 'item', 				    image = 'bacon.png', 			                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Bacon'},
    slicedbacon 		                        = {name = 'slicedbacon', 			 	  	  	    label = 'Sliced Bacon', 	                weight = 200, 		type = 'item', 				    image = 'slicedbacon.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Sliced Bacon'},
    tuna 		                                = {name = 'tuna', 			 	  	  	            label = 'Tuna', 	                        weight = 200, 		type = 'item', 				    image = 'tuna.png', 			                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Tuna'},
    tunachunks 		                            = {name = 'tunachunks', 			 	  	  	    label = 'Tuna Chunks', 	                    weight = 200, 		type = 'item', 				    image = 'tunachunks.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Tuna Chunks'},
    turkey 		                                = {name = 'turkey', 			 	  	  	        label = 'Turkey', 	                        weight = 200, 		type = 'item', 				    image = 'turkey.png', 			                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Turkey'},
    turkeyslices 		                        = {name = 'turkeyslices', 			 	  	  	    label = 'Turkey Slices', 	                weight = 200, 		type = 'item', 				    image = 'turkeyslices.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Turkey Slices'},
    avocado 		                            = {name = 'avocado', 			 	  	  	        label = 'Avocado', 	                        weight = 200, 		type = 'item', 				    image = 'avocado.png', 			                    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Avocado'},
    slicedavocado 		                        = {name = 'slicedavocado', 			 	  	  	    label = 'Sliced Avocado', 	                weight = 200, 		type = 'item', 				    image = 'slicedavocado.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Sliced Avocado'},
    sweetcorn 		                            = {name = 'sweetcorn', 			 	  	  	        label = 'Sweetcorn', 	                    weight = 200, 		type = 'item', 				    image = 'sweetcorn.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Sweetcorn'},
    
    --SYRUPS
    blueraspberrysyrup 		                    = {name = 'blueraspberrysyrup', 			 	  	label = 'Blue Raspberry Syrup', 	        weight = 200, 		type = 'item', 				    image = 'blueraspberrysyrup.png', 			        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Blue Raspberry Syrup For Making Slushies'},
    tropicalsyrup 		                        = {name = 'tropicalsyrup', 			 	  	        label = 'Tropical Syrup', 	                weight = 200, 		type = 'item', 				    image = 'tropicalsyrup.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Tropical Syrup For Making Slushies'},
    strawberrysyrup 		                    = {name = 'strawberrysyrup', 			 	  	    label = 'Strawberry Syrup', 	            weight = 200, 		type = 'item', 				    image = 'strawberrysyrup.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Strawberry Syrup For Making Slushies'},
    lemonlimesyrup 		                        = {name = 'lemonlimesyrup', 			 	  	    label = 'Lemon N Lime Syrup', 	            weight = 200, 		type = 'item', 				    image = 'lemonlimesyrup.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Lemon N Lime Syrup For Making Slushies'},
    orangesyrup 		                        = {name = 'orangesyrup', 			 	  	        label = 'Orange Syrup', 	                weight = 200, 		type = 'item', 				    image = 'orangesyrup.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Orange Syrup For Making Slushies'},
    grapesyrup 		                            = {name = 'grapesyrup', 			 	  	        label = 'Grape Syrup', 	                    weight = 200, 		type = 'item', 				    image = 'grapesyrup.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grape Syrup For Making Slushies'},
    cherrysyrup 		                        = {name = 'cherrysyrup', 			 	  	        label = 'Cherry Syrup', 	                weight = 200, 		type = 'item', 				    image = 'cherrysyrup.png', 			                unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Cherry Syrup For Making Slushies'},
   
    --SNACKS
    vanillacupcake 			                    = {name = 'vanillacupcake', 			 	  	  	label = 'Vanilla Cupcake', 		            weight = 200, 		type = 'item', 					image = 'vanillacupcake.png', 				        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Vanilla Cupcake'},
    chocolatecupcake 			                = {name = 'chocolatecupcake', 			 	  	  	label = 'Chocolate Cupcake', 		        weight = 200, 		type = 'item', 					image = 'chocolatecupcake.png', 				    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Chocolate Cupcake'},
    chocolatebar 			                    = {name = 'chocolatebar', 			 	  	  	    label = 'Chocolate Bar', 		            weight = 200, 		type = 'item', 					image = 'chocolatebar.png', 				        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Chocolate Bar'},
    chocolatedoughnut 			                = {name = 'chocolatedoughnut', 			 	  	  	label = 'Chocolate Doughnut', 		        weight = 200, 		type = 'item', 					image = 'chocolatedoughnut.png', 				    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Chocolate Doughnut'},
    jamdoughnut 			                    = {name = 'jamdoughnut', 			 	  	  	    label = 'Jam Doughnut', 		            weight = 200, 		type = 'item', 					image = 'jamdoughnut.png', 				            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Jam Doughnut'},
    sugardoughnut 			                    = {name = 'sugardoughnut', 			 	  	  	    label = 'Sugar Doughnut', 		            weight = 200, 		type = 'item', 					image = 'sugardoughnut.png', 				        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Sugar Doughnut'},
    custarddoughnut 			                = {name = 'custarddoughnut', 			 	  	  	label = 'Custard Doughnut', 		        weight = 200, 		type = 'item', 					image = 'custarddoughnut.png', 				        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Custard Doughnut'},
    
    --SLUSHIES
    blueraspberryslushie 		                = {name = 'blueraspberryslushie', 			 	  	label = 'Blue Raspberry Slushie', 	        weight = 200, 		type = 'item', 				    image = 'blueraspberryslushie.png', 			    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Blue Raspberry Slushie'},
    tropicalslushie 		                    = {name = 'tropicalslushie', 			 	  	    label = 'Tropical Slushie', 	            weight = 200, 		type = 'item', 				    image = 'tropicalslushie.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Tropical Slushie'},
    strawberryslushie 		                    = {name = 'strawberryslushie', 			 	  	    label = 'Strawberry Slushie', 	            weight = 200, 		type = 'item', 				    image = 'strawberryslushie.png', 			        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Strawberry Slushie'},
    lemonlimeslushie 		                    = {name = 'lemonlimeslushie', 			 	  	    label = 'Lemon N Lime Slushie', 	        weight = 200, 		type = 'item', 				    image = 'lemonlimeslushie.png', 			        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Lemon N Lime Slushie'},
    orangeslushie 		                        = {name = 'orangeslushie', 			 	  	        label = 'Orange Slushie', 	                weight = 200, 		type = 'item', 				    image = 'orangeslushie.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Orange Slushie'},
    grapeslushie 		                        = {name = 'grapeslushie', 			 	  	        label = 'Grape Slushie', 	                weight = 200, 		type = 'item', 				    image = 'grapeslushie.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grape Slushie'},
    cherryslushie 		                        = {name = 'cherryslushie', 			 	  	        label = 'Cherry Slushie', 	                weight = 200, 		type = 'item', 				    image = 'cherryslushie.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Cherry Slushie'},
    
    --GRILLED SANDWICHES
    grilledcheese 		                        = {name = 'grilledcheese', 			 	  	  	    label = 'Grilled Cheese', 	                weight = 200, 		type = 'item', 				    image = 'grilledcheese.png', 			            unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grilled Cheese Sandwich'},
    grilledchickenmozzarella 		            = {name = 'grilledchickenmozzarella', 			 	label = 'Grilled Chicken & Mozzarella', 	weight = 200, 		type = 'item', 				    image = 'grilledchickenmozzarella.png', 			unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grilled Chicken & Mozzarella Sandwich'},
    grilledbaconavocado 		                = {name = 'grilledbaconavocado', 			 	    label = 'Grilled Bacon & Avocado', 	        weight = 200, 		type = 'item', 				    image = 'grilledbaconavocado.png', 			        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grilled Bacon & Avocado Sandwich'},
    grilledtunasweetcorn 		                = {name = 'grilledtunasweetcorn', 			 	    label = 'Grilled Tuna & Sweetcorn', 	    weight = 200, 		type = 'item', 				    image = 'grilledtunasweetcorn.png', 			    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grilled Tuna & Sweetcorn Sandwich'},
    grilledturkeycranberry 		                = {name = 'grilledturkeycranberry', 			 	label = 'Grilled Turkey & Cranberry', 	    weight = 200, 		type = 'item', 				    image = 'grilledturkeycranberry.png', 			    unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grilled Turkey & Cranberry Sandwich'},
    grilledeggsbacon 		                    = {name = 'grilledeggsbacon', 			 	        label = 'Grilled Eggs & Bacon', 	        weight = 200, 		type = 'item', 				    image = 'grilledeggsbacon.png', 			        unique = false, 	    useable = true, 	shouldClose = true,   combinable = nil,   description = 'Grilled Eggs & Bacon Sandwich'},


```


## OX_INVENTORY ITEMS

```

["ecolalight"] = {
		label = "E-Cola Light",
		weight = 200,
		stack = true,
		close = true,
		description = "E-Cola Light",
		client = {
			image = "ecolalight.png",
		}
	},

	["tropicalsyrup"] = {
		label = "Tropical Syrup",
		weight = 200,
		stack = true,
		close = true,
		description = "Tropical Syrup For Making Slushies",
		client = {
			image = "tropicalsyrup.png",
		}
	},

	["softdrinkscup"] = {
		label = "Soft Drinks Cup",
		weight = 200,
		stack = true,
		close = true,
		description = "Soft Drinks Cup",
		client = {
			image = "softdrinkscup.png",
		}
	},

	["turkey"] = {
		label = "Turkey",
		weight = 200,
		stack = true,
		close = true,
		description = "Turkey",
		client = {
			image = "turkey.png",
		}
	},

	["blueraspberrysyrup"] = {
		label = "Blue Raspberry Syrup",
		weight = 200,
		stack = true,
		close = true,
		description = "Blue Raspberry Syrup For Making Slushies",
		client = {
			image = "blueraspberrysyrup.png",
		}
	},

	["grilledturkeycranberry"] = {
		label = "Grilled Turkey & Cranberry",
		weight = 200,
		stack = true,
		close = true,
		description = "Grilled Turkey & Cranberry Sandwich",
		client = {
			image = "grilledturkeycranberry.png",
		}
	},

	["cranberrysauce"] = {
		label = "Cranberry Sauce",
		weight = 200,
		stack = true,
		close = true,
		description = "Cranberry Sauce",
		client = {
			image = "cranberrysauce.png",
		}
	},

	["jamdoughnut"] = {
		label = "Jam Doughnut",
		weight = 200,
		stack = true,
		close = true,
		description = "Jam Doughnut",
		client = {
			image = "jamdoughnut.png",
		}
	},

	["vanillacupcake"] = {
		label = "Vanilla Cupcake",
		weight = 200,
		stack = true,
		close = true,
		description = "Vanilla Cupcake",
		client = {
			image = "vanillacupcake.png",
		}
	},

	["chocolatebar"] = {
		label = "Chocolate Bar",
		weight = 200,
		stack = true,
		close = true,
		description = "Chocolate Bar",
		client = {
			image = "chocolatebar.png",
		}
	},

	["orangesoda"] = {
		label = "Orange Soda",
		weight = 200,
		stack = true,
		close = true,
		description = "Orange Soda",
		client = {
			image = "orangesoda.png",
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "Hot Coffee",
		client = {
			image = "coffee.png",
		}
	},

	["chocolatedoughnut"] = {
		label = "Chocolate Doughnut",
		weight = 200,
		stack = true,
		close = true,
		description = "Chocolate Doughnut",
		client = {
			image = "chocolatedoughnut.png",
		}
	},

	["lemonlimesyrup"] = {
		label = "Lemon N Lime Syrup",
		weight = 200,
		stack = true,
		close = true,
		description = "Lemon N Lime Syrup For Making Slushies",
		client = {
			image = "lemonlimesyrup.png",
		}
	},

	["cheeseslice"] = {
		label = "Cheese Slice",
		weight = 200,
		stack = true,
		close = true,
		description = "Cheese Slice",
		client = {
			image = "cheeseslice.png",
		}
	},

	["tropicalslushie"] = {
		label = "Tropical Slushie",
		weight = 200,
		stack = true,
		close = true,
		description = "Tropical Slushie",
		client = {
			image = "tropicalslushie.png",
		}
	},

	["cherrysyrup"] = {
		label = "Cherry Syrup",
		weight = 200,
		stack = true,
		close = true,
		description = "Cherry Syrup For Making Slushies",
		client = {
			image = "cherrysyrup.png",
		}
	},

	["grilledeggsbacon"] = {
		label = "Grilled Eggs & Bacon",
		weight = 200,
		stack = true,
		close = true,
		description = "Grilled Eggs & Bacon Sandwich",
		client = {
			image = "grilledeggsbacon.png",
		}
	},

	["crushedice"] = {
		label = "Crushed Ice",
		weight = 200,
		stack = true,
		close = true,
		description = "Crushed Ice For Making Slushies",
		client = {
			image = "crushedice.png",
		}
	},

	["slicedavocado"] = {
		label = "Sliced Avocado",
		weight = 200,
		stack = true,
		close = true,
		description = "Sliced Avocado",
		client = {
			image = "slicedavocado.png",
		}
	},

	["hotchocolate"] = {
		label = "Hot Chocolate",
		weight = 200,
		stack = true,
		close = true,
		description = "Hot Chocolate",
		client = {
			image = "hotchocolate.png",
		}
	},

	["tuna"] = {
		label = "Tuna",
		weight = 200,
		stack = true,
		close = true,
		description = "Tuna",
		client = {
			image = "tuna.png",
		}
	},

	["butter"] = {
		label = "Butter",
		weight = 200,
		stack = true,
		close = true,
		description = "Butter Used For Grilled Sandwiches",
		client = {
			image = "butter.png",
		}
	},

	["turkeyslices"] = {
		label = "Turkey Slices",
		weight = 200,
		stack = true,
		close = true,
		description = "Turkey Slices",
		client = {
			image = "turkeyslices.png",
		}
	},

	["grilledcheese"] = {
		label = "Grilled Cheese",
		weight = 200,
		stack = true,
		close = true,
		description = "Grilled Cheese Sandwich",
		client = {
			image = "grilledcheese.png",
		}
	},

	["cherryslushie"] = {
		label = "Cherry Slushie",
		weight = 200,
		stack = true,
		close = true,
		description = "Cherry Slushie",
		client = {
			image = "cherryslushie.png",
		}
	},

	["slicedbacon"] = {
		label = "Sliced Bacon",
		weight = 200,
		stack = true,
		close = true,
		description = "Sliced Bacon",
		client = {
			image = "slicedbacon.png",
		}
	},

	["chocolatecupcake"] = {
		label = "Chocolate Cupcake",
		weight = 200,
		stack = true,
		close = true,
		description = "Chocolate Cupcake",
		client = {
			image = "chocolatecupcake.png",
		}
	},

	["grilledtunasweetcorn"] = {
		label = "Grilled Tuna & Sweetcorn",
		weight = 200,
		stack = true,
		close = true,
		description = "Grilled Tuna & Sweetcorn Sandwich",
		client = {
			image = "grilledtunasweetcorn.png",
		}
	},

	["slushiecup"] = {
		label = "Slushie Cup",
		weight = 200,
		stack = true,
		close = true,
		description = "A Cup Used For Making Slushies!",
		client = {
			image = "slushiecup.png",
		}
	},

	["ecola"] = {
		label = "E-Cola",
		weight = 200,
		stack = true,
		close = true,
		description = "E-Cola",
		client = {
			image = "ecola.png",
		}
	},

	["grapesyrup"] = {
		label = "Grape Syrup",
		weight = 200,
		stack = true,
		close = true,
		description = "Grape Syrup For Making Slushies",
		client = {
			image = "grapesyrup.png",
		}
	},

	["orangesyrup"] = {
		label = "Orange Syrup",
		weight = 200,
		stack = true,
		close = true,
		description = "Orange Syrup For Making Slushies",
		client = {
			image = "orangesyrup.png",
		}
	},

	["slicedbread"] = {
		label = "Sliced Bread",
		weight = 200,
		stack = true,
		close = true,
		description = "Fresh Sliced Bread",
		client = {
			image = "slicedbread.png",
		}
	},

	["bread"] = {
		label = "Bread",
		weight = 200,
		stack = true,
		close = true,
		description = "Fresh Bread",
		client = {
			image = "bread.png",
		}
	},

	["chickenbreast"] = {
		label = "Chicken Breast",
		weight = 200,
		stack = true,
		close = true,
		description = "Chicken Breast",
		client = {
			image = "chickenbreast.png",
		}
	},

	["sweetcorn"] = {
		label = "Sweetcorn",
		weight = 200,
		stack = true,
		close = true,
		description = "Sweetcorn",
		client = {
			image = "sweetcorn.png",
		}
	},

	["custarddoughnut"] = {
		label = "Custard Doughnut",
		weight = 200,
		stack = true,
		close = true,
		description = "Custard Doughnut",
		client = {
			image = "custarddoughnut.png",
		}
	},

	["tunachunks"] = {
		label = "Tuna Chunks",
		weight = 200,
		stack = true,
		close = true,
		description = "Tuna Chunks",
		client = {
			image = "tunachunks.png",
		}
	},

	["grapeslushie"] = {
		label = "Grape Slushie",
		weight = 200,
		stack = true,
		close = true,
		description = "Grape Slushie",
		client = {
			image = "grapeslushie.png",
		}
	},

	["lemonlimeslushie"] = {
		label = "Lemon N Lime Slushie",
		weight = 200,
		stack = true,
		close = true,
		description = "Lemon N Lime Slushie",
		client = {
			image = "lemonlimeslushie.png",
		}
	},

	["tea"] = {
		label = "Tea",
		weight = 200,
		stack = true,
		close = true,
		description = "Hot Tea",
		client = {
			image = "tea.png",
		}
	},

	["bacon"] = {
		label = "Bacon",
		weight = 200,
		stack = true,
		close = true,
		description = "Bacon",
		client = {
			image = "bacon.png",
		}
	},

	["grilledbaconavocado"] = {
		label = "Grilled Bacon & Avocado",
		weight = 200,
		stack = true,
		close = true,
		description = "Grilled Bacon & Avocado Sandwich",
		client = {
			image = "grilledbaconavocado.png",
		}
	},

	["sprunk"] = {
		label = "Sprunk",
		weight = 200,
		stack = true,
		close = true,
		description = "Sprunk",
		client = {
			image = "sprunk.png",
		}
	},

	["sugardoughnut"] = {
		label = "Sugar Doughnut",
		weight = 200,
		stack = true,
		close = true,
		description = "Sugar Doughnut",
		client = {
			image = "sugardoughnut.png",
		}
	},

	["avocado"] = {
		label = "Avocado",
		weight = 200,
		stack = true,
		close = true,
		description = "Avocado",
		client = {
			image = "avocado.png",
		}
	},

	["balsamicglaze"] = {
		label = "Balsamic Glaze",
		weight = 200,
		stack = true,
		close = true,
		description = "Balsamic Glaze",
		client = {
			image = "balsamicglaze.png",
		}
	},

	["strawberryslushie"] = {
		label = "Strawberry Slushie",
		weight = 200,
		stack = true,
		close = true,
		description = "Strawberry Slushie",
		client = {
			image = "strawberryslushie.png",
		}
	},

	["strawberrysyrup"] = {
		label = "Strawberry Syrup",
		weight = 200,
		stack = true,
		close = true,
		description = "Strawberry Syrup For Making Slushies",
		client = {
			image = "strawberrysyrup.png",
		}
	},

	["grilledchickenmozzarella"] = {
		label = "Grilled Chicken & Mozzarella",
		weight = 200,
		stack = true,
		close = true,
		description = "Grilled Chicken & Mozzarella Sandwich",
		client = {
			image = "grilledchickenmozzarella.png",
		}
	},

	["eggs"] = {
		label = "Eggs",
		weight = 200,
		stack = true,
		close = true,
		description = "Eggs",
		client = {
			image = "eggs.png",
		}
	},

	["breadknife"] = {
		label = "Bread Knife",
		weight = 200,
		stack = true,
		close = true,
		description = "A Sharp Bread Knife",
		client = {
			image = "breadknife.png",
		}
	},

	["mug"] = {
		label = "Mug",
		weight = 200,
		stack = true,
		close = true,
		description = "Mug",
		client = {
			image = "mug.png",
		}
	},

	["orangeslushie"] = {
		label = "Orange Slushie",
		weight = 200,
		stack = true,
		close = true,
		description = "Orange Slushie",
		client = {
			image = "orangeslushie.png",
		}
	},

	["blueraspberryslushie"] = {
		label = "Blue Raspberry Slushie",
		weight = 200,
		stack = true,
		close = true,
		description = "Blue Raspberry Slushie",
		client = {
			image = "blueraspberryslushie.png",
		}
	},

	["mozzarellacheese"] = {
		label = "Mozzarella Cheese",
		weight = 200,
		stack = true,
		close = true,
		description = "Mozzarella Cheese",
		client = {
			image = "mozzarellacheese.png",
		}
	},

	["kitchenknife"] = {
		label = "Kitchen Knife",
		weight = 200,
		stack = true,
		close = true,
		description = "A Sharp Kitchen Knife",
		client = {
			image = "kitchenknife.png",
		}
	},


```




