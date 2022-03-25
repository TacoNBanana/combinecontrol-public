ITEM = class.Create("base_clothing")

ITEM.Name 					= "Black Ranger Kit"
ITEM.Description 			= "Standard infantry loadout incorporating combat vest, kevlar and rigging."

ITEM.Model					= Model("models/tnb/trpitems/vest.mdl")

ITEM.ArmorAdd				= 200
ITEM.DamageReduction		= 20

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 1600
ITEM.SellPrice 				= 300

ITEM.Weight 				= 2
ITEM.CarryAdd				= 15

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_connor.mdl")
ITEM.ModelData.skin 		= 1

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_connor.mdl")
ITEM.ModelDataFemale.skin 	= 1