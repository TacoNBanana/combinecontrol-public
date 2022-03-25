ITEM = class.Create("base_clothing")

ITEM.Name 					= "Militia Fatigues"
ITEM.Description 			= "Combination of millitary BDUs, shell jacket and a tactical rig with kevlar."

ITEM.Model					= Model("models/tnb/trpitems/rebelkit.mdl")

ITEM.ArmorAdd				= 160
ITEM.DamageReduction		= 30

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 2000
ITEM.SellPrice 				= 200

ITEM.Weight 				= 1
ITEM.CarryAdd				= 10

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_militia.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_militia.mdl")
