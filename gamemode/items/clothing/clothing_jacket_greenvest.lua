ITEM = class.Create("base_clothing")

ITEM.Name 					= "Combat Jacket with Recon Vest"
ITEM.Description 			= "Combination of millitary BDUs, shell jacket and a tactical rig with kevlar."

ITEM.Model					= Model("models/tnb/trpitems/vest.mdl")

ITEM.ArmorAdd				= 140
ITEM.DamageReduction		= 30

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 300

ITEM.Weight 				= 2
ITEM.CarryAdd				= 5

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_greenvest.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_greenvest.mdl")
