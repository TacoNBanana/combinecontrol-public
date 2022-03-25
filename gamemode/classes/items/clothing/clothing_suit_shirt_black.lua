ITEM = class.Create("base_clothing")

ITEM.Name 							= "Suit with no Jacket (Black)"
ITEM.Description 					= "Smart business suit."

ITEM.Model							= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd						= 10
ITEM.DamageReduction				= 5

ITEM.Weight 						= 2
ITEM.CarryAdd						= 10

ITEM.Slots 							= {EQUIPMENT_CHEST}

ITEM.ModelData 						= {}
ITEM.ModelData.model 				= Model("models/tnb/zrp/male_suit_shirt.mdl")
ITEM.ModelData.skin 				= 1

ITEM.ModelDataFemale 				= {}
ITEM.ModelDataFemale.model 			= Model("models/tnb/zrp/female_suit_shirt.mdl")
ITEM.ModelDataFemale.skin 			= 1