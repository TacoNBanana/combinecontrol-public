ITEM = class.Create("base_clothing")

ITEM.Name 					= "Worker Clothes with Rig (Camo)"
ITEM.Description 			= "Worn by technicians and mechanics."

ITEM.Model					= Model("models/tnb/trpitems/vest.mdl")

ITEM.ArmorAdd				= 100
ITEM.DamageReduction		= 20

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 500
ITEM.SellPrice 				= 100

ITEM.Weight 				= 1
ITEM.CarryAdd				= 15

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_workshirt_vest.mdl")
ITEM.ModelData.skin 		= 1

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_workshirt_vest.mdl") 
ITEM.ModelDataFemale.skin 	= 1