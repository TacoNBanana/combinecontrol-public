ITEM = class.Create("base_clothing")

ITEM.Name 				= "Exoskeleton - 4th Gen Lite Chasis"
ITEM.Description 		= "Experimental infantry suit designed to allow soldiers to compete with drones in close combat."

ITEM.Model				= Model("models/props_c17/SuitCase_Passenger_Physics.mdl")

ITEM.ArmorAdd			= 300
ITEM.DamageReduction	= 15

ITEM.Weight 			= 2

ITEM.Slots 				= {EQUIPMENT_EXO}

ITEM.ModelData 			= {}
ITEM.ModelData.model 	= Model("models/tnb/techcom/exoskeleton_lite.mdl")

function ITEM:GetSpeeds(ply, w, r, j, c)
	return w, r, j, c
end