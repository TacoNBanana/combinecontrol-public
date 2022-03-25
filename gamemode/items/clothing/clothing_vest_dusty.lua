ITEM = class.Create("base_clothing")

ITEM.Name 					= "Dusty Survivor Outfit with MOLLE Plate Carrier"
ITEM.Description 			= "Well-worn fatigues worn under an scavenged US Army rig."

ITEM.Model					= Model("models/tnb/trpitems/vest.mdl")

ITEM.ArmorAdd				= 100
ITEM.DamageReduction		= 20

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 500
ITEM.SellPrice 				= 150

ITEM.Weight 				= 2
ITEM.CarryAdd				= 5

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_vest.mdl")
ITEM.ModelData.skin 		= 1

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_vest.mdl")
ITEM.ModelDataFemale.skin 	= 1