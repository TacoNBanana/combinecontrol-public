ITEM = class.Create("base_clothing")

ITEM.Name 					= "Combat Jacket with Plate Carrier"
ITEM.Description 			= "Combination of millitary BDUs, shell jacket and a modern desert rig with kevlar."

ITEM.Model					= Model("models/tnb/trpitems/vest.mdl")

ITEM.ArmorAdd				= 100
ITEM.DamageReduction		= 30

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 1000
ITEM.SellPrice 				= 200

ITEM.Weight 				= 2
ITEM.CarryAdd				= 10

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_jacketvest.mdl")
ITEM.ModelData.skin 		= 0

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_jacketvest.mdl")
ITEM.ModelDataFemale.skin 	= 0