ITEM = class.Create("base_clothing")

ITEM.Name 							= "FBI Field Jacket"
ITEM.Description 					= "Bomber jacket with equipment belt and stab vest."

ITEM.Model							= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd						= 100
ITEM.DamageReduction				= 30

ITEM.Weight 						= 2
ITEM.CarryAdd						= 10

ITEM.Slots 							= {EQUIPMENT_CHEST}

ITEM.ModelData 						= {}
ITEM.ModelData.model 				= Model("models/tnb/zrp/male_fbi.mdl")

ITEM.ModelDataFemale 				= {}
ITEM.ModelDataFemale.model 			= Model("models/tnb/zrp/female_fbi.mdl")