ITEM = class.Create("base_clothing")

ITEM.Name 							= "FBI Kit"
ITEM.Description 					= "Tactical outfit with equipment belt and bullet proof vest."

ITEM.Model							= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd						= 100
ITEM.DamageReduction				= 30

ITEM.Weight 						= 2
ITEM.CarryAdd						= 10

ITEM.Slots 							= {EQUIPMENT_CHEST}

ITEM.ModelData 						= {}
ITEM.ModelData.model 				= Model("models/tnb/zrp/male_swat_h.mdl")
ITEM.ModelData.submaterial1			= "models/tnb/zrp/swat/livery2"
ITEM.ModelData.submaterial2			= "models/tnb/zrp/swat/fbi_armoured_top"
ITEM.ModelData.submaterial3			= "models/tnb/zrp/swat/fbi_armoured_pants"

ITEM.ModelDataFemale 				= {}
ITEM.ModelDataFemale.model 			= Model("models/tnb/zrp/female_swat_h.mdl")
ITEM.ModelDataFemale.submaterial1	= "models/tnb/zrp/swat_female/livery2"
ITEM.ModelDataFemale.submaterial2	= "models/tnb/zrp/swat_female/fbi_armoured_top"
ITEM.ModelDataFemale.submaterial3	= "models/tnb/zrp/swat_female/fbi_armoured_pants"