ITEM = class.Create("base_clothing")

ITEM.Name 					= "Damaged Infiltrator Outfit"
ITEM.Description 			= "Dusty jacket over black fatigues."

ITEM.Model					= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

--ITEM.BusinessLicense 			= BUSINESS_CLOTHING
--ITEM.BuyPrice 					= 100
--ITEM.SellPrice 					= 50

ITEM.Weight 				= 0
ITEM.CarryAdd				= 30

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor_infiltrator.mdl")
ITEM.ModelData.skin 		= 0

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_survivor_jacket.mdl") --needs finishing