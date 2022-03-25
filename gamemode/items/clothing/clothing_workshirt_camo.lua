ITEM = class.Create("base_clothing")

ITEM.Name 					= "Worker Clothes (Camo)"
ITEM.Description 			= "Worn by technicians and mechanics."

ITEM.Model					= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd				= 50
ITEM.DamageReduction		= 10

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 100
ITEM.SellPrice 				= 50

ITEM.Weight 				= 1
ITEM.CarryAdd				= 15

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_workshirt.mdl")
ITEM.ModelData.skin 		= 1

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_workshirt.mdl") 
ITEM.ModelDataFemale.skin 	= 1