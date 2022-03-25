ITEM = class.Create("base_clothing")

ITEM.Name 					= "Drifter Outfit (Black)"
ITEM.Description 			= "Warm coat with worn boots and jeans."

ITEM.Model					= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd				= 120
ITEM.DamageReduction		= 20

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 2000
ITEM.SellPrice 				= 500

ITEM.Weight 				= 1
ITEM.CarryAdd				= 15

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_drifter.mdl")
ITEM.ModelData.skin 		= 1

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_drifter.mdl") 
ITEM.ModelDataFemale.skin 	= 1