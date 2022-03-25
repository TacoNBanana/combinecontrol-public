ITEM = class.Create("base_clothing")

ITEM.Name 					= "SOPMOD Combat Rig"
ITEM.Description 			= "Specialist infantry loadout incorporating combat vest, kevlar and rigging."

ITEM.Model					= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd				= 270
ITEM.DamageReduction		= 20


ITEM.Weight 				= 1
ITEM.CarryAdd				= 25

ITEM.Slots 					= {EQUIPMENT_CHEST}

ITEM.ModelData 				= {}
ITEM.ModelData.model 		= Model("models/tnb/techcom/male_fear.mdl")

ITEM.ModelDataFemale 		= {}
ITEM.ModelDataFemale.model 	= Model("models/tnb/techcom/female_fear.mdl")