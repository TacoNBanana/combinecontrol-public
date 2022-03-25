ITEM = class.Create("base_clothing")

ITEM.Name 					= "Black Leather Flight Uniform (Blairs outfit)"
ITEM.Description 			= "FEMALE ONLY - Tight leather pilots gear."

ITEM.Model					= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd				= 100
ITEM.DamageReduction		= 20

ITEM.BusinessLicense 		= BUSINESS_CLOTHING
ITEM.BuyPrice 				= 6000
ITEM.SellPrice 				= 1000

ITEM.Weight 				= 1
ITEM.CarryAdd				= 15

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_survivor.mdl")
ITEM.ModelData.skin 		= 1

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_blair.mdl") 
ITEM.ModelDataFemale.skin 	= 1