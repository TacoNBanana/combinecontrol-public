ITEM = class.Create("base_clothing")

ITEM.Name 							= "NYPD Coroner"
ITEM.Description 					= "Shirt uniform"

ITEM.Model							= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd						= 10
ITEM.DamageReduction				= 5

ITEM.Weight 						= 2
ITEM.CarryAdd						= 10

ITEM.Slots 							= {EQUIPMENT_CHEST}

ITEM.ModelData 						= {}
ITEM.ModelData.model 				= Model("models/tnb/zrp/male_coroner.mdl")

ITEM.ModelDataFemale 				= {}
ITEM.ModelDataFemale.model 			= Model("models/tnb/zrp/female_coroner.mdl")