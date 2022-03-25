ITEM = class.Create("base_clothing")

ITEM.Name 							= "Suit with Jacket (Grey with white shirt)"
ITEM.Description 					= "Smart business suit."

ITEM.Model							= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd						= 10
ITEM.DamageReduction				= 5

ITEM.Weight 						= 2
ITEM.CarryAdd						= 10

ITEM.Slots 							= {EQUIPMENT_CHEST}

ITEM.ModelData 						= {}
ITEM.ModelData.model 				= Model("models/tnb/zrp/male_suit.mdl")
ITEM.ModelData.skin 				= 0

ITEM.ModelDataFemale 				= {}
ITEM.ModelDataFemale.model 			= Model("models/tnb/zrp/female_suit.mdl")
ITEM.ModelDataFemale.skin 			= 0