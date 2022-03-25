ITEM = class.Create("base_clothing")

ITEM.Name 					= "Disabled Skynet Control Vest"
ITEM.Description 			= "Worn by humans who have been freed from Skynet control."

ITEM.Model					= Model("models/tnb/trpitems/rebelkit.mdl")

ITEM.ArmorAdd				= 140
ITEM.DamageReduction		= 30

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= -1
ITEM.SellPrice 				= 300

ITEM.Weight 				= 1
ITEM.CarryAdd				= 10

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_slave.mdl")
ITEM.ModelData.skin 		= 1

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_slave.mdl")
ITEM.ModelDataFemale.skin 	= 1
